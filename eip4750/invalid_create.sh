#!/bin/bash

wrong_eof=$(eof_dasm "$empty_eof" -t)
echo "$SP6# Initcode trying to deploy EOF code missing mandatory type section" >> $f1
echo "$SP6# Code to deploy: $wrong_eof" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof\" }'" >> $f1

extra_type=$(eof_dasm "$empty_eof" -m -v -c -d -ts -cs -ds -tm)
wrong_eof1="$(eof_dasm "$empty_eof" -c -d -ts -cs -ds -tm)$extra_type$(eof_dasm "$empty_eof" -m -v -t)"
eof=$(eof_gen c:fe c:fe | tail -n1)
wrong_eof2="$(eof_dasm "$eof" -d -ts -cs -ds -tm)$extra_type$(eof_dasm "$eof" -m -v -t -c)"
echo "$SP6# Initcode trying to deploy EOF code containing multiple type sections" >> $f1
echo "$SP6# Code to deploy: $wrong_eof1" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof1\" }'" >> $f1
echo "$SP6# Code to deploy: $wrong_eof2" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof2\" }'" >> $f1

type_header1="010001"
type_header2="010008"
type_header3="010008"
eof=$(eof_gen c:fe c:fe c:fe | tail -n1)
wrong_eof1=$(eof_dasm "$empty_eof" -t -c -d -ts -cs -ds -tm)$type_header1$(eof_dasm "$empty_eof" -m -v -t)
wrong_eof2=$(eof_dasm "$empty_eof" -t -c -d -ts -cs -ds -tm)$type_header2$(eof_dasm "$empty_eof" -m -v -t)
wrong_eof3=$(eof_dasm "$eof" -t -c -d -ts -cs -ds -tm)$type_header3$(eof_dasm "$eof" -m -v -t -ts 2)
echo "$SP6# Initcode trying to deploy EOF code containing invalid type section size" >> $f1
echo "$SP6# Code to deploy: $wrong_eof1" >> $f1
echo "$SP6# - Size: 1" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof1\" }'" >> $f1
echo "$SP6# Code to deploy: $wrong_eof2" >> $f1
echo "$SP6# - Size: 8 - 1 code section" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof2\" }'" >> $f1
echo "$SP6# Code to deploy: $wrong_eof3" >> $f1
echo "$SP6# - Size: 8 - 3 code sections" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof3\" }'" >> $f1

max_stack="$(eof_dasm "$empty_eof" -m -v -t -c -d -tm -cs -ds )"
max_stack=${max_stack:4}
type_section1="0100$max_stack"
type_section2="0001$max_stack"
type_section3="0203$max_stack"
wrong_eof1="$(eof_dasm "$empty_eof" -ts -cs -ds)$type_section1$(eof_dasm "$empty_eof" -m -v -t -c -d -tm -ts)"
wrong_eof2="$(eof_dasm "$empty_eof" -ts -cs -ds)$type_section2$(eof_dasm "$empty_eof" -m -v -t -c -d -tm -ts)"
wrong_eof3="$(eof_dasm "$empty_eof" -ts -cs -ds)$type_section3$(eof_dasm "$empty_eof" -m -v -t -c -d -tm -ts)"
echo "$SP6# Initcode trying to deploy EOF containing invalid section type" >> $f1
echo "$SP6# Code to deploy: $wrong_eof1" >> $f1
echo "$SP6# - Input: 1, Output 0 (First code section must have input 0, output 0)" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof1\" }'" >> $f1
echo "$SP6# Code to deploy: $wrong_eof2" >> $f1
echo "$SP6# - Input: 0, Output 1 (First code section must have input 0, output 0)" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof2\" }'" >> $f1
echo "$SP6# Code to deploy: $wrong_eof3" >> $f1
echo "$SP6# - Input: 2, Output 3 (First code section must have input 0, output 0)" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof3\" }'" >> $f1

params=$(python -c "print(\"c:fe \" * 1025)")
wrong_eof="$(eof_gen $params | tail -n 1)"
echo "$SP6# Initcode trying to deploy EOF containing too many code sections (1025)" >> $f1
echo "$SP6# - Code to deploy: EOF with 1025 code sections each one containing the INVALID opcode" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof\" }'" >> $f1

asm="CALLF(1) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# Initcode trying to deploy EOF containing CALLF to a non existing code section" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $f1

asm="CALLF(1)"
evm=$(mnem2evm "$asm")
wrong_evm="${evm::-2}"
eof=$(eof_gen c:$wrong_evm | tail -n1)
echo "$SP6# Initcode trying to deploy EOF containing truncated CALLF"  >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $f1

asm="PUSH1(4) JUMP INVALID JUMPDEST PUSH1(1) PUSH1(1) SSTORE STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# Initcode trying to deploy EOF containing deprecated instruction:" >> $f1
echo "$SP6# - JUMP" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $f1

asm="PUSH1(6) PUSH1(1) JUMPI INVALID JUMPDEST PUSH1(1) PUSH1(1) SSTORE STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# - JUMPI" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $f1

asm="PC PUSH1(1) SSTORE STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# - PC" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $f1

asm1="CALLF(1) STOP"
asm2="ADD RETF"
evm1=$(mnem2evm "$asm1" | tail -n1)
evm2=$(mnem2evm "$asm2" | tail -n1)
eof=$(eof_gen c:$evm1 C:2:1:$evm2 | tail -n1)
echo "$SP6# Initcode trying to deploy invalid EOF calling functions without required stack" >> $f1
echo "$SP6# - Required stack specified in Type input/output" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $f1

asm1="PUSH1(1) PUSH1(1) CALLF(1) STOP"
asm2="ADD RETF"
evm1=$(mnem2evm "$asm1" | tail -n1)
evm2=$(mnem2evm "$asm2" | tail -n1)
eof=$(eof_gen c:$evm1 c:$evm2 | tail -n1)
echo "$SP6# - Required stack NOT specified in Type input/output" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $f1

asm1="CALLF(1) STOP"
asm2="PUSH1(1) RETF"
evm1=$(mnem2evm "$asm1" | tail -n1)
evm2=$(mnem2evm "$asm2" | tail -n1)
eof=$(eof_gen c:$evm1 c:$evm2 | tail -n1)
echo "$SP6# Initcode trying to deploy invalid EOF code trying to return more items than specified in type outputs" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $f1

asm1="PUSH1(1) $(python -c "print('DUP1 ' * 1022)")CALLF(1) STOP"
asm2="PUSH1(2) DUP DUP RETF"
evm1=$(mnem2evm "$asm1" | tail -n1)
evm2=$(mnem2evm "$asm2" | tail -n1)
eof=$(eof_gen c:$evm1 C:0:3:$evm2 | tail -n1)
echo "$SP6# Initcode trying to deploy invalid EOF code containing function reaching max stack items" >> $f1
echo "$SP6- ':yul-eof object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $f1

