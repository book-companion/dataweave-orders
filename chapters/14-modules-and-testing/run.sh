#!/bin/sh
# Regenerates every *.out beside its probe. Run from anywhere.
cd "$(dirname "$0")"; DW=../../dw.sh; C=chapters/14-modules-and-testing
strip() { sed -E 's/\x1b\[[0-9;]*m//g' | grep -v "sun.misc.Unsafe\|Please consider reporting\|terminally deprecated\|Weave Home directory"; }
go() { # go <name> [dw args...]
  n=$1; shift
  { $DW run -s "$@" -f $C/$n.dwl 2>&1; echo "exit=$?"; } | strip > $n.out
  printf '%-32s %s\n' "$n" "$(grep -o 'exit=[0-9]*' $n.out)"
}
J="-i payload=$C/order.json"; P="--path=$C"
go 01_import_name $J $P
go 02_import_star $J $P
go 03_import_alias $J $P
go 03b_import_qualified $J $P
go 04_no_path_fails $J
go 05_module_with_body_fails $J $P
go 06_type_mismatch_fails $P
go 06b_type_mismatch_string $P
go 07_ambiguous_import $J $P
go 07b_ambiguous_import_swapped $J $P
go 07c_untyped_both $J $P
# validate: parse/type check only, no input
{ $DW validate -f $C/08_validate_bad.dwl 2>&1; echo "exit=$?"; } | strip > 08_validate_bad.out
{ $DW validate -f $C/08b_validate_unresolved.dwl 2>&1; echo "exit=$?"; } | strip > 08b_validate_unresolved.out
{ $DW validate -f $C/01_import_name.dwl 2>&1; echo "exit=$?"; } | strip > 08c_validate_good_no_path.out
go 09_params $J -p env=prod -p taxRate=0.2
# inline script and a literal input
{ $DW run -s $P -li 'payload={"items":[{"sku":"PEN-01","price":2.5,"qty":4}]}' 'input payload application/json import orderTotal from orders::OrderMath output application/json --- orderTotal(payload.items)' 2>&1; echo "exit=$?"; } | strip > 10_inline_literal.out
go 11_dwtest $P
go 11b_dwtest_bare $P
# golden file: diff against the committed golden. A check never rewrites it;
# BLESS=1 ./run.sh regenerates it on purpose, the chapter's "when the change is intended" step.
if [ "${BLESS:-}" = 1 ]; then $DW run -s $J $P -f $C/12_normalize_order.dwl -o $C/golden/order-normalized.json >/dev/null 2>&1; fi
[ -f golden/order-normalized.json ] || { echo "golden/order-normalized.json is missing: commit it, or run BLESS=1 ./run.sh" >&2; exit 1; }
{ $DW run -s $J $P -f $C/12_normalize_order.dwl -o $C/actual.json 2>&1; diff golden/order-normalized.json actual.json && echo "golden: OK"; echo "exit=$?"; } | strip > 12_golden_diff.out
{ $DW run -s $J $P -f $C/12b_normalize_order_changed.dwl -o $C/actual.json 2>&1; diff golden/order-normalized.json actual.json && echo "golden: OK"; echo "exit=$?"; } | strip > 12b_golden_diff_changed.out
go 13_assert_in_script $P
go 13b_assert_fail_loud $P
{ $DW spell list 2>&1; echo "exit=$?"; } | strip | head -3 > 14_spell_list.out
# added in the ch14 text pass: import-order rule, named collision, validate -i, a module run as a script, aliasing
go 07d_untyped_swapped $J $P
go 07e_named_collision $J $P
{ $DW validate -i payload -f $C/08b_validate_unresolved.dwl 2>&1; echo "exit=$?"; } | strip > 08d_validate_implicit_input.out
go 15_module_run_directly $P
{ $DW run -s $P -f $C/orders/OrderMath.dwl 2>&1; echo "exit=$?"; } | strip > 15b_ordermath_run_directly.out
go 16_alias_both $J $P
