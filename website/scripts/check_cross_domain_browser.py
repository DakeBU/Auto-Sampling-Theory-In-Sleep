#!/usr/bin/env python3
"""Browser smoke checks. --offline-dom checks layout/graph only, not CDN math.

CI uses real HTTP navigation and the same external MathJax script as the site.
No browser dependency or new renderer is shipped to readers.
"""
from __future__ import annotations
import argparse
import functools
import http.server
import json
import re
import shutil
import threading
from pathlib import Path
from urllib.parse import parse_qs, urlsplit
from playwright.sync_api import sync_playwright

ROOT = Path(__file__).resolve().parents[2]


def main() -> None:
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',default=str(ROOT/'_site'))
    parser.add_argument('--evidence',default=str(ROOT/'_browser-evidence'))
    parser.add_argument('--offline-dom',action='store_true')
    args=parser.parse_args()
    site=Path(args.output).resolve(); evidence=Path(args.evidence).resolve(); evidence.mkdir(parents=True,exist_ok=True)
    server=None; report={'mode':'offline DOM; CDN and alias not tested' if args.offline_dom else 'HTTP, MathJax and graph interaction','pages':[],'runtime_errors':[]}
    if not args.offline_dom:
        handler=functools.partial(http.server.SimpleHTTPRequestHandler,directory=str(site))
        server=http.server.ThreadingHTTPServer(('127.0.0.1',0),handler)
        threading.Thread(target=server.serve_forever,daemon=True).start()
    try:
        with sync_playwright() as p:
            executable=shutil.which('chromium') if args.offline_dom else None
            browser=p.chromium.launch(executable_path=executable,headless=True,args=['--no-sandbox'])
            page=browser.new_page(viewport={'width':1600,'height':1050})
            page.on('pageerror',lambda e:report['runtime_errors'].append(str(e)))
            def goto(rel: str) -> None:
                if not args.offline_dom:
                    page.goto(f'http://127.0.0.1:{server.server_port}/{rel}',wait_until='domcontentloaded')
                    return
                path=site/urlsplit(rel).path; text=path.read_text(encoding='utf-8')
                text=re.sub(r'<script\b.*?</script>','',text,flags=re.S)
                def inline_css(css: Path) -> str:
                    # Resolve local imports for a genuine offline layout check.
                    text=css.read_text(encoding='utf-8')
                    def dependency(m):
                        ref=m.group(1)
                        if ref.startswith(('http:', 'https:')): return ''
                        return inline_css((css.parent/ref).resolve())
                    return re.sub(r'@import\s+url\([\"\']([^\"\']+)[\"\']\);',dependency,text)
                def style(m):
                    css=(path.parent/m.group(1)).resolve()
                    return '<style>'+inline_css(css)+'</style>' if css.exists() else ''
                text=re.sub(r'<link\s+rel="stylesheet"\s+href="([^"]+)"[^>]*>',style,text)
                page.set_content(text,wait_until='domcontentloaded')
                if urlsplit(rel).path=='lean-foundations.html':
                    graph=json.loads((site/'data/underlying-lean-graph.json').read_text())
                    page.evaluate('g => { window.fetch = async () => ({ok:true,json:async()=>g}); }',graph)
                    page.add_script_tag(content=(site/'assets/underlying-lean-graph.js').read_text())
            for rel,name in [('index.html','home'),('libraries/statistical-optimal-transport/index.html','ot'),('progress/index.html#optimal-transport','progress'),('lean-foundations.html?view=functor','functor')]:
                goto(rel)
                page.wait_for_timeout(250)
                assert page.locator('.library-source-hubs > a').count()==5
                assert page.locator('.progress-route-nav > a').count()==5
                assert page.locator('h1').count()==1
                if name=='functor':
                    page.wait_for_selector('.ulg-node')
                    # The canvas also records data-view; select the actual toolbar button.
                    if not args.offline_dom:
                        page.wait_for_function('Boolean(window.MathJax?.startup?.promise)')
                        page.evaluate('() => MathJax.startup.promise')
                    page.locator('button[data-view="functor"]').click()
                    page.locator('[data-functor-jump="transport:gibbs-prox"]').first.click()
                    assert 'ALL inputs:' in page.locator('[data-graph-detail]').inner_text()
                    assert 'not-Lean-certified' in page.locator('[data-graph-detail]').inner_text()
                    assert 'Conceptual families:' in page.locator('[data-graph-detail]').inner_text()
                    if not args.offline_dom:
                        # Family cards intentionally repeat bridge buttons. Check each
                        # unique typed transport exactly once and derive the expected
                        # count from the source model rather than a stale constant.
                        jump_ids=page.locator('[data-functor-jump]').evaluate_all(
                            '(nodes) => [...new Set(nodes.map(n => n.dataset.functorJump))]')
                        expected=len(json.loads((ROOT/'website/content/functor_hypergraph.json').read_text())['hyperedges'])
                        assert len(jump_ids)==expected,(len(jump_ids),expected)
                        for jump_id in jump_ids:
                            page.locator(f'[data-functor-jump="{jump_id}"]').first.click()
                            page.wait_for_selector('[data-graph-detail] .ulg-formula mjx-container')
                            assert page.locator('[data-graph-detail] mjx-merror').count()==0, jump_id
                            assert not page.locator('[data-graph-detail] .ulg-formula').evaluate(
                                '(node) => node.scrollWidth > node.clientWidth + 1'), jump_id
                        report['graph_mathjax_rendered']=True
                        report['graph_formulas_checked']=len(jump_ids)
                        page.locator('[data-functor-jump="transport:gibbs-prox"]').first.click()
                        page.wait_for_selector('[data-graph-detail] .ulg-formula mjx-container')
                    page.locator('[data-graph-canvas]').scroll_into_view_if_needed()
                    # All conceptual incidence edges remain overlays, not formal.
                    assert page.locator('.ulg-edge[data-relation="joint conceptual input"][data-evidence="formal"]').count()==0
                page.screenshot(path=str(evidence/(name+'.png')))
                overflow=page.evaluate('document.documentElement.scrollWidth > innerWidth + 1')
                assert not overflow, f'Horizontal overflow: {rel}'
                report['pages'].append({'page':rel,'libraries':5,'routes':5,'horizontal_overflow':overflow})
            if not args.offline_dom:
                goto('underlying-lean-graph/index.html?view=functor&focus=transport:dirac')
                page.wait_for_url(lambda url: urlsplit(url).path.endswith('/lean-foundations.html')
                                  and parse_qs(urlsplit(url).query).get('view')==['functor']
                                  and parse_qs(urlsplit(url).query).get('focus')==['transport:dirac'])
                page.wait_for_selector('.ulg-node')
                page.wait_for_function('document.querySelector("[data-graph-detail]").textContent.includes("Deterministic maps")')
                report['query_preserving_alias']=True
            goto('libraries/statistical-optimal-transport/chapter-01.html')
            if not args.offline_dom:
                page.wait_for_selector('mjx-container',timeout=30000)
                assert page.locator('mjx-merror').count()==0, 'MathJax parse error'
                report['mathjax_rendered']=True
            page.set_viewport_size({'width':412,'height':915})
            page.screenshot(path=str(evidence/'ot-mobile.png'))
            assert not page.evaluate('document.documentElement.scrollWidth > innerWidth + 1'), 'Mobile OT overflow'
            report['mobile_ot_overflow']=False
            assert not report['runtime_errors'],report['runtime_errors']
            browser.close()
    except Exception as error:
        report['failure']=repr(error)
        raise
    finally:
        if server: server.shutdown()
        (evidence/'report.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(report,indent=2))


if __name__=='__main__':
    main()
