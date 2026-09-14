#!/bin/sh
# Regenerates every *.out beside its probe. Run from anywhere.
cd "$(dirname "$0")"; DW=../../dw.sh; C=chapters/language-03
strip() { sed -E 's/\x1b\[[0-9;]*m//g' | grep -v "sun.misc.Unsafe\|Please consider reporting\|terminally deprecated\|Weave Home directory"; }
go() { n=$1; shift
  { $DW run -s "$@" -f $C/$n.dwl 2>&1; echo "exit=$?"; } | strip > $n.out
  printf '%-36s %s\n' "$n" "$(grep -o 'exit=[0-9]*' $n.out)"; }
J="-i payload=$C/order.json"; F="-i payload=$C/order_from_feed.json"
go 01_typeof $J
go 02_feed_types $F
go 03_one_number
go 04_as_basics $J
go 05_as_fails_number
go 06_as_fails_thousands
go 07_as_fails_boolean
go 08_as_fails_date $F
go 09_as_fails_object $J
go 10_feed_totals $F
go 11_implicit_coercion $F
go 12_implicit_coercion_fails $F
go 13_date_parse $F
go 14_date_parse_wrong_format $F
go 15_date_print
go 16_number_format $J
go 17_is $J
go 18_custom_types $J
go 19_literal_type_as_fails
go 20_literal_type_as_ok
go 21_fun_signature $J
go 22_fun_signature_rejects $F
go 23_fun_return_type_rejects
go 24_object_type_as
go 25_exercise_feed_total $F
go 26_exercise_feed_total_no_coercion $F
go 27_exercise_tier_guard
go 04b_as_null_fails $J
go 06b_as_spaces
go 06c_as_trailing
go 07b_number_as_boolean
go 16b_as_precedence
go 17b_generic_array_is
go 22b_fun_signature_rejects $F
go 22c_fun_string_param_given_number $J
go 22d_fun_array_param_given_object $J
go 13b_schema_sticks $F
