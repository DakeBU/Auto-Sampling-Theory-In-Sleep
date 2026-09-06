#!/usr/bin/env python3
"""Real HTTP/CDN browser checks for the exported review reader."""
import argparse, functools, http.server, json, threading
from pathlib import Path
from playwright.sync_api import sync_playwright
ap=argparse.ArgumentParser();ap.add_argument('root',type=Path);ap.add_argument('--evidence',type=Path,required=True);a=ap.parse_args()
root=a.root.resolve();a.evidence.mkdir(parents=True,exist_ok=True)
server=http.server.ThreadingHTTPServer(('127.0.0.1',0),functools.partial(http.server.SimpleHTTPRequestHandler,directory=str(root)))
threading.Thread(target=server.serve_forever,daemon=True).start()
result={'status':'passed','mode':'HTTP + CDN MathJax','views':[],'formulas_checked':0,'errors':[]}
try:
 with sync_playwright() as p:
  b=p.chromium.launch(headless=True,args=['--no-sandbox'])
  page=b.new_page(viewport={'width':1600,'height':1080})
  page.on('pageerror',lambda e:result['errors'].append(str(e)))
  for view in ['overview','lean','functor']:
   page.goto(f'http://127.0.0.1:{server.server_port}/lean-foundations.html?view={view}',wait_until='domcontentloaded')
   page.wait_for_selector('.ulg-node')
   assert page.locator('button[data-view]').count()==3
   if view=='functor':
    ids=list(dict.fromkeys(page.locator('[data-functor-jump]').evaluate_all('(ns)=>ns.map(n=>n.dataset.functorJump)')))
    assert len(ids)==13
    for ident in ids:
     page.locator(f'[data-functor-jump="{ident}"]').first.click()
     assert 'not-Lean-certified' in page.locator('[data-graph-detail]').inner_text()
     page.wait_for_selector('[data-graph-detail] .ulg-formula mjx-container',timeout=60000)
     assert page.locator('[data-graph-detail] mjx-merror').count()==0,ident
     assert not page.locator('[data-graph-detail] .ulg-formula').evaluate('(n)=>n.scrollWidth>n.clientWidth+1'),ident
     result['formulas_checked']+=1
    page.locator('[data-functor-jump="transport:pl-lsi"]').first.click()
    page.wait_for_selector('[data-graph-detail] .ulg-formula mjx-container')
   page.locator('[data-graph-canvas]').scroll_into_view_if_needed()
   assert not page.evaluate('document.documentElement.scrollWidth>innerWidth+1'),view
   page.screenshot(path=str(a.evidence/(view+'.png')))
   result['views'].append(view)
  for rel in ['index.html','sources.html','case-study.html','protocol.html']:
   page.goto(f'http://127.0.0.1:{server.server_port}/{rel}',wait_until='domcontentloaded')
   assert page.locator('h1').count()==1,rel
  page.goto(f'http://127.0.0.1:{server.server_port}/case-study.html',wait_until='domcontentloaded')
  page.wait_for_selector('mjx-container')
  assert page.locator('mjx-merror').count()==0
  page.set_viewport_size({'width':412,'height':915})
  page.goto(f'http://127.0.0.1:{server.server_port}/lean-foundations.html?view=functor',wait_until='domcontentloaded')
  page.wait_for_selector('.ulg-node')
  assert not page.evaluate('document.documentElement.scrollWidth>innerWidth+1'),'mobile'
  page.screenshot(path=str(a.evidence/'mobile.png'))
  assert not result['errors'],result['errors']
  b.close()
except Exception as e:
 result.update(status='failed',failure=repr(e));raise
finally:
 server.shutdown();(a.evidence/'browser-report.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
