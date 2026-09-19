#!/bin/sh
# Regenerates every *.out beside its probe. Run from anywhere.
cd "$(dirname "$0")"; DW=../../dw.sh; C=chapters/16-a-real-transform
strip() { sed -E 's/\x1b\[[0-9;]*m//g' | grep -v "sun.misc.Unsafe\|Please consider reporting\|terminally deprecated\|Weave Home directory"; }
go() { # go <name> [dw args...]
  n=$1; shift
  { $DW run -s "$@" -f $C/$n.dwl 2>&1; echo "exit=$?"; } | strip > $n.out
  printf '%-32s %s\n' "$n" "$(grep -o 'exit=[0-9]*' $n.out)"
}
X="-i payload=$C/feed.xml"; P="--path=$C"
go 01_shape $X
go 01b_no_namespace $X
go 01c_single_selector_collapses $X
go 01d_map_on_single_fails $X
go 01e_cdata_and_attrs $X
go 01f_string_arithmetic $X
go 02_helper_smoke $P
go 02b_helper_bad_date_fails $P
go 02c_money_bad_fails $P
go 02d_dollar_in_string_fails
go 03_normalize $X $P
go 03b_no_path_fails $X
go 04_final $X $P
go 04b_plain_key_trap $X $P
go 05_exercise_precedence_fails $X $P
go 05b_exercise_by_tier $X $P
go 06_exercise_empty_order -i payload=$C/feed_empty_order.xml $P
go 06b_exercise_empty_order_guarded -i payload=$C/feed_empty_order.xml $P
go 07_exercise_xml_out $X $P
# --- added in the ch16 depth pass
go 02e_naive_date_fails $X
go 02f_date_keeps_format $P
go 03c_missing_import_fails $X $P
go 02g_matches_semantics
go 02h_ddmm_fails $P
go 06c_final_on_empty_order -i payload=$C/feed_empty_order.xml $P
