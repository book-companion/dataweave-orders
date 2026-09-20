import { readFile } from 'node:fs/promises';
import path from 'node:path';
import assert from 'node:assert/strict';
import { discover, splitSavedOutput } from './playground/src/fixtures.ts';
import { runScript } from './playground/src/runner.ts';
import { compareBook } from './playground/compare-book.mjs';
const root = process.cwd();
const chapters = await discover(root);
const examples = chapters.flatMap(c => c.examples);
const listings = JSON.parse(await readFile('book/listings.json', 'utf8'));
assert.deepEqual(listings.map(e => e.number), Array.from({length:listings.length},(_,i)=>i+1));
assert.equal(examples.length, listings.filter(e=>e.kind==='script').length);
assert(examples.length > 300, 'The complete numbered catalogue must be discovered');
const failures=[]; let completed=0;
async function run(e, extra={}) {
  const script = await readFile(e.script,'utf8');
  return runScript(root,{script,scriptName:e.name,...e.bindings,...extra});
}
const queue=[...examples];
async function worker(){while(queue.length){const e=queue.shift();const expected=splitSavedOutput(await readFile(e.savedOutput,'utf8'));const actual=await run(e);if(!compareBook(e,actual,expected))failures.push({id:e.id,actual,expected});completed++;if(completed%50===0)console.log(`Checked ${completed}/${examples.length}`);}}
await Promise.all([worker(),worker(),worker()]);
for(const f of failures)console.error('FAIL',f.id,JSON.stringify(f.actual.output),JSON.stringify(f.expected.body));
assert.equal(failures.length,0,'All recorded results and exit codes must agree');
// Checks independent of the generated golden files.
const report=examples.find(e=>e.name.endsWith('-build-the-order-report'));
const got=JSON.parse((await run(report)).output);
assert.deepEqual(got.orders.map(o=>o.orderTotal),[32,6,33]);
assert.deepEqual(got.revenueByCategory,{stationery:53,paper:18});
assert.equal(got.batchTotal,71);
const empty=examples.find(e=>e.name.endsWith('-report-an-order-with-no-lines'));
const zero=JSON.parse((await run(empty)).output);
assert.equal(zero.batchTotal,0);assert.deepEqual(zero.revenueByCategory,{});assert.deepEqual(zero.orders[0].lines,[]);
const xml=await readFile(report.bindings.inputs[0].fixture,'utf8');
const rejected=await run(report,{inputs:[{name:'payload',content:xml.replace('currency="USD"','currency="EUR"'),format:'application/xml'}]});
assert.notEqual(rejected.exitCode,0);assert.match(rejected.output,/Expected USD price/);
// A wrong result and a repaired expected error must both be detected.
const hello=examples[0];const expected=splitSavedOutput(await readFile(hello.savedOutput,'utf8'));
assert(!compareBook(hello,await run(hello,{script:'%dw 2.0\noutput application/json\n---\n{greeting:"wrong"}'}),expected));
const bad=examples.find(e=>e.name.endsWith('-a-missing-comma'));
assert(!compareBook(bad,await run(bad,{script:'%dw 2.0\noutput application/json\n---\n{orderId:"A-1001",customer:"Dana"}'}),splitSavedOutput(await readFile(bad.savedOutput,'utf8'))));
console.log(`PASS ${examples.length} numbered CLI examples, catalogue order, capstone invariants and negative controls. ${listings.length-examples.length} module/Mule listings are outside standalone CLI execution; module functions are exercised by importing scripts.`);
