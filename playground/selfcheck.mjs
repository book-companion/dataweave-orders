/** Replay the numbered catalogue through the same HTTP API as the browser. */
import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import { compareBook } from './compare-book.mjs';
const base=process.env.PG??'http://127.0.0.1:4444';
const get=async p=>{const r=await fetch(base+p);assert.equal(r.status,200,p);return r.json();};
const manifest=JSON.parse(await readFile(new URL('../book/manifest.json',import.meta.url),'utf8'));
const catalog=await get('/api/examples');
const examples=catalog.chapters.flatMap(c=>c.examples);
assert.deepEqual(examples,manifest.flatMap(c=>c.examples),'The HTTP catalogue must preserve declared order and bindings');
const only=process.argv.includes('--chapter')?process.argv[process.argv.indexOf('--chapter')+1]:null;
const selected=examples.filter(e=>!only||e.chapter===only);
assert(selected.length>0,'No examples selected');
const queue=process.argv.includes('--all')?selected:selected.slice(0,30);
const count=queue.length;let done=0;const failures=[];
async function worker(){while(queue.length){const e=queue.shift();const {content:script}=await get('/api/file?path='+encodeURIComponent(e.script));const {saved}=await get('/api/file?path='+encodeURIComponent(e.savedOutput));const response=await fetch(base+'/api/run',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({script,scriptName:e.name,...e.bindings})});assert.equal(response.status,200);const actual=await response.json();if(!compareBook(e,actual,saved))failures.push({id:e.id,actual,expected:saved});done++;if(done%50===0)console.log('HTTP checked',done,'/',count);}}
await Promise.all([worker(),worker(),worker()]);
for(const failure of failures)console.error(JSON.stringify(failure));
assert.equal(failures.length,0,'HTTP results must match the recorded examples');
console.log(`PASS ${count} examples through the Runner HTTP API; catalogue and bindings match.`);
