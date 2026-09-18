/**
 * DataWeave Runner — the browser half.
 *
 * Compiled to ../public/app.js, which is committed so a reader needs nothing but
 * Node and Docker.
 */

interface Example {
	id: string;
	chapter: string;
	name: string;
	script: string;
	savedOutput?: string;
}
interface Chapter { id: string; examples: Example[]; inputs: string[] }
interface RunResult { output: string; exitCode: number; durationMs: number; timedOut: boolean; argv: string[] }
interface SavedOutput { body: string; exitCode: number | null }

/** The formats the CLI infers from a file extension, for inline input. */
const FORMATS: Array<[string, string]> = [
	['application/json', 'JSON'],
	['application/xml', 'XML'],
	['application/csv', 'CSV'],
	['application/yaml', 'YAML'],
	['text/plain', 'Text'],
	['application/java-properties', 'Properties'],
];

const $ = <T extends HTMLElement>(id: string): T => document.getElementById(id) as T;

const els = {
	example: $<HTMLSelectElement>('example'),
	privileges: $<HTMLInputElement>('privileges'),
	run: $<HTMLButtonElement>('run'),
	addInput: $<HTMLButtonElement>('add-input'),
	inputList: $<HTMLDivElement>('input-list'),
	inputSummary: $<HTMLSpanElement>('input-summary'),
	inputsHint: $<HTMLParagraphElement>('inputs-hint'),
	params: $<HTMLInputElement>('params'),
	script: $<HTMLTextAreaElement>('script'),
	scriptPath: $<HTMLSpanElement>('script-path'),
	status: $<HTMLSpanElement>('status'),
	output: $<HTMLPreElement>('output'),
	compare: $<HTMLElement>('compare'),
	compareVerdict: $<HTMLSpanElement>('compare-verdict'),
	compareBody: $<HTMLPreElement>('compare-body'),
	engine: $<HTMLSpanElement>('engine'),
	modules: $<HTMLInputElement>('modules'),
	modulesLabel: $<HTMLLabelElement>('modules-label'),
};

let chapters: Chapter[] = [];
let currentExample: Example | null = null;
/** Every fixture in the repository, so any input can be pointed at any of them. */
let allFixtures: string[] = [];

interface InputRow { name: string; fixture?: string; content?: string; format?: string }

async function api<T>(path: string, init?: RequestInit): Promise<T> {
	const res = await fetch(path, init);
	const data = (await res.json()) as T & { error?: string };
	if (!res.ok || data.error) throw new Error(data.error ?? `Request failed (${res.status})`);
	return data;
}

const readFixture = (p: string) => api<{ content: string }>(`/api/file?path=${encodeURIComponent(p)}`);

/* ── inputs ──────────────────────────────────────────────────────────────
   An input is one binding with two possible sources. In file mode it shows the
   fixture's contents, not just its name — a reader is comparing an expression
   against its input, and should not have to leave the page to see what the
   input says. Switching to inline carries those contents across, so changing
   the book's fixture is one click and an edit. */

function collectInputs(): InputRow[] {
	return [...els.inputList.querySelectorAll<HTMLDivElement>('.input')].map((card) => {
		const name = card.querySelector<HTMLInputElement>('.input-name')!.value.trim();
		if (card.dataset.mode === 'file') {
			return { name, fixture: card.querySelector<HTMLSelectElement>('.fixture-pick')!.value };
		}
		return {
			name,
			content: card.querySelector<HTMLTextAreaElement>('textarea')!.value,
			format: card.querySelector<HTMLSelectElement>('.format-pick')!.value,
		};
	});
}

function summariseInputs(): void {
	const rows = collectInputs();
	const names = rows.map((r) => r.name).filter(Boolean);
	els.inputSummary.textContent = names.length ? names.join(', ') : 'none bound';

	// Each input is a top-level name in the script. Worth saying, because this
	// book's readers come from Mule, where an input would be reached through
	// `vars` — and `vars` does not exist outside a flow.
	els.inputsHint.replaceChildren();
	if (!names.length) {
		els.inputsHint.textContent = 'Add an input and the script reads it by name.';
		return;
	}
	els.inputsHint.append('Read in the script by name: ');
	names.forEach((name, i) => {
		const code = document.createElement('span');
		code.className = 'code';
		code.textContent = name;
		els.inputsHint.append(code, i < names.length - 1 ? ', ' : '. ');
	});
	els.inputsHint.append("Mule's vars and attributes do not exist outside a flow.");
}

function guessFormat(fixture: string): string {
	const ext = fixture.slice(fixture.lastIndexOf('.') + 1).toLowerCase();
	const found = FORMATS.find(([mime]) => mime.endsWith(`/${ext}`) || (ext === 'yml' && mime.endsWith('/yaml')));
	return found?.[0] ?? (ext === 'txt' ? 'text/plain' : 'application/json');
}

function addInput(row: InputRow = { name: 'payload', content: '', format: 'application/json' }): void {
	const card = document.createElement('div');
	card.className = 'input';

	const head = document.createElement('div');
	head.className = 'input-head';

	const name = document.createElement('input');
	name.type = 'text';
	name.className = 'input-name';
	name.value = row.name;
	name.spellcheck = false;
	name.placeholder = 'name';
	name.setAttribute('aria-label', 'Input name');
	name.oninput = summariseInputs;

	const source = document.createElement('div');
	source.className = 'source';
	source.setAttribute('role', 'group');
	source.setAttribute('aria-label', 'Where this input comes from');
	const fileBtn = document.createElement('button');
	fileBtn.type = 'button';
	fileBtn.textContent = 'File';
	const inlineBtn = document.createElement('button');
	inlineBtn.type = 'button';
	inlineBtn.textContent = 'Inline';
	source.append(fileBtn, inlineBtn);

	const drop = document.createElement('button');
	drop.type = 'button';
	drop.className = 'drop';
	drop.textContent = '×';
	drop.title = 'Remove this input';
	drop.setAttribute('aria-label', 'Remove this input');
	drop.onclick = () => { card.remove(); summariseInputs(); };

	head.append(name, source, drop);
	const body = document.createElement('div');
	card.append(head, body);

	const showFile = async (fixture: string): Promise<void> => {
		card.dataset.mode = 'file';
		fileBtn.setAttribute('aria-pressed', 'true');
		inlineBtn.setAttribute('aria-pressed', 'false');
		body.replaceChildren();

		const chooser = document.createElement('div');
		chooser.className = 'input-file';
		const pick = document.createElement('select');
		pick.className = 'fixture-pick';
		pick.setAttribute('aria-label', 'Which file to bind');
		for (const path of allFixtures) {
			const option = document.createElement('option');
			option.value = path;
			option.textContent = path.replace(/^chapters\//, '');
			if (path === fixture) option.selected = true;
			pick.append(option);
		}
		chooser.append(pick);

		const view = document.createElement('pre');
		view.className = 'code input-view loading';
		view.textContent = 'Reading…';
		body.append(chooser, view);

		const load = async (): Promise<void> => {
			view.className = 'code input-view loading';
			view.textContent = 'Reading…';
			try {
				const file = await readFixture(pick.value);
				view.className = 'code input-view';
				view.textContent = file.content;
			} catch (err) {
				view.className = 'code input-view loading';
				view.textContent = err instanceof Error ? err.message : 'That file could not be read.';
			}
		};
		pick.onchange = () => void load();
		await load();
		summariseInputs();
	};

	const showInline = (content: string, format: string): void => {
		card.dataset.mode = 'inline';
		fileBtn.setAttribute('aria-pressed', 'false');
		inlineBtn.setAttribute('aria-pressed', 'true');
		body.replaceChildren();

		const chooser = document.createElement('div');
		chooser.className = 'input-file';
		const pick = document.createElement('select');
		pick.className = 'format-pick';
		pick.setAttribute('aria-label', 'How to read this input');
		for (const [value, label] of FORMATS) {
			const option = document.createElement('option');
			option.value = value;
			option.textContent = label;
			if (value === format) option.selected = true;
			pick.append(option);
		}
		chooser.append(pick);

		// Any file on the machine, opened by the browser rather than by the
		// server. The reader picks it, the browser reads it, and it arrives here
		// as text — so the server's reach stays exactly what it was: this
		// repository, read-only. Nothing new is mounted into the container.
		const open = document.createElement('button');
		open.type = 'button';
		open.className = 'quiet open-file';
		open.textContent = 'Open a file\u2026';
		const chosen = document.createElement('span');
		chosen.className = 'chosen';

		const picker = document.createElement('input');
		picker.type = 'file';
		picker.hidden = true;
		picker.onchange = async () => {
			const file = picker.files?.[0];
			if (!file) return;
			if (file.size > 2_000_000) {
				chosen.textContent = `${file.name} is too large to open here`;
				return;
			}
			area.value = await file.text();
			const guess = guessFormat(file.name);
			if ([...pick.options].some((o) => o.value === guess)) pick.value = guess;
			chosen.textContent = file.name;
			summariseInputs();
		};
		open.onclick = () => picker.click();
		chooser.append(open, chosen, picker);

		const area = document.createElement('textarea');
		area.className = 'code';
		area.spellcheck = false;
		area.value = content;
		area.setAttribute('aria-label', 'Input content');
		body.append(chooser, area);
		summariseInputs();
	};

	fileBtn.onclick = () => {
		if (card.dataset.mode !== 'file') void showFile(allFixtures[0] ?? '');
	};
	// Carry the file's contents across, so "what if this field were missing?" is
	// one click and an edit rather than a copy out of another window.
	inlineBtn.onclick = () => {
		if (card.dataset.mode === 'inline') return;
		const shown = body.querySelector('.input-view');
		const fixture = body.querySelector<HTMLSelectElement>('.fixture-pick')?.value ?? '';
		const loaded = shown && !shown.classList.contains('loading') ? shown.textContent ?? '' : '';
		showInline(loaded, guessFormat(fixture));
	};

	els.inputList.append(card);
	if (row.fixture) void showFile(row.fixture);
	else showInline(row.content ?? '', row.format ?? 'application/json');
}

/* ── examples ───────────────────────────────────────────────────────────── */

async function loadExamples(): Promise<void> {
	const data = await api<{ chapters: Chapter[] }>('/api/examples');
	chapters = data.chapters;
	allFixtures = [...new Set(chapters.flatMap((c) => c.inputs))].sort();
	for (const chapter of chapters) {
		if (!chapter.examples.length) continue;
		const group = document.createElement('optgroup');
		group.label = chapter.id;
		for (const example of chapter.examples) {
			const option = document.createElement('option');
			option.value = example.id;
			// Keep the leading number: it is the order the chapter works through,
			// and "summary" alone is not findable among sixteen chapters.
			option.textContent = example.name.replace(/_/g, ' ');
			group.append(option);
		}
		els.example.append(group);
	}
}

const STARTER = `%dw 2.0
output application/json
---
{
  id: payload.orderId,
  lines: sizeOf(payload.items)
}
`;

const STARTER_INPUT = `{
  "orderId": "A-1001",
  "items": [
    { "sku": "PEN-01", "price": 2.5, "qty": 4 }
  ]
}
`;

async function openExample(id: string): Promise<void> {
	els.compare.hidden = true;
	els.inputList.replaceChildren();

	if (!id) {
		currentExample = null;
		els.modulesLabel.hidden = true;
		els.scriptPath.textContent = 'unsaved';
		els.script.value = STARTER;
		addInput({ name: 'payload', format: 'application/json', content: STARTER_INPUT });
		summariseInputs();
		return;
	}

	const chapter = chapters.find((c) => c.examples.some((e) => e.id === id))!;
	const example = chapter.examples.find((e) => e.id === id)!;
	currentExample = example;

	const file = await readFixture(example.script);
	els.script.value = file.content;
	els.scriptPath.textContent = example.script.replace(/^chapters\//, '');

	// The chapter's own folder is where its imports resolve from, which is what
	// its run.sh passes. One example omits it deliberately, so this stays a choice.
	els.modulesLabel.hidden = false;
	els.modules.checked = true;

	const fixture = chapter.inputs.find((p) => p.endsWith('.json')) ?? chapter.inputs[0];
	if (fixture) addInput({ name: 'payload', fixture });
	summariseInputs();
}

/* ── running ────────────────────────────────────────────────────────────── */

function setStatus(text: string, cls = ''): void {
	els.status.textContent = text;
	els.status.className = `reading ${cls}`;
}

async function compareWithBook(result: RunResult): Promise<void> {
	if (!currentExample?.savedOutput) { els.compare.hidden = true; return; }
	const file = await api<{ saved: SavedOutput | null }>(
		`/api/file?path=${encodeURIComponent(currentExample.savedOutput)}`,
	);
	const saved = file.saved;
	if (!saved) { els.compare.hidden = true; return; }

	const sameBody = saved.body.trim() === result.output.trim();
	const sameExit = saved.exitCode === null || saved.exitCode === result.exitCode;
	els.compare.hidden = false;

	if (sameBody && sameExit) {
		els.compareVerdict.textContent = 'Matches';
		els.compareVerdict.className = 'verdict match';
		els.compareBody.textContent = '';
	} else {
		els.compareVerdict.textContent = sameBody ? 'Same result, different exit code' : 'Differs';
		els.compareVerdict.className = 'verdict differs';
		els.compareBody.textContent = saved.exitCode === null
			? saved.body
			: `${saved.body}\n\nexit=${saved.exitCode}`;
	}
}

async function run(): Promise<void> {
	els.run.disabled = true;
	setStatus('running');
	els.compare.hidden = true;
	try {
		const result = await api<RunResult>('/api/run', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				script: els.script.value,
				inputs: collectInputs(),
				allowPrivileges: els.privileges.checked,
				// A failing example should report the file name the book prints.
				scriptName: currentExample?.name,
				modulePaths:
					currentExample && els.modules.checked ? [`chapters/${currentExample.chapter}`] : [],
				params: els.params.value
					.split(/\s+/)
					.filter((pair) => pair.includes('='))
					.map((pair) => ({
						name: pair.slice(0, pair.indexOf('=')),
						value: pair.slice(pair.indexOf('=') + 1),
					})),
			}),
		});
		els.output.textContent = result.output || '(the script produced no output)';
		setStatus(
			result.timedOut ? 'timed out' : `exit ${result.exitCode}, ${result.durationMs} ms`,
			result.exitCode === 0 ? 'ok' : 'bad',
		);
		await compareWithBook(result);
	} catch (err) {
		els.output.textContent = err instanceof Error ? err.message : String(err);
		setStatus('did not run', 'bad');
	} finally {
		els.run.disabled = false;
	}
}

els.run.onclick = () => void run();
els.addInput.onclick = () => addInput({ name: '', content: '', format: 'application/json' });
els.example.onchange = () => void openExample(els.example.value);
document.addEventListener('keydown', (event) => {
	if ((event.metaKey || event.ctrlKey) && event.key === 'Enter') {
		event.preventDefault();
		void run();
	}
});

void (async () => {
	await loadExamples();
	await openExample('');
	try {
		const version = await api<{ banner: string; image: string }>('/api/version');
		const runtime = /Runtime\s*:\s*V?([\d.]+)/i.exec(version.banner)?.[1];
		els.engine.textContent = runtime
			? `${version.image}, language runtime ${runtime}`
			: version.image;
	} catch (err) {
		els.engine.className = 'unreachable';
		els.engine.textContent = err instanceof Error ? err.message : 'The engine is not reachable.';
	}
})();
