(() => {
  "use strict";
  const host = document.querySelector("[data-underlying-lean-graph]");
  if (!host) return;
  const canvas = document.querySelector("[data-graph-canvas]");
  const svg = document.querySelector("[data-graph-svg]");
  const detail = document.querySelector("[data-graph-detail]");
  const search = document.querySelector("[data-graph-search]");
  const count = document.querySelector("[data-graph-count]");
  const empty = document.querySelector("[data-graph-empty]");
  const buttons = [...document.querySelectorAll("[data-view]")];
  const NS = "http://www.w3.org/2000/svg";
  const state = {view: "overview", query: "", focus: "", expanded: new Set(), scale: 0.82, x: 32, y: 36, drag: null};
  const kindOrder = {library: 0, "proof-root": 1, chapter: 2, setting: 2, phase: 2, "source-claim": 3, "frontier-case": 3, module: 3, "proof-leaf": 4, declaration: 4};
  const kindLabel = {library: "library", "proof-root": "shared root", chapter: "book chapter", setting: "SampleWiki setting", phase: "formalization phase", "source-claim": "source theorem", "frontier-case": "frontier theorem", module: "Lean module", "proof-leaf": "proof leaf", declaration: "Lean declaration"};
  const viewKinds = {
    overview: new Set(["library", "proof-root", "chapter", "setting", "phase", "frontier-case"]),
    textbook: new Set(["library", "proof-root", "chapter", "source-claim", "proof-leaf"]),
    frontier: new Set(["library", "proof-root", "chapter", "setting", "phase", "frontier-case"]),
    lean: new Set(["library", "proof-root", "module", "declaration", "proof-leaf", "source-claim"]),
  };
  // Only relations extracted from Lean/module/declaration structure are drawn as
  // solid edges. Everything else is an audited/curated reader overlay and stays
  // dashed so the visualization never upgrades exposition into a Lean fact.
  const FORMAL_RELATIONS = new Set(["imports", "declares", "depends-on", "closes leaf"]);
  let graph, nodes, incident, degree;

  const esc = value => String(value ?? "").replace(/[&<>"']/g, c => ({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[c]));
  const svgEl = (name, attrs = {}) => { const el = document.createElementNS(NS, name); Object.entries(attrs).forEach(([k,v]) => el.setAttribute(k, v)); return el; };
  const neighbors = id => [...(incident.get(id) || [])].map(e => e.source === id ? e.target : e.source);
  const edgeSetFor = ids => graph.edges.filter(e => ids.has(e.source) && ids.has(e.target));
  const relationEvidence = relation => FORMAL_RELATIONS.has(String(relation || "")) ? "formal" : "overlay";
  const wrap = (value, width = 24, lines = 2) => {
    const words = String(value || "").split(/\s+/); const out = []; let line = "";
    for (const word of words) { const next = line ? `${line} ${word}` : word; if (next.length > width && line) { out.push(line); line = word; if (out.length === lines - 1) break; } else line = next; }
    if (line && out.length < lines) out.push(line); const used = out.join(" ").length; if (used < String(value || "").length && out.length) out[out.length - 1] = out[out.length - 1].replace(/[. ]+$/, "") + "…"; return out;
  };

  function viewIds(all) {
    const selected = new Set(all.filter(n => viewKinds[state.view].has(n.kind)).map(n => n.id));
    if (state.view === "overview") [...selected].forEach(id => { const n = nodes.get(id); if (n?.kind === "frontier-case" && !["audited","literature-open"].includes(n.status)) selected.delete(id); });
    if (state.view === "textbook") [...selected].forEach(id => { const n = nodes.get(id); if (n?.kind === "library" && n.id === "library:samplewiki") selected.delete(id); });
    if (state.view === "frontier") [...selected].forEach(id => { const n = nodes.get(id); if (n?.kind === "library" && n.id === "library:chewi") selected.delete(id); });
    return selected;
  }

  function visibleIds() {
    const all = [...nodes.values()]; let selected;
    if (state.query) {
      const terms = state.query.toLowerCase().split(/\s+/).filter(Boolean);
      const hits = all.filter(n => terms.every(t => n.search.includes(t))).sort((a,b) => (degree.get(b.id)-degree.get(a.id)) || a.label.localeCompare(b.label)).slice(0, 36);
      selected = new Set(hits.map(n => n.id)); hits.forEach(n => neighbors(n.id).forEach(id => selected.add(id)));
    } else {
      selected = viewIds(all);
    }

    // Focus is a visual overlay, not a graph filter. Keep the current textbook /
    // frontier / Lean context visible, then force the selected branch and its
    // immediate neighborhood into the canvas. This mirrors the QuantumComputinglib
    // interaction and makes highlighted versus muted edges visually meaningful.
    const priority = new Set();
    if (state.focus) {
      priority.add(state.focus); selected.add(state.focus);
      neighbors(state.focus).forEach(id => { priority.add(id); selected.add(id); });
    }
    state.expanded.forEach(id => {
      selected.add(id); priority.add(id);
      neighbors(id).forEach(n => selected.add(n));
    });

    if (selected.size > 190) {
      const forced = [...priority].filter(id => selected.has(id));
      const forcedSet = new Set(forced);
      const rest = [...selected].filter(id => !forcedSet.has(id)).sort((a,b) => {
        const A=nodes.get(a), B=nodes.get(b); const pa = A.kind === "library" || A.kind === "proof-root" ? 10000 : 0; const pb = B.kind === "library" || B.kind === "proof-root" ? 10000 : 0;
        return (pb + degree.get(b)) - (pa + degree.get(a));
      });
      selected = new Set([...forced.slice(0, 190), ...rest.slice(0, Math.max(0, 190 - forced.length))]);
    }
    return selected;
  }

  function layout(ids) {
    const columns = new Map(); [...ids].forEach(id => { const n=nodes.get(id); const key=kindOrder[n.kind] ?? 3; if (!columns.has(key)) columns.set(key, []); columns.get(key).push(n); });
    const positions = new Map(); let maxRows = 1;
    [...columns.entries()].sort((a,b)=>a[0]-b[0]).forEach(([column, list]) => {
      list.sort((a,b) => (a.kind.localeCompare(b.kind)) || a.label.localeCompare(b.label)); maxRows = Math.max(maxRows, list.length);
      const gap = list.length > 38 ? 64 : 82; list.forEach((n,i) => positions.set(n.id, {x: 62 + column * 310, y: 58 + i * gap}));
    });
    return {positions, width: 1560, height: Math.max(700, 130 + maxRows * (maxRows > 38 ? 64 : 82))};
  }

  function applyTransform() { const viewport = svg.querySelector(".ulg-viewport"); if (viewport) viewport.setAttribute("transform", `translate(${state.x} ${state.y}) scale(${state.scale})`); }
  function fit() { const box = svg.getBoundingClientRect(); const width = Number(svg.dataset.worldWidth || 1500), height = Number(svg.dataset.worldHeight || 700); state.scale = Math.max(.2, Math.min(1.05, Math.min((box.width-40)/width, (box.height-40)/height))); state.x = Math.max(18, (box.width-width*state.scale)/2); state.y = 22; applyTransform(); }

  function render() {
    const ids = visibleIds(); const edges = edgeSetFor(ids); const {positions,width,height} = layout(ids);
    const focusNeighbors = new Set(state.focus ? neighbors(state.focus) : []);
    const directEdges = state.focus ? (incident.get(state.focus) || []).filter(e => ids.has(e.source) && ids.has(e.target)) : [];
    svg.replaceChildren(); svg.dataset.worldWidth=width; svg.dataset.worldHeight=height; svg.setAttribute("viewBox", `0 0 ${Math.max(900, svg.clientWidth || 900)} ${Math.max(650, svg.clientHeight || 650)}`);
    const defs = svgEl("defs");
    const marker=svgEl("marker", {id:"ulg-arrow", class:"ulg-arrow-marker", viewBox:"0 0 10 10", refX:"9", refY:"5", markerWidth:"6", markerHeight:"6", orient:"auto-start-reverse"}); marker.append(svgEl("path", {d:"M 0 0 L 10 5 L 0 10 z"})); defs.append(marker);
    const focusMarker=svgEl("marker", {id:"ulg-arrow-focus", class:"ulg-arrow-marker focus", viewBox:"0 0 10 10", refX:"9", refY:"5", markerWidth:"6", markerHeight:"6", orient:"auto-start-reverse"}); focusMarker.append(svgEl("path", {d:"M 0 0 L 10 5 L 0 10 z"})); defs.append(focusMarker);
    svg.append(defs);
    const viewport=svgEl("g", {class:"ulg-viewport"}); const edgeLayer=svgEl("g", {class:"ulg-edges"}); const nodeLayer=svgEl("g", {class:"ulg-nodes"}); viewport.append(edgeLayer,nodeLayer); svg.append(viewport);
    edges.forEach(e => {
      const a=positions.get(e.source), b=positions.get(e.target); if(!a||!b)return;
      const related = Boolean(state.focus && (e.source === state.focus || e.target === state.focus));
      const classes = ["ulg-edge", `${relationEvidence(e.relation)}-edge`];
      if (state.focus) classes.push(related ? "related" : "muted");
      if (related) classes.push(e.target === state.focus ? "incoming" : "outgoing");
      const path=svgEl("path", {
        d:`M ${a.x+220} ${a.y+31} C ${a.x+265} ${a.y+31}, ${b.x-45} ${b.y+31}, ${b.x} ${b.y+31}`,
        class: classes.join(" "),
        "data-relation":e.relation,
        "data-evidence":relationEvidence(e.relation),
        "marker-end":related ? "url(#ulg-arrow-focus)" : "url(#ulg-arrow)"
      });
      const title=svgEl("title"); title.textContent=`${e.relation} · ${relationEvidence(e.relation) === "formal" ? "Lean structural edge" : "curated overlay"}`; path.append(title); edgeLayer.append(path);
    });
    [...ids].map(id=>nodes.get(id)).sort((a,b)=>(kindOrder[a.kind]-kindOrder[b.kind])||a.label.localeCompare(b.label)).forEach(n => {
      const p=positions.get(n.id); const classes=["ulg-node"];
      if (state.focus === n.id) classes.push("selected");
      else if (state.focus && focusNeighbors.has(n.id)) classes.push("related");
      else if (state.focus) classes.push("muted");
      const group=svgEl("g", {class:classes.join(" "), transform:`translate(${p.x} ${p.y})`, tabindex:"0", role:"button", "data-id":n.id});
      group.append(svgEl("rect", {width:"220",height:"62",rx:"12"}), svgEl("circle", {cx:"17",cy:"17",r:"5",class:`status ${n.status||"planned"}`}));
      const kind=svgEl("text", {x:"30",y:"20",class:"kind"}); kind.textContent=kindLabel[n.kind]||n.kind; group.append(kind);
      const label=svgEl("text", {x:"14",y:"40",class:"label"}); wrap(n.label).forEach((line,i)=>{ const t=svgEl("tspan",{x:"14",dy:i?"15":"0"}); t.textContent=line; label.append(t); }); group.append(label);
      const title=svgEl("title"); title.textContent=`${n.label}\n${n.subtitle||""}`; group.append(title);
      const choose=()=>selectNode(n.id,true); group.addEventListener("pointerdown",ev=>ev.stopPropagation()); group.addEventListener("click",choose); group.addEventListener("keydown",ev=>{if(ev.key==="Enter"||ev.key===" "){ev.preventDefault();choose();}}); nodeLayer.append(group);
    });
    count.textContent=`${ids.size} nodes · ${edges.length} edges${state.focus ? ` · ${directEdges.length} direct relations highlighted` : ""}`; empty.hidden=ids.size>0; applyTransform();
  }

  function linkButton(url,label,primary=false) { return url ? `<a class="${primary?"primary":""}" href="${esc(url)}">${esc(label)} <span>↗</span></a>` : ""; }
  function clearFocus() {
    state.focus="";
    state.expanded.clear();
    try { const url=new URL(location.href); url.searchParams.delete("focus"); url.searchParams.set("view",state.view); history.replaceState(null,"",url); } catch (_) {}
    detail.innerHTML='<div class="ulg-placeholder"><span>Branch inspector</span><h2>Select a node.</h2><p>Source statement, proof equations, exact Lean leaves, prerequisites, consumers, and reader links appear here.</p></div>';
    render();
  }
  function selectNode(id, expand=false) {
    if (!nodes.has(id)) return; state.focus=id; if(expand) state.expanded.add(id); const n=nodes.get(id);
    try { const url=new URL(location.href); url.searchParams.set("focus",id); url.searchParams.set("view",state.view); history.replaceState(null,"",url); } catch (_) {}
    const incoming=(incident.get(id)||[]).filter(e=>e.target===id).map(e=>nodes.get(e.source)).filter(Boolean); const outgoing=(incident.get(id)||[]).filter(e=>e.source===id).map(e=>nodes.get(e.target)).filter(Boolean);
    const formula=n.formula?`<div class="ulg-formula">\\[${esc(n.formula)}\\]</div>`:"";
    const equations=(n.proof_equations||[]).length?`<section><h3>Key proof equations</h3><ol class="ulg-equations">${n.proof_equations.map(row=>`<li><div>\\[${esc(row.formula)}\\]</div><p>${esc(row.meaning)}</p></li>`).join("")}</ol></section>`:"";
    const rows=(n.details||[]).filter(row=>row.value).map(row=>`<div><dt>${esc(row.label)}</dt><dd>${esc(row.value)}</dd></div>`).join("");
    const branch=(title,list)=>list.length?`<section><h3>${title}</h3><div class="ulg-neighbors">${list.slice(0,24).map(item=>`<button data-jump="${esc(item.id)}"><span>${esc(kindLabel[item.kind]||item.kind)}</span>${esc(item.label)}</button>`).join("")}</div></section>`:"";
    detail.innerHTML=`<header><span>${esc(kindLabel[n.kind]||n.kind)}</span><i class="${esc(n.status||"planned")}">${esc(n.status||"planned")}</i><h2>${esc(n.label)}</h2><p>${esc(n.subtitle||n.summary||"")}</p></header>${n.theorem?`<section><h3>Primary source theorem</h3><strong>${esc(n.theorem)}</strong>${formula}<p>${esc(n.source_proof||"")}</p></section>`:formula}${equations}${rows?`<dl class="ulg-details">${rows}</dl>`:""}<div class="ulg-links">${linkButton(n.url,"Open reader / Lean card",true)}${linkButton(n.source_url,"Open primary source")}</div>${branch("Immediate prerequisites",incoming)}${branch("Immediate consumers",outgoing)}`;
    detail.querySelectorAll("[data-jump]").forEach(button=>button.addEventListener("click",()=>selectNode(button.dataset.jump,true)));
    if (window.MathJax?.typesetPromise) window.MathJax.typesetPromise([detail]).catch(()=>{}); render();
  }

  function setView(view) { state.view=view; state.focus=""; state.expanded.clear(); buttons.forEach(b=>b.classList.toggle("active",b.dataset.view===view)); render(); requestAnimationFrame(fit); }
  buttons.forEach(button=>button.addEventListener("click",()=>setView(button.dataset.view)));
  search.addEventListener("input",()=>{state.query=search.value.trim(); state.focus=""; state.expanded.clear(); render(); requestAnimationFrame(fit);});
  document.querySelector("[data-graph-fit]").addEventListener("click",fit);
  document.querySelector("[data-graph-reset]").addEventListener("click",()=>{search.value="";state.query="";state.focus="";state.expanded.clear();setView("overview");});
  canvas.addEventListener("keydown",ev=>{if(ev.key==="Escape"&&state.focus){ev.preventDefault();clearFocus();}});
  svg.addEventListener("wheel",ev=>{ev.preventDefault(); const rect=svg.getBoundingClientRect(), px=ev.clientX-rect.left, py=ev.clientY-rect.top, old=state.scale, next=Math.max(.18,Math.min(2.4,old*Math.exp(-ev.deltaY*.001))); state.x=px-(px-state.x)*(next/old);state.y=py-(py-state.y)*(next/old);state.scale=next;applyTransform();},{passive:false});
  svg.addEventListener("pointerdown",ev=>{state.drag={x:ev.clientX,y:ev.clientY,tx:state.x,ty:state.y};svg.setPointerCapture(ev.pointerId);canvas.classList.add("dragging");});
  svg.addEventListener("pointermove",ev=>{if(!state.drag)return;state.x=state.drag.tx+ev.clientX-state.drag.x;state.y=state.drag.ty+ev.clientY-state.drag.y;applyTransform();});
  const stop=()=>{state.drag=null;canvas.classList.remove("dragging");}; svg.addEventListener("pointerup",stop);svg.addEventListener("pointercancel",stop);

  fetch(host.dataset.graphSource).then(r=>{if(!r.ok)throw new Error(`graph data ${r.status}`);return r.json();}).then(data=>{
    graph=data; nodes=new Map(data.nodes.map(n=>[n.id,n])); incident=new Map(data.nodes.map(n=>[n.id,[]])); data.edges.forEach(e=>{if(incident.has(e.source))incident.get(e.source).push(e);if(incident.has(e.target))incident.get(e.target).push(e);}); degree=new Map([...incident].map(([id,list])=>[id,list.length]));
    const params=new URLSearchParams(location.search); const requested=params.get("view"); if(viewKinds[requested])state.view=requested; const focus=params.get("focus"); buttons.forEach(b=>b.classList.toggle("active",b.dataset.view===state.view)); render(); requestAnimationFrame(()=>{fit();if(focus&&nodes.has(focus))selectNode(focus,true);});
  }).catch(error=>{empty.hidden=false;empty.textContent=`The formal graph could not be loaded: ${error.message}`;console.error(error);});
})();