#!/bin/sh

#cleanup
rm -rf obj_dir
rm -f sinegen.vcd

# run Verilator to translate Verilog into C++, including C++ testbench 
verilator -Wall --cc --trace sinegen.sv --exe sinegen_tb.cpp

#build C++ project via make automatically generated by Verilator
make -j -C obj_dir/ -f Vsinegen.mk Vsinegen

obj_dir/Vsinegen
