#!/bin/bash

empty_eof=$(eof_gen c:fe | tail -n1)

address=$(create_address $create_address 0)

label="eof_initcode"
asm="PUSH20(0x$empty_eof) PUSH1(96) SHL PUSH1(0) MSTORE PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)

if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof)
fi
echo "$SP6# Code to deploy: $empty_eof" >> $field1
echo "$SP6# Valid EOF initcode containing type section and empty data section" >> $field1
echo "$SP6# Types: [(0,0)]" >> $field1
echo "$SP6# Code: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2


label="eof_initcode_with_data"
asm="PUSH1(20) PUSH1(31) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof)
fi

echo "$SP6# Valid EOF initcode containing type section and data section" >> $field1
echo "$SP6# Types: [(0,0)]" >> $field1
echo "$SP6# Code: $asm" >> $field1
echo "$SP6# Data: $empty_eof (code to deploy)" >> $field1
echo "$SP6- ':label $label 0x$eof'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_multiple_code_sections"
asm="PUSH20(0x$empty_eof) PUSH1(96) SHL PUSH1(0) MSTORE PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
asm2="INVALID"
evm2=$(mnem2evm "$asm2")
eof=$(eof_gen c:$evm c:$evm2 | tail -n1) 

if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof)
fi
echo "$SP6# Valid EOF Initcode containing multiple code sections" >> $field1
echo "$SP6# Types: [(0,0), (0,0)]" >> $field1
echo "$SP6# Code[0]: $asm" >> $field1
echo "$SP6# Code[1]: INVALID" >> $field1
echo "$SP6- ':label $label :raw 0x$eof'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2


label="eof_initcode_multiple_code_sections_with_data"
asm="PUSH1(20) PUSH1(38) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
asm2="INVALID"
evm2=$(mnem2evm "$asm2")
eof=$(eof_gen c:$evm c:$evm2 d:$empty_eof | tail -n1)

if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof)
fi
echo "$SP6# Valid EOF Initcode containing multiple code sections and single data section" >> $field1
echo "$SP6# Types: [(0,0), (0,0)]" >> $field1
echo "$SP6# Data: $empty_eof" >> $field1
echo "$SP6# Code[0]: $asm" >> $field1
echo "$SP6# Code[1]: $asm2" >> $field1
echo "$SP6- ':label $label :raw 0x$eof'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2


label="eof_initcode_multiple_code_sections_no_void_io_types"
asm="PUSH20(0x$empty_eof) PUSH1(96) SHL PUSH1(0) MSTORE PUSH1(20) PUSH1(0) RETURN"
asm2="POP STOP"
asm3="ADDRESS STOP"
asm4="DUP1 STOP"
evm=$(mnem2evm "$asm")
evm2=$(mnem2evm "$asm2")
evm3=$(mnem2evm "$asm3")
evm4=$(mnem2evm "$asm4")
eof=$(eof_gen c:$evm C:1:0:$evm2 C:0:1:$evm3 C:2:3:$evm4 | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof)
fi
echo "$SP6# Valid EOF Initcode containing multiple code sections, no-void input/output types" >> $field1
echo "$SP6# Types: [(0,0), (1, 0), (0, 1), (2, 3)]" >> $field1
echo "$SP6# Code[0] $asm" >> $field1
echo "$SP6# Code[1] $asm2" >> $field1
echo "$SP6# Code[2] $asm3" >> $field1
echo "$SP6# Code[3] $asm4" >> $field1
echo "$SP6- ':label $label :raw 0x$eof'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_multiple_code_sections_no_void_io_types_with_data"
asm="PUSH1(20) PUSH1(55) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
asm2="POP STOP"
asm3="ADDRESS STOP"
asm4="DUP1 STOP"
evm=$(mnem2evm "$asm")
evm2=$(mnem2evm "$asm2")
evm3=$(mnem2evm "$asm3")
evm4=$(mnem2evm "$asm4")
eof=$(eof_gen c:$evm C:1:0:$evm2 C:0:1:$evm3 C:2:3:$evm4 d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof)
fi
echo "$SP6# Valid EOF Initcode containing multiple code sections, no-void input/output types, containing data section" >> $field1
echo "$SP6# Types: [(0,0), (1,0), (0,1), (2,3)]" >> $field1
echo "$SP6# Data: $empty_eof" >> $field1
echo "$SP6# Code[0]: $asm" >> $field1
echo "$SP6# Code[1]: $asm2" >> $field1
echo "$SP6# Code[2]: $asm3" >> $field1
echo "$SP6# Code[3]: $asm4" >> $field1
echo "$SP6- ':label $label :raw 0x$eof'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_max_code_sections"
asm="PUSH20(0x$empty_eof) PUSH1(96) SHL PUSH1(0) MSTORE PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
invalid_1023=$(python -c "print(\"c:fe \" * 1023)")
eof=$(eof_gen c:$evm $invalid_1023 | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof)
fi
echo "$SP6# Valid EOF initcode containing the maximum number of code sections" >> $field1
echo "$SP6# Types: [(0,0), ..., (0, 0)] (1024 types)" >> $field1
echo "$SP6# Code[0]: $asm" >> $field1
echo "$SP6# Code[1]: INVALID" >> $field1
echo "$SP6# ..." >> $field1
echo "$SP6# Code[1023]: INVALID" >> $field1
echo "$SP6- ':label $label :raw 0x$eof'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_max_code_sections_with_data"
asm="PUSH1(20) PUSH2(0x1c19) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm $invalid_1023 d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof)
fi
echo "$SP6# Valid EOF initcode containing the maximum number of code sections and data section" >> $field1
echo "$SP6# Types: [(0,0), ..., (0, 0)] (1024 types)" >> $field1
echo "$SP6# Data: $empty_eof" >> $field1
echo "$SP6# Code[0]: $asm" >> $field1
echo "$SP6# Code[1]: INVALID" >> $field1
echo "$SP6# ..." >> $field1
echo "$SP6# Code[1023]: INVALID" >> $field1
echo "$SP6- ':label $label :raw 0x$eof'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_deploying_eof_with_type"
asm="INVALID"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
eof_initcode=$(returneofdata $eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# Valid EOF initcode deploying code containing single type section" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Types: [(0,0)]" >> $field1
echo "$SP6#   - Code: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_initcode'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_deploying_eof_with_type_and_data"
asm="INVALID"
evm=$(mnem2evm "$asm")
data="DA"
eof=$(eof_gen c:$evm d:$data | tail -n1)
eof_initcode=$(returneofdata $eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# Valid EOF initcode deploying code containing single type section" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Types: [(0,0)]" >> $field1
echo "$SP6#   - Code: $asm" >> $field1
echo "$SP6#   - Data: $data" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_initcode'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_deploying_eof_with_multiple_code_sections"
asm="INVALID"
asm2="INVALID"
evm=$(mnem2evm $asm)
evm2=$(mnem2evm $asm2)
eof=$(eof_gen c:$evm c:$evm2 | tail -n1)
eof_initcode=$(returneofdata $eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# Valid EOF initcode deploying valid EOF containing multiple code sections" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Types: [(0,0), (0,0)]" >> $field1
echo "$SP6#   - Code[0]: $asm" >> $field1
echo "$SP6#   - Code[1]: $asm2" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_initcode'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_deploying_eof_with_multiple_code_sections_and_data"
asm="INVALID"
asm2="INVALID"
evm=$(mnem2evm $asm)
evm2=$(mnem2evm $asm2)
data="DA"
eof=$(eof_gen c:$evm c:$evm2 d:$data | tail -n1)
eof_initcode=$(returneofdata $eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# Valid EOF initcode deploying valid EOF containing multiple code sections and data section" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Types: [(0,0), (0,0)]" >> $field1
echo "$SP6#   - Code[0]: $asm" >> $field1
echo "$SP6#   - Code[1]: $asm2" >> $field1
echo "$SP6#   - Data: $data" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_initcode'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_deploying_eof_multiple_code_sections_no_void_io_types"
asm="INVALID"
evm=$(mnem2evm "$asm")
asm2="POP STOP"
evm2=$(mnem2evm "$asm2")
asm3="ADDRESS STOP"
evm3=$(mnem2evm "$asm3")
asm4="DUP1 STOP"
evm4=$(mnem2evm "$asm4")
eof=$(eof_gen c:$evm C:1:0:$evm2 C:0:1:$evm3 C:2:3:$evm4 | tail -n1)
eof_initcode=$(returneofdata $eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi

echo "$SP6# Valid EOF initcode deploying valid EOF containing multiple code sections, no void input/output types" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Types: [(0,0), (1,0), (0,1), (2,3)]" >> $field1
echo "$SP6#   - Code[0]: $asm" >> $field1
echo "$SP6#   - Code[1]: $asm2" >> $field1
echo "$SP6#   - Code[2]: $asm3" >> $field1
echo "$SP6#   - Code[3]: $asm4" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_initcode'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_deploying_eof_multiple_code_sections_no_void_io_types_with_data"
asm="INVALID"
evm=$(mnem2evm "$asm")
asm2="POP STOP"
evm2=$(mnem2evm "$asm2")
asm3="ADDRESS STOP"
evm3=$(mnem2evm "$asm3")
asm4="DUP1 STOP"
evm4=$(mnem2evm "$asm4")
data="DA"
eof=$(eof_gen c:$evm C:1:0:$evm2 C:0:1:$evm3 C:2:3:$evm4 d:$data | tail -n1)
eof_initcode=$(returneofdata $eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# Valid EOF initcode deploying valid EOF containing multiple code sections, no void input/output types, containing data section" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Types: [(0,0), (1,0), (0,1), (2,3)]" >> $field1
echo "$SP6#   - Code[0]: $asm" >> $field1
echo "$SP6#   - Code[1]: $asm2" >> $field1
echo "$SP6#   - Code[2]: $asm3" >> $field1
echo "$SP6#   - Code[3]: $asm4" >> $field1
echo "$SP6#   - Data: $data" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_initcode'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_deploying_eof_terminating_retf"
asm="RETF"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
eof_initcode=$(returneofdata $eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# Valid EOF initcode deploying EOF code containing RETF as terminating instruction" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Code: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_initcode'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_deploying_eof_terminating_retf_with_data"
asm="RETF"
evm=$(mnem2evm "$asm")
data="DA"
eof=$(eof_gen c:$evm d:$data | tail -n1)
eof_initcode=$(returneofdata $eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi

echo "$SP6# Valid EOF initcode deploying EOF code containing RETF as terminating instruction and data section" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Code: $asm" >> $field1
echo "$SP6#   - Data: $data" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_initcode'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_deploying_eof_max_code_sections"
asm="INVALID"
evm=$(mnem2evm "$asm")
params=$(python -c "print(\"c:$evm \" * 1024)")
eof=$(eof_gen $params | tail -n1)
eof_initcode=$(returneofdata $eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# Valid EOF initcode deploying valid EOF containing the maximum number of code sections" >> $field1
echo "$SP6# Code to deploy: EOF code containing 1024 code sections" >> $field1
echo "$SP6#   - Types: [(0,0), ..., (0,0)] (Type (0,0) repeated 1024 times" >> $field1
echo "$SP6#   - Code[0]: $asm" >> $field1
echo "$SP6#   - ..." >> $field1
echo "$SP6#   - Code[1023]: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_initcode'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof_initcode_deploying_eof_max_code_sections_with_data"
asm="INVALID"
evm=$(mnem2evm "$asm")
data="DA"
params=$(python -c "print(\"c:$evm \" * 1024)")
eof=$(eof_gen $params d:$data | tail -n1)
eof_initcode=$(returneofdata $eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# Valid EOF initcode deploying valid EOF containing the maximum number of code sections, and data section" >> $field1
echo "$SP6# Code to deploy: EOF code containing 1024 code sections" >> $field1
echo "$SP6#   - Types: [(0,0), ..., (0,0)] (Type (0,0) repeated 1024 times" >> $field1
echo "$SP6#   - Code[0]: $asm" >> $field1
echo "$SP6#   - ..." >> $field1
echo "$SP6#   - Code[1023]: $asm" >> $field1
echo "$SP6#   - Data: $data" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_initcode'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
if [[ "$create_address" !=  "a94f5374fce5edbc8e2a8697c15331677e6ebf0b" ]]; then
  echo "$SP6   $create_address:" >> $field2
  echo "$SP6      nonce: 1" >> $field2
  echo "$SP6      storage:" >> $field2
  echo "$SP6        '0': '${address:2}'" >> $field2
  echo "$SP6        '1': '1'" >> $field2
fi
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

