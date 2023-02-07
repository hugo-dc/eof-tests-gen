#!/bin/bash

empty_eof=$(eof_gen c:fe | tail -n1)
address=$(create_address $create_address 0)

label="eof_initcode_deploying_eof_with_type"
asm="INVALID"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
yul_initcode="object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"
eof_initcode=$(yul_comp "$yul_initcode")
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# EOF initcode deploying code containing single type section" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Types: [(0,0)]" >> $field1
echo "$SP6#   - Code: $asm" >> $field1
echo "$SP6- ':label $label :yul-eof $yul_initcode'" >> $field1

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
yul_initcode="object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"
eof_initcode=$(yul_comp "$yul_initcode")
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# EOF initcode deploying code containing single type section" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Types: [(0,0)]" >> $field1
echo "$SP6#   - Code: $asm" >> $field1
echo "$SP6#   - Data: $data" >> $field1
echo "$SP6- ':label $label :yul-eof $yul_initcode '" >> $field1

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
yul_initcode="object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"
eof_initcode=$(yul_comp "$yul_initcode")
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# EOF initcode deploying valid EOF containing multiple code sections" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Types: [(0,0), (0,0)]" >> $field1
echo "$SP6#   - Code[0]: $asm" >> $field1
echo "$SP6#   - Code[1]: $asm2" >> $field1
echo "$SP6- ':label $label :yul-eof $yul_initcode'" >> $field1

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
yul_initcode="object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"
eof_initcode=$(yul_comp "$yul_initcode")
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# EOF initcode deploying valid EOF containing multiple code sections and data section" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Types: [(0,0), (0,0)]" >> $field1
echo "$SP6#   - Code[0]: $asm" >> $field1
echo "$SP6#   - Code[1]: $asm2" >> $field1
echo "$SP6#   - Data: $data" >> $field1
echo "$SP6- ':label $label :yul-eof $yul_initcode'" >> $field1

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
yul_initcode="object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"
eof_initcode=$(yul_comp "$yul_initcode")
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi

echo "$SP6# EOF initcode deploying valid EOF containing multiple code sections, no void input/output types" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Types: [(0,0), (1,0), (0,1), (2,3)]" >> $field1
echo "$SP6#   - Code[0]: $asm" >> $field1
echo "$SP6#   - Code[1]: $asm2" >> $field1
echo "$SP6#   - Code[2]: $asm3" >> $field1
echo "$SP6#   - Code[3]: $asm4" >> $field1
echo "$SP6- ':label $label :yul-eof $yul_initcode'" >> $field1


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
yul_initcode="object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"
eof_initcode=$(yul_comp "$yul_initcode")
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# EOF initcode deploying valid EOF containing multiple code sections, no void input/output types, containing data section" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Types: [(0,0), (1,0), (0,1), (2,3)]" >> $field1
echo "$SP6#   - Code[0]: $asm" >> $field1
echo "$SP6#   - Code[1]: $asm2" >> $field1
echo "$SP6#   - Code[2]: $asm3" >> $field1
echo "$SP6#   - Code[3]: $asm4" >> $field1
echo "$SP6#   - Data: $data" >> $field1
echo "$SP6- ':label $label :yul-eof $yul_initcode'" >> $field1

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
yul_initcode="object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"
eof_initcode=$(yul_comp "$yul_initcode")
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# EOF initcode deploying EOF code containing RETF as terminating instruction" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Code: $asm" >> $field1
echo "$SP6- ':label $label :yul-eof $yul_initcode'" >> $field1

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
yul_initcode="object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"
eof_initcode=$(yul_comp "$yul_initcode")
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi

echo "$SP6# EOF initcode deploying EOF code containing RETF as terminating instruction and data section" >> $field1
echo "$SP6# Code to deploy: $eof" >> $field1
echo "$SP6#   - Code: $asm" >> $field1
echo "$SP6#   - Data: $data" >> $field1
echo "$SP6- ':label $label :yul-eof $yul_initcode'" >> $field1

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
yul_initcode="object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"
eof_initcode=$(yul_comp "$yul_initcode")
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# EOF initcode deploying valid EOF containing the maximum number of code sections" >> $field1
echo "$SP6# Code to deploy: EOF code containing 1024 code sections" >> $field1
echo "$SP6#   - Types: [(0,0), ..., (0,0)] (Type (0,0) repeated 1024 times" >> $field1
echo "$SP6#   - Code[0]: $asm" >> $field1
echo "$SP6#   - ..." >> $field1
echo "$SP6#   - Code[1023]: $asm" >> $field1
echo "$SP6- ':label $label :yul-eof $yul_initcode'" >> $field1

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
yul_initcode="object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }"
eof_initcode=$(yul_comp "$yul_initcode")
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_initcode)
fi
echo "$SP6# EOF initcode deploying valid EOF containing the maximum number of code sections, and data section" >> $field1
echo "$SP6# Code to deploy: EOF code containing 1024 code sections" >> $field1
echo "$SP6#   - Types: [(0,0), ..., (0,0)] (Type (0,0) repeated 1024 times" >> $field1
echo "$SP6#   - Code[0]: $asm" >> $field1
echo "$SP6#   - ..." >> $field1
echo "$SP6#   - Code[1023]: $asm" >> $field1
echo "$SP6#   - Data: $data" >> $field1
echo "$SP6- ':label $label :yul-eof $yul_initcode'" >> $field1

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

