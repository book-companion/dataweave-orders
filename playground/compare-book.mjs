/** Compare saved text, permitting only explicitly documented clock/identity drift. */
export function compareBook(example, actual, expected) {
  if (actual.exitCode !== expected.exitCode || actual.timedOut) return false;
  const clean = s => s.trimEnd().replace(/@[0-9a-f]{4,}\b/g, '@IDENTITY');
  if (example.comparison !== 'clock') return clean(actual.output) === clean(expected.body);
  let value;
  try { value = JSON.parse(actual.output); } catch { return false; }
  if (Object.keys(value).sort().join(',') !== 'asDate,asLocal,now,today,zone') return false;
  const instant = Date.parse(value.now);
  if (!Number.isFinite(instant) || Math.abs(Date.now() - instant) > 60_000 || value.zone !== 'Z') return false;
  const date = new Date(instant).toISOString().slice(0, 10);
  return value.asDate === date && value.today === date &&
    Number.isFinite(Date.parse(value.asLocal + 'Z')) &&
    Math.abs(Date.parse(value.asLocal + 'Z') - instant) < 5000;
}
