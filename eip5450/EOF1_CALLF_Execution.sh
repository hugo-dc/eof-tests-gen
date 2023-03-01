#!/bin/bash

source ../common.sh
source ../common_5450.sh

FNAME="EOF1_CALLF_ExecutionFiller.yml"

init_variables

create_address="a94f5374fce5edbc8e2a8697c15331677e6ebf0b"

c_address="1000000000000000000000000000000000000001"
label="function_1_reaching_max_stack_size_a"
asm0="PUSH1(1) PUSH1(1) PUSH1(0) CALLF(1) PUSH1(0) SSTORE STOP"
asm1="POP $(python -c "print('PUSH1(0) ' *  1023)") $(python -c "print('POP ' * 1023)")RETF"
asm1_tmp="POP PUSH1(0)*1023 POP*1023 RETF"
evm0=$(mnem2evm "$asm0")
evm1=$(mnem2evm "$asm1")
eof=$(eof_gen c:$evm0 C:1:0:$evm1 | tail -n1)
echo "$SP4# CALLF Execution" >> $f1
echo "${SP4}$c_address:" >> $f1
echo "${SP6}balance: 0" >> $f1
echo "$SP6# - Valid function (1) reaching max stack size (1024)" >> $f1
echo "$SP6#   Code to deploy:" >> $f1
echo "$SP6#      Types:   [(0,0), (1,0)]" >> $f1
echo "$SP6#      Code[0]: $asm0" >> $f1
echo "$SP6#      Code[1]: $asm1_tmp" >> $f1
echo "${SP6}code: 0x$eof" >> $f1
echo "${SP6}nonce: 0" >> $f1
echo "${SP6}storage: {}" >> $f1

echo "$SP6- ':label $label :raw 0x$c_address'" >> $f2

echo "$SP6- indexes:" >> $f3
echo "$SP6    data: ':label $label'" >> $f3
echo "$SP6  network:" >> $f3
echo "$SP6    - 'Shanghai'" >> $f3
echo "$SP6  result:" >> $f3
echo "$SP6    a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $f3
echo "$SP6      nonce: 1" >> $f3
echo "$SP6    b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $f3
echo "$SP6      nonce: 0" >> $f3
echo "$SP6      storage: {}" >> $f3
echo "$SP6    $c_address:" >> $f3
echo "$SP6      storage: {}" >> $f3


#eof_init=$(returneofdata $eof | tail -n1); t8n-runner --t8ntool /bin/evm --hard-fork Shanghai --data 0x$eof_init --code 0xef00010100040200010013030000000000000436600080376000368180f56000556001805500  --gas 0xffffff && cat ~/t8n-repl/alloc.json ; exit

c_address="1000000000000000000000000000000000000002"
label="function_1_reaching_max_stack_size_b"
asm0="$(python -c "print('PUSH1(1) ' * 1023)")CALLF(1) STOP"
asm0_tmp="PUSH1(1)*1023 CALLF(1) STOP"
asm1="PUSH1(1) POP RETF"
evm0=$(mnem2evm "$asm0")
evm1=$(mnem2evm "$asm1")
eof=$(eof_gen c:$evm0 c:$evm1 | tail -n1)
echo "${SP4}$c_address:" >> $f1
echo "${SP6}balance: 0" >> $f1
echo "$SP6# - Valid function (1) reaching max stack size (1024)" >> $f1
echo "$SP6#   Code to deploy:" >> $f1
echo "$SP6#      Types:   [(0,0), (0,0)]" >> $f1
echo "$SP6#      Code[0]: $asm0_tmp" >> $f1
echo "$SP6#      Code[1]: $asm1" >> $f1
echo "${SP6}code: 0x$eof" >> $f1
echo "${SP6}nonce: 0" >> $f1
echo "${SP6}storage: {}" >> $f1

echo "$SP6- ':label $label :raw 0x$c_address'" >> $f2

echo "$SP6- indexes:" >> $f3
echo "$SP6    data: ':label $label'" >> $f3
echo "$SP6  network:" >> $f3
echo "$SP6    - 'Shanghai'" >> $f3
echo "$SP6  result:" >> $f3
echo "$SP6    a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $f3
echo "$SP6      nonce: 1" >> $f3
echo "$SP6    b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $f3
echo "$SP6      nonce: 0" >> $f3
echo "$SP6      storage: {}" >> $f3
echo "$SP6    $c_address:" >> $f3
echo "$SP6      storage: {}" >> $f3

c_address="1000000000000000000000000000000000000003"
label="function_1_reaching_max_stack_size_c"
asm0="PUSH1(1) PUSH1(0) PUSH1(0) CALLF(1) PUSH1(1) SSTORE STOP"
asm1="POP RJUMPI(exit) $(python -c "print('PUSH1(1) ' * 1023)")$(python -c "print('POP ' * 1023)")exit: RETF"
asm1_tmp="POP RJUMPI(exit) PUSH1(1)*1023 POP*1023 exit: RETF"
evm0=$(mnem2evm "$asm0")
evm1=$(mnem2evm "$asm1")
eof=$(eof_gen c:$evm0 C:2:0:$evm1 | tail -n1)
echo "${SP4}$c_address:" >> $f1
echo "${SP6}balance: 0" >> $f1
echo "$SP6# - Valid function (1) reaching max stack size (1024)" >> $f1
echo "$SP6#   Code to deploy:" >> $f1
echo "$SP6#      Types:   [(0,0), (0,0)]" >> $f1
echo "$SP6#      Code[0]: $asm0" >> $f1
echo "$SP6#      Code[1]: $asm1_tmp" >> $f1
echo "${SP6}code: 0x$eof" >> $f1
echo "${SP6}nonce: 0" >> $f1
echo "${SP6}storage: {}" >> $f1

echo "$SP6- ':label $label :raw 0x$c_address'" >> $f2

echo "$SP6- indexes:" >> $f3
echo "$SP6    data: ':label $label'" >> $f3
echo "$SP6  network:" >> $f3
echo "$SP6    - 'Shanghai'" >> $f3
echo "$SP6  result:" >> $f3
echo "$SP6    a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $f3
echo "$SP6      nonce: 1" >> $f3
echo "$SP6    b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $f3
echo "$SP6      nonce: 0" >> $f3
echo "$SP6      storage: {}" >> $f3
echo "$SP6    $c_address:" >> $f3
echo "$SP6      storage: {}" >> $f3

#eof_init=$(returneofdata $eof | tail -n1); t8n-runner --t8ntool /bin/evm --hard-fork Shanghai --code 0x$eof  --gas 0xffffff && cat ~/t8n-repl/alloc.json

update_filler

echo "done"
