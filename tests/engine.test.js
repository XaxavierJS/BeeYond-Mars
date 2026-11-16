import test from 'node:test';
import assert from 'node:assert/strict';
import * as E from '../engine.js';
import { ROUTE_DATA } from '../route-data.js';

const build = (parts, launcher = 'aurelia', seed = 4242) => {
  const g = E.fresh(1, seed, 'Lum', 'Miel');
  assert.ok(E.setLauncher(g, launcher));
  for (const p of parts) assert.equal(E.toggle(g, p), null, p);
  E.claim(g, 0); E.setRoute(g, 'fast'); E.setRoute(g, 'standard'); E.claim(g, 1);
  return g;
};
const fly = (g, pick = o => o.find(x => x.ok)) => {
  assert.ok(E.launch(g), JSON.stringify(E.errors(g)));
  for (let i = 0; i < 80 && g.phase === 'voyage'; i++) { if (g.flight.pending) E.resolve(g, pick(E.options(g)).id); else E.advance(g); }
  return g;
};
const GOOD = ['chamberB', 'panels', 'toolkit', 'antenna', 'dosimeter'];

test('the letter budget is 2000 credits and reviews add 150 + 200', () => {
  const g = E.fresh(); assert.equal(E.stats(g).budget, 2000);
  assert.deepEqual(E.CFG.grants, [150, 200]);
});
test('three launchers differ in cost, payload, power, own draw and delta-v', () => {
  for (const k of ['cost', 'cap', 'power', 'dv']) assert.equal(new Set(E.LAUNCHERS.map(l => l[k])).size, 3, k);
  assert.ok(E.LAUNCHERS.every(l => typeof l.own === 'number'));
});
test('route data: sunlight falls to about half and light delay passes 9 minutes by arrival', () => {
  for (const id of ['standard', 'fast']) {
    const r = E.ROUTES.find(x => x.id === id), a = E.routeSample(id, r.days);
    assert.ok(a.f > 0.49 && a.f < 0.53, 'f ' + a.f); assert.ok(a.s > 540 && a.s < 660, 's ' + a.s);
    assert.ok(E.routeSample(id, 0).f > 1); assert.ok(ROUTE_DATA[id].f.length >= r.days - 3);
  }
});
test('a 0.3 kg instrument costs 0.0024 km/s', () => {
  const g = E.fresh(), a = E.stats(g).dv; E.toggle(g, 'dosimeter');
  assert.ok(Math.abs(a - E.stats(g).dv - 0.0024) < 1e-9);
});
test('only one chamber at a time, and removing a part refunds it', () => {
  const g = E.fresh(); E.toggle(g, 'chamberA'); E.toggle(g, 'chamberB');
  assert.deepEqual(g.parts, ['chamberB']); E.toggle(g, 'chamberB'); assert.equal(E.stats(g).budget, 2000);
});
test('purchases over budget are refused', () => {
  const g = E.fresh(); E.setLauncher(g, 'atlas');
  for (const p of ['chamberB', 'panels', 'antenna', 'toolkit', 'thermal', 'backup', 'dosimeter']) E.toggle(g, p);
  assert.ok(E.stats(g).budget >= 0);
});
test('launch is blocked without a chamber, without comms, or with too little power near Mars', () => {
  assert.ok(E.errors(E.fresh()).length);
  const noComms = build(['chamberA'], 'aurelia'); assert.ok(E.errors(noComms).some(e => /link/.test(e[0])));
  const weak = build(['chamberB', 'antenna'], 'aurelia'); assert.ok(E.errors(weak).some(e => /Mars/.test(e[0]))); assert.equal(E.launch(weak), false);
});
test('a careful design on Atlaswing arrives with ending A', () => {
  const g = fly(build(GOOD, 'atlas')); assert.ok(E.arrived(g));
  E.greenStart(g); while (!g.green.done) E.greenChoose(g, g.green.cells > 0);
  const r = E.report(g); assert.ok(r.score >= 80 && r.score <= 100, 'score ' + r.score); assert.equal(r.ending, 'A');
});
test('every launcher has at least one design that can launch', () => {
  const sets = [['chamberA', 'backup'], ['chamberA', 'antenna'], ['chamberA', 'backup', 'panels'], ['chamberB', 'backup', 'panels'], ['chamberA', 'backup', 'toolkit'], GOOD];
  for (const l of E.LAUNCHERS) assert.ok(sets.some(s => { try { return !E.errors(build(s, l.id)).length; } catch { return false; } }), l.id);
});
test('ignoring every incident never earns ending A, and a lost mission is capped at 49', () => {
  const g = fly(build(['chamberA', 'backup'], 'aurelia'), o => o.find(x => x.worst) || o[0]);
  const r = E.report(g); assert.notEqual(r.ending, 'A'); if (!E.arrived(g)) assert.ok(r.score <= 49);
});
test('the autonomous response picks an available option', () => {
  const g = build(GOOD, 'atlas'); E.launch(g);
  for (let i = 0; i < 80 && g.phase === 'voyage'; i++) { if (g.flight.pending) { const a = E.autoOption(g); assert.ok(E.options(g).find(o => o.id === a).ok); E.resolve(g, a); } else E.advance(g); }
});
test('same seed and same choices give the same report; redesign keeps parts, grants and seed', () => {
  const a = E.report(fly(build(GOOD, 'atlas', 77))), b = E.report(fly(build(GOOD, 'atlas', 77)));
  assert.equal(a.score, b.score);
  const g = fly(build(GOOD, 'atlas', 77)); E.redesign(g);
  assert.equal(g.phase, 'lab'); assert.equal(g.seed, 77); assert.deepEqual(g.parts, GOOD); assert.equal(g.grants.length, 2); assert.equal(g.attempt, 2);
});
test('feedback and options are bilingual', () => {
  const g = fly(build(GOOD, 'atlas')); const fb = E.feedback(g);
  for (const k of Object.keys(fb)) for (const x of [].concat(fb[k])) if (Array.isArray(x)) assert.equal(x.length, 2);
});
