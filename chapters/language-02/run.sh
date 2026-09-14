#!/bin/sh
# Regenerates every *.out beside its probe. Run from anywhere.
cd "$(dirname "$0")"; DW=../../dw.sh; C=chapters/language-02
strip() { sed -E 's/\x1b\[[0-9;]*m//g' | grep -v "sun.misc.Unsafe\|Please consider reporting\|terminally deprecated\|Weave Home directory"; }
go() { n=$1; shift
  { $DW run -s "$@" -f $C/$n.dwl 2>&1; echo "exit=$?"; } | strip > $n.out
  printf '%-32s %s\n' "$n" "$(grep -o 'exit=[0-9]*' $n.out)"; }
J="-i payload=$C/order.json"; X="-i payload=$C/order.xml"; N="-i payload=$C/order_no_email.json"
go 01_dots_and_indexes $J
go 02_brackets $J
go 03_hyphen_dot_fails $J
go 04_ranges $J
go 05_missing_key $J
go 06_three_ways_to_sku $J
go 07_repeated_keys $J
go 08_descendant_everything $J
go 09_projection_drops_missing $J
go 10_attributes $X
go 11_attributes_on_json $J
go 12_existence $J
go 13_assertion_ok $J
go 14_assertion_fails $N
go 15_filter_then_index $J
go 17_exercise_units $J
go 18_exercise_assert_no_email $N
go 19_exercise_assert_default $N
go 16a_select_on_null $J
go 16b_select_on_string_fails $J
go 16c_index_on_object $J
go 16d_index_on_number_fails $J
go 04b_range_bounds $J
go 20_filter_index_no_parens $J
go 21_hyphen_date_fails $J
go 22_temporal_selection $J
go 23_final_check $J
go 24_exercise_slices $J
