#!/bin/bash
if [ -f .lint ];then
    exec verilator -f .lint $@ -Wall -Wno-PINCONNECTEMPTY -Wno-DECLFILENAME -Wno-DEFPARAM
else
    exec verilator $@ -Wall -Wno-PINCONNECTEMPTY -Wno-DECLFILENAME -Wno-DEFPARAM
fi
