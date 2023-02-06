#!/bin/bash

source ../common.sh
source ../common_4200.sh

FNAME="CreateTransactionInvalidEOF1Filler.yml"

init_variables $1

field1=$f1
field2=$f2

legacy=1
source ./invalid_create.sh
update_filler

#asm="RJUMP(5) STOP PUSH1(1) RJUMPV(-7) STOP"
#evm=$(mnem2evm "$asm")
#eof=$(eof_gen c:$evm | tail -n1)
#echo "$SP6# - Jump to RJUMPV immediate"
#echo "$SP6# Code to be deployed: $asm - 0x$eof"
#echo "$SP6- ':label valid_init_invalid_code_rjump_to_rjumpv_immediate :yul object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"

#asm1="RJUMP(2) CALLF(1) STOP"
#evm1=$(mnem2evm "$asm1")
#asm2="PUSH1(1) PUSH1(1) SSTORE RETF"
#evm2=$(mnem2evm "$asm2")
#eof=$(eof_gen c:$evm1 c:$evm2 | tail -n1)
#eof_init=$(returneofdata "$eof" | tail -n1)
#echo "$SP6# - Jump to CALLF immediate"
#echo "$SP6# Code to be deployed: $eof"
#echo "$SP6#   [0] $asm1 - 0x$evm1"
#echo "$SP6#   [1] $asm2 - 0x$evm2"
#echo "$SP6- ':label valid_init_invalid_code_rjump_to_callf_immediate :yul object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"


#t8n-runner --t8ntool /bin/evm --hard-fork Shanghai --data 0x$eof_init  --gas 0xffffff && cat ~/t8n-repl/alloc.json

#asm1="PUSH1(1) PUSH1(1) RJUMP(2) CALLF(1) STOP"
#evm1=$(mnem2evm "$asm1")
#asm2="PUSH1(1) PUSH1(1) SSTORE RETF"
#evm2=$(mnem2evm "$asm2")
#eof=$(eof_gen c:$evm1 c:$evm2 | tail -n1)
#eof_init=$(returneofdata "$eof" | tail -n1)
#echo "$SP6# TODO: has to be fixed in geth"
#echo "$SP6# - Jump to CALLF immediate"
#echo "$SP6# Code to be deployed: $eof"
#echo "$SP6#   [0] $asm1 - 0x$evm1"
#echo "$SP6#   [1] $asm2 - 0x$evm2"
#echo "$SP6#- ':label valid_init_invalid_code_rjump_to_callf_immediate2 :yul #object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"

##echo $evm1
#echo $evm2
#eof_gen c:$evm1 c:$evm2
