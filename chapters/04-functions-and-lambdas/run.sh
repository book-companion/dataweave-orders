#!/bin/sh
# Regenerates every *.out beside its probe. Run from anywhere.
cd "$(dirname "$0")"; DW=../../dw.sh; C=chapters/04-functions-and-lambdas
strip() { sed -E 's/\x1b\[[0-9;]*m//g' | grep -v "sun.misc.Unsafe\|Please consider reporting\|terminally deprecated\|Weave Home directory"; }
go() { n=$1; shift
  { $DW run -s "$@" -f $C/$n.dwl 2>&1; echo "exit=$?"; } | strip > $n.out
  printf '%-36s %s\n' "$n" "$(grep -o 'exit=[0-9]*' $n.out)"; }
J="-i payload=$C/order.json"
for n in 01_named_fun 02_typed_fun_rejects 03_lambda_as_output_fails 04_map_lambda 05_map_named 06_map_index 07_shorthands_map 08_shorthands_object 09_third_arg_in_map 10_nested_dollar 11_nested_named 12_arity_too_few 13_arity_too_many 14_extra_args_to_lambda 15_prefix_infix 16_infix_three_params_fails 17_currying 18_currying_map 19_function_as_output_fails 20_compose 21_default_params 22_overloading 23_overloading_no_match 24_recursion 25_var_lambda_recursion_fails 26_fun_forward_reference 27_typed_lambda 28_do_block 29_exercise_apply_to  30_exercise_tax_pipeline 05b_map_named_call 05c_map_prefix_named 05d_map_prefix_lambda 27b_typed_lambda_rejects 31_var_forward_fun_reference 32_var_lambda_infix 33_var_lambda_default 34_var_overload_fails 35_fun_as_value 36_map_var_lambda_bare 37_compose_order_matters 38_dollar_with_named_params 39_twice 40_dollar_in_fun_body 41_dollar_in_prefix_call 42_function_typed_param 43_function_typed_param_rejects 44_shorthands_filter_reduce 45_fun_duplicate_same_sig 46_check_two_param_infix 47_check_two_param_both 48_check_prefix_with_dollar 49_compose_commutes 50_filter_map_chain_parens; do
  go $n $J
done
