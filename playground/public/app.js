// src/client/app.ts
var FORMATS = [
  ["application/json", "JSON"],
  ["application/xml", "XML"],
  ["application/csv", "CSV"],
  ["application/yaml", "YAML"],
  ["text/plain", "Text"],
  ["application/java-properties", "Properties"]
];
var $ = (id) => document.getElementById(id);
var els = {
  example: $("example"),
  privileges: $("privileges"),
  run: $("run"),
  addInput: $("add-input"),
  inputList: $("input-list"),
  inputSummary: $("input-summary"),
  inputsHint: $("inputs-hint"),
  params: $("params"),
  script: $("script"),
  scriptPath: $("script-path"),
  status: $("status"),
  output: $("output"),
  compare: $("compare"),
  compareVerdict: $("compare-verdict"),
  compareBody: $("compare-body"),
  engine: $("engine"),
  modules: $("modules"),
  modulesLabel: $("modules-label")
};
var chapters = [];
var currentExample = null;
var allFixtures = [];
async function api(path, init) {
  const res = await fetch(path, init);
  const data = await res.json();
  if (!res.ok || data.error) throw new Error(data.error ?? `Request failed (${res.status})`);
  return data;
}
var readFixture = (p) => api(`/api/file?path=${encodeURIComponent(p)}`);
function collectInputs() {
  return [...els.inputList.querySelectorAll(".input")].map((card) => {
    const name = card.querySelector(".input-name").value.trim();
    if (card.dataset.mode === "book") {
      return { name, fixture: card.querySelector(".fixture-pick").value };
    }
    const area = card.querySelector("textarea");
    const view = card.querySelector(".input-view");
    const content = area ? area.value : view && !view.classList.contains("loading") ? view.textContent ?? "" : "";
    return {
      name,
      content,
      format: card.querySelector(".format-pick").value
    };
  });
}
function summariseInputs() {
  const rows = collectInputs();
  const names = rows.map((r) => r.name).filter(Boolean);
  els.inputSummary.textContent = names.length ? names.join(", ") : "none bound";
  els.inputsHint.replaceChildren();
  if (!names.length) {
    els.inputsHint.textContent = "Add an input and the script reads it by name.";
    return;
  }
  els.inputsHint.append("Read in the script by name: ");
  names.forEach((name, i) => {
    const code = document.createElement("span");
    code.className = "code";
    code.textContent = name;
    els.inputsHint.append(code, i < names.length - 1 ? ", " : ". ");
  });
  els.inputsHint.append("Mule's vars and attributes do not exist outside a flow.");
}
function guessFormat(fixture) {
  const ext = fixture.slice(fixture.lastIndexOf(".") + 1).toLowerCase();
  const found = FORMATS.find(([mime]) => mime.endsWith(`/${ext}`) || ext === "yml" && mime.endsWith("/yaml"));
  return found?.[0] ?? (ext === "txt" ? "text/plain" : "application/json");
}
function formatPick(format) {
  const pick = document.createElement("select");
  pick.className = "format-pick";
  pick.setAttribute("aria-label", "How to read this input");
  for (const [value, label] of FORMATS) {
    const option = document.createElement("option");
    option.value = value;
    option.textContent = label;
    if (value === format) option.selected = true;
    pick.append(option);
  }
  return pick;
}
function addInput(row = { name: "payload", content: "", format: "application/json" }) {
  const card = document.createElement("div");
  card.className = "input";
  const head = document.createElement("div");
  head.className = "input-head";
  const name = document.createElement("input");
  name.type = "text";
  name.className = "input-name";
  name.value = row.name;
  name.spellcheck = false;
  name.placeholder = "name";
  name.setAttribute("aria-label", "Input name");
  name.oninput = summariseInputs;
  const source = document.createElement("div");
  source.className = "source";
  source.setAttribute("role", "group");
  source.setAttribute("aria-label", "Where this input comes from");
  const sourceBtn = (label, title) => {
    const button = document.createElement("button");
    button.type = "button";
    button.textContent = label;
    button.title = title;
    return button;
  };
  const bookBtn = sourceBtn("Book", "A file that comes with this book");
  const fileBtn = sourceBtn("File", "A file from your own machine");
  const inlineBtn = sourceBtn("Inline", "Text you type here");
  source.append(bookBtn, fileBtn, inlineBtn);
  const press = (active) => {
    for (const button of [bookBtn, fileBtn, inlineBtn]) {
      button.setAttribute("aria-pressed", String(button === active));
    }
  };
  const drop = document.createElement("button");
  drop.type = "button";
  drop.className = "drop";
  drop.textContent = "\xD7";
  drop.title = "Remove this input";
  drop.setAttribute("aria-label", "Remove this input");
  drop.onclick = () => {
    card.remove();
    summariseInputs();
  };
  head.append(name, source, drop);
  const body = document.createElement("div");
  card.append(head, body);
  const showBook = async (fixture) => {
    card.dataset.mode = "book";
    press(bookBtn);
    body.replaceChildren();
    const chooser = document.createElement("div");
    chooser.className = "input-file";
    const pick = document.createElement("select");
    pick.className = "fixture-pick";
    pick.setAttribute("aria-label", "Which of the book\u2019s files to bind");
    for (const path of allFixtures) {
      const option = document.createElement("option");
      option.value = path;
      option.textContent = path.replace(/^chapters\//, "");
      if (path === fixture) option.selected = true;
      pick.append(option);
    }
    chooser.append(pick);
    const view = document.createElement("pre");
    view.className = "code input-view loading";
    view.textContent = "Reading\u2026";
    body.append(chooser, view);
    const load = async () => {
      view.className = "code input-view loading";
      view.textContent = "Reading\u2026";
      try {
        const file = await readFixture(pick.value);
        view.className = "code input-view";
        view.textContent = file.content;
      } catch (err) {
        view.className = "code input-view loading";
        view.textContent = err instanceof Error ? err.message : "That file could not be read.";
      }
    };
    pick.onchange = () => void load();
    await load();
    summariseInputs();
  };
  const showFile = (content, format, filename = "") => {
    card.dataset.mode = "file";
    press(fileBtn);
    body.replaceChildren();
    const chooser = document.createElement("div");
    chooser.className = "input-file";
    const open = document.createElement("button");
    open.type = "button";
    open.className = "quiet open-file";
    const chosen = document.createElement("span");
    chosen.className = "chosen";
    const pick = formatPick(format);
    const picker = document.createElement("input");
    picker.type = "file";
    picker.hidden = true;
    const view = document.createElement("pre");
    view.className = "code input-view";
    const empty = () => {
      view.className = "code input-view loading";
      view.textContent = "No file chosen yet. Pick one and its contents appear here.";
      open.textContent = "Choose a file\u2026";
    };
    if (content) {
      view.textContent = content;
      open.textContent = "Choose another\u2026";
      chosen.textContent = filename;
    } else empty();
    picker.onchange = async () => {
      const file = picker.files?.[0];
      if (!file) return;
      if (file.size > 2e6) {
        chosen.textContent = `${file.name} is too large to open here`;
        return;
      }
      view.className = "code input-view";
      view.textContent = await file.text();
      const guess = guessFormat(file.name);
      if ([...pick.options].some((o) => o.value === guess)) pick.value = guess;
      chosen.textContent = file.name;
      open.textContent = "Choose another\u2026";
      summariseInputs();
    };
    open.onclick = () => picker.click();
    chooser.append(open, chosen, pick, picker);
    body.append(chooser, view);
    summariseInputs();
  };
  const showInline = (content, format) => {
    card.dataset.mode = "inline";
    press(inlineBtn);
    body.replaceChildren();
    const chooser = document.createElement("div");
    chooser.className = "input-file";
    chooser.append(formatPick(format));
    const area = document.createElement("textarea");
    area.className = "code";
    area.spellcheck = false;
    area.value = content;
    area.setAttribute("aria-label", "Input content");
    body.append(chooser, area);
    summariseInputs();
  };
  const shown = () => {
    const area = body.querySelector("textarea");
    if (area) return area.value;
    const view = body.querySelector(".input-view");
    return view && !view.classList.contains("loading") ? view.textContent ?? "" : "";
  };
  const shownFormat = () => body.querySelector(".format-pick")?.value ?? guessFormat(body.querySelector(".fixture-pick")?.value ?? "");
  bookBtn.onclick = () => {
    if (card.dataset.mode !== "book") void showBook(allFixtures[0] ?? "");
  };
  fileBtn.onclick = () => {
    if (card.dataset.mode !== "file") showFile("", shownFormat());
  };
  inlineBtn.onclick = () => {
    if (card.dataset.mode !== "inline") showInline(shown(), shownFormat());
  };
  els.inputList.append(card);
  if (row.fixture) void showBook(row.fixture);
  else showInline(row.content ?? "", row.format ?? "application/json");
}
async function loadExamples() {
  const data = await api("/api/examples");
  chapters = data.chapters;
  allFixtures = [...new Set(chapters.flatMap((c) => c.inputs))].sort();
  for (const chapter of chapters) {
    if (!chapter.examples.length) continue;
    const group = document.createElement("optgroup");
    group.label = chapter.id;
    for (const example of chapter.examples) {
      const option = document.createElement("option");
      option.value = example.id;
      option.textContent = example.name.replace(/_/g, " ");
      group.append(option);
    }
    els.example.append(group);
  }
}
var STARTER = `%dw 2.0
output application/json
---
{
  id: payload.orderId,
  lines: sizeOf(payload.items)
}
`;
var STARTER_INPUT = `{
  "orderId": "A-1001",
  "items": [
    { "sku": "PEN-01", "price": 2.5, "qty": 4 }
  ]
}
`;
async function openExample(id) {
  els.compare.hidden = true;
  els.inputList.replaceChildren();
  if (!id) {
    currentExample = null;
    els.modulesLabel.hidden = true;
    els.scriptPath.textContent = "unsaved";
    els.script.value = STARTER;
    addInput({ name: "payload", format: "application/json", content: STARTER_INPUT });
    summariseInputs();
    return;
  }
  const chapter = chapters.find((c) => c.examples.some((e) => e.id === id));
  const example = chapter.examples.find((e) => e.id === id);
  currentExample = example;
  const file = await readFixture(example.script);
  els.script.value = file.content;
  els.scriptPath.textContent = example.script.replace(/^chapters\//, "");
  const bound = example.bindings;
  els.modulesLabel.hidden = false;
  els.modules.checked = (bound?.modulePaths.length ?? 0) > 0;
  els.params.value = (bound?.params ?? []).map((p) => `${p.name}=${p.value}`).join(" ");
  if (bound) {
    for (const input of bound.inputs) {
      addInput(
        input.fixture ? { name: input.name, fixture: input.fixture } : { name: input.name, content: input.content ?? "", format: input.format ?? "application/json" }
      );
    }
  } else {
    const fixture = chapter.inputs.find((p) => p.endsWith(".json")) ?? chapter.inputs[0];
    if (fixture) addInput({ name: "payload", fixture });
  }
  summariseInputs();
}
function setStatus(text, cls = "") {
  els.status.textContent = text;
  els.status.className = `reading ${cls}`;
}
async function compareWithBook(result) {
  if (!currentExample?.savedOutput) {
    els.compare.hidden = true;
    return;
  }
  const file = await api(
    `/api/file?path=${encodeURIComponent(currentExample.savedOutput)}`
  );
  const saved = file.saved;
  if (!saved) {
    els.compare.hidden = true;
    return;
  }
  const sameBody = saved.body.trim() === result.output.trim();
  const sameExit = saved.exitCode === null || saved.exitCode === result.exitCode;
  els.compare.hidden = false;
  if (sameBody && sameExit) {
    els.compareVerdict.textContent = "Matches";
    els.compareVerdict.className = "verdict match";
    els.compareBody.textContent = "";
    return;
  }
  const nondeterministic = /\bnow\(\)|uuid|randomInt|random\b/.test(els.script.value);
  const onlyIdentityHash = !sameBody && result.output.trim().replace(/@[0-9a-f]{4,}\b/g, "@") === saved.body.trim().replace(/@[0-9a-f]{4,}\b/g, "@");
  els.compareVerdict.className = "verdict differs";
  if (sameExit && onlyIdentityHash) {
    els.compareVerdict.textContent = "Differs only by an object identity hash \u2014 expected";
  } else if (sameExit && nondeterministic) {
    els.compareVerdict.textContent = "Differs \u2014 this script produces a new value every run";
  } else {
    els.compareVerdict.textContent = sameBody ? "Same result, different exit code" : "Differs";
  }
  els.compareBody.textContent = saved.exitCode === null ? saved.body : `${saved.body}

exit=${saved.exitCode}`;
}
async function run() {
  els.run.disabled = true;
  setStatus("running");
  els.compare.hidden = true;
  try {
    const result = await api("/api/run", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        script: els.script.value,
        inputs: collectInputs(),
        allowPrivileges: els.privileges.checked,
        // A failing example should report the file name the book prints.
        scriptName: currentExample?.name,
        // The book's own --path when it had one; the chapter folder otherwise,
        // which is what a reader turning this on for their own script means.
        modulePaths: currentExample && els.modules.checked ? currentExample.bindings?.modulePaths.length ? currentExample.bindings.modulePaths : [`chapters/${currentExample.chapter}`] : [],
        params: els.params.value.split(/\s+/).filter((pair) => pair.includes("=")).map((pair) => ({
          name: pair.slice(0, pair.indexOf("=")),
          value: pair.slice(pair.indexOf("=") + 1)
        }))
      })
    });
    els.output.textContent = result.output || "(the script produced no output)";
    setStatus(
      result.timedOut ? "timed out" : `exit ${result.exitCode}, ${result.durationMs} ms`,
      result.exitCode === 0 ? "ok" : "bad"
    );
    await compareWithBook(result);
  } catch (err) {
    els.output.textContent = err instanceof Error ? err.message : String(err);
    setStatus("did not run", "bad");
  } finally {
    els.run.disabled = false;
  }
}
els.run.onclick = () => void run();
els.addInput.onclick = () => addInput({ name: "", content: "", format: "application/json" });
els.example.onchange = () => void openExample(els.example.value);
document.addEventListener("keydown", (event) => {
  if ((event.metaKey || event.ctrlKey) && event.key === "Enter") {
    event.preventDefault();
    void run();
  }
});
void (async () => {
  await loadExamples();
  await openExample("");
  try {
    const version = await api("/api/version");
    const runtime = /Runtime\s*:\s*V?([\d.]+)/i.exec(version.banner)?.[1];
    els.engine.textContent = runtime ? `${version.image}, language runtime ${runtime}` : version.image;
  } catch (err) {
    els.engine.className = "unreachable";
    els.engine.textContent = err instanceof Error ? err.message : "The engine is not reachable.";
  }
})();
