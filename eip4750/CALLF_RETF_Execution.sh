#!/bin/bash
source ../common.sh
source ../common_4750.sh

FNAME="CALLF_RETF_ExecutionFiller.yml"

init_variables $1

asm0="PUSH1(1) PUSH1(8) CALLF(1) PUSH1(0) MSTORE PUSH1(32) PUSH1(0) RETURN"
asm1="SUB RETF"
evm0=$(mnem2evm "$asm0")
evm1=$(mnem2evm "$asm1")

eof=$(eof_gen c:$evm0 C:2:1:$evm1 | tail -n 1)

echo "$SP6# Simple CALLF/RETF Test" >> $f1
echo "$SP6#   Types: [(0,0), (2,1)]" >> $f1
echo "$SP6#   Code[0]: $asm0"        >> $f1
echo "$SP6#   Code[1]: $asm1"        >> $f1
echo "${SP6}code: ':raw 0x$eof'"   >> $f1

asm0="PUSH1(4) CALLDATALOAD PUSH1(0) CALLDATALOAD PUSH1(224) SHR PUSH4(0xC7665267) DUP2 EQ RJUMPI(28) PUSH4(0xC6C2EA17) DUP2 EQ  RJUMPI(6) POP POP PUSH1(0) DUP1 REVERT POP CALLF(2) PUSH1(0) MSTORE PUSH1(32) PUSH1(0) RETURN POP CALLF(1) PUSH1(0) MSTORE PUSH1(32) PUSH1(0) RETURN"
asm1="PUSH1(1) DUP2 GT RJUMPI(4) POP PUSH1(1) RETF PUSH1(1) DUP2 SUB CALLF(1) DUP2 MUL SWAP1 POP RETF"
asm2="PUSH1(2) DUP2 GT RJUMPI(4) POP PUSH1(1) RETF PUSH1(2) DUP2 SUB CALLF(2) PUSH1(1) DUP3 SUB CALLF(2) ADD SWAP1 POP RETF"

evm0=$(mnem2evm "$asm0")
evm1=$(mnem2evm "$asm1")
evm2=$(mnem2evm "$asm2")

eof=$(eof_gen c:$evm0 C:1:1:$evm1 C:1:1:$evm2 | tail -n 1)
echo "$SP6# CALLF/RETF Test calling two different functions (fibonacci/factorial)" >> $f2
echo "$SP6#   Types: [(0,0), (1,1), (1,1)]" >> $f2
echo "$SP6#   Code[0]: $asm0"        >> $f2
echo "$SP6#   Code[1]: $asm1"        >> $f2
echo "$SP6#   Code[2]: $asm2"        >> $f2
echo "${SP6}code: ':raw 0x$eof'"   >> $f2

asm0="CALLF(1) RETURN"
asm1023="PUSH1(42) PUSH1(0) MSTORE PUSH1(32) PUSH1(0) RETF"
evm0=$(mnem2evm "$asm0")
evm1023=$(mnem2evm "$asm1023")
params=$(python -c "for i in list(range(1022)): print(\"C:0:2:b0{0:04x}b1\".format(i+2), end=' ')") 
eof=$(eof_gen c:$evm0 $params C:0:2:$evm1023 | tail -n1)
echo "$SP6# Containing maximum code sections, calling each section using CALLF" >> $f3
echo "$SP6#   Types: (0,0) * 1024" >> $f3
echo "$SP6#   Code[0]: $asm0" >> $f3
echo "$SP6#   Code[1]: $ams1" >> $f3
echo "$SP6#   Code[1023]: $asm1023" >> $f3
echo "${SP6}code: ':raw 0x$eof'" >> $f3

update_filler

