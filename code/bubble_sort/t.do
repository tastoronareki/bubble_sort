cd C:/intelFPGA/Projects/bubble_sort/code/pass_swap

if [file exists work] {
    vdel -all
}
vlib work

set vlog "vlog
 ../pair_swap/pair_swap.v
 ../pass_swap/pass_swap.v
 bubble_sort.v t.v"

{*}$vlog

vsim testbench

#add wave -radix unsigned *
#configure wave -namecolwidth 250
#configure wave -valuecolwidth 50
#do wave.do

run -a

alias re "{*}\$vlog; restart -f; run -a"
