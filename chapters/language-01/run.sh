#!/bin/sh
# Regenerates every *.out beside its probe. Run from anywhere.
cd "$(dirname "$0")"; DW=../../dw.sh; C=chapters/language-01
strip() { sed -E 's/\x1b\[[0-9;]*m//g' | grep -v "sun.misc.Unsafe\|Please consider reporting\|terminally deprecated\|Weave Home directory"; }
go() { # go <name> [dw args...]
  n=$1; shift
  { $DW run -s "$@" -f $C/$n.dwl 2>&1; echo "exit=$?"; } | strip > $n.out
  printf '%-32s %s\n' "$n" "$(grep -o 'exit=[0-9]*' $n.out)"
}
J="-i payload=$C/order.json"; X="-i payload=$C/order.xml"; CSV="-i payload=$C/items.csv"
go 01_hello
go 02_summary $J
go 03_assignment_fails $J
go 04_two_expressions_fail $J
go 05_if_is_an_expression $J
go 06_model_from_json $J
go 07_model_from_xml $X
go 08_summary_from_xml $X
go 09_xml_arithmetic $X
go 10_csv_model $CSV
go 11_csv_arithmetic $CSV
go 12_writers $J
go 13_writer_yaml $J
go 14_writer_csv $J
go 15_xml_needs_root $J
go 16_no_output_directive $J
go 17_now_twice
go 18_header_after_body_fails $J
go 19_var_order $J
go 20_exercise_slim_items $J
go 21_exercise_missing_input
go 22_var_forward_ref $J
go 23_xml_single_key $X
go 24_literal_input -li 'payload={"items":[{"price":2.5,"qty":4}]}'
go 25_random_uuid
go 26_writer_option $J
go 27_exercise_yaml_wrapper $J
{ echo "\$ dw validate -f 02_summary.dwl"; $DW validate -f $C/02_summary.dwl 2>&1; echo "exit=$?"; echo "\$ dw validate -f 03_assignment_fails.dwl"; $DW validate -f $C/03_assignment_fails.dwl 2>&1; echo "exit=$?"; } | strip > 28_validate.out
