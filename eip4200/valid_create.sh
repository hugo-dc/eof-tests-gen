#!/bin/bash

empty_eof=$(eof_gen c:fe | tail -n1)
address=$(create_address $create_address 0)

label="eof1_initcode_rjump_pos"
asm="RJUMP(3) NOP NOP RETURN PUSH1(20) PUSH1(39) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RJUMP(-17)"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi
echo "$SP6# Valid EOF initcode containing RJUMP" >> $field1
echo "$SP6# - Positive, Negative:" >> $field1
echo "$SP6# Deployed code: $empty_eof (contained in initcode data)" >> $field1
echo "$SP6# Initcode: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof1_initcode_rjump_zer"
asm="RJUMP(0) PUSH1(20) PUSH1(34) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi

echo "$SP6# - Zero:" >> $field1
echo "$SP6# Deployed code: $empty_eof (contained in initcode data)" >> $field1
echo "$SP6# Initcode: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2


label="eof1_initcode_rjumpi_pos"
asm="PUSH1(1) RJUMPI(3) NOP NOP STOP PUSH1(20) PUSH1(39) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi

echo "$SP6# Valid EOF initcode containing RJUMPI" >> $field1
echo "$SP6# - Positive:" >> $field1
echo "$SP6# Initcode (data): $empty_eof (code to be deployed)" >> $field1
echo "$SP6# Initcode: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2


label="eof1_initcode_rjumpi_neg"
asm="RJUMP(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPI(-17) STOP"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi

echo "$SP6# - Negative:" >> $field1
echo "$SP6# Initcode (data): $empty_eof (code to be deployed)" >> $field1
echo "$SP6# Initcode: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2


label="eof1_initcode_rjumpi_zer"
asm="PUSH1(1) RJUMPI(0) PUSH1(20) PUSH1(36) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi

echo "$SP6# - Zero:" >> $field1
echo "$SP6# Initcode (data): $empty_eof (code to be deployed)" >> $field1
echo "$SP6# Initcode: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2


label="eof1_initcode_rjumpv_1_pos"
asm="PUSH1(0) RJUMPV(3) NOP NOP STOP PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi

echo "$SP6# Valid EOF initcode with RJUMPV table size 1" >> $field1
echo "$SP6# - Positive:" >> $field1
echo "$SP6# Initcode (data): $empty_eof (code to be deployed)" >> $field1
echo "$SP6# Initcode: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1


echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2


label="eof1_initcode_rjumpv_1_neg"
asm="RJUMP(12) PUSH1(20) PUSH1(41) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(0) RJUMPV(-18) STOP"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi

echo "$SP6# - Negative:" >> $field1
echo "$SP6# Initcode (data): $empty_eof (code to be deployed)" >> $field1
echo "$SP6# Initcode: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

#eof_gen c:$evm d:$empty_eof

label="eof1_initcode_rjumpv_1_zer"
asm="PUSH1(0) RJUMPV(0) PUSH1(20) PUSH1(37) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi

echo "$SP6# - Zero:" >> $field1
echo "$SP6# Initcode (data): $empty_eof (code to be deployed)" >> $field1
echo "$SP6# Initcode: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2


label="eof1_initcode_rjumpv_2"
asm="PUSH1(0) RJUMPV(3,0,-10) NOP NOP STOP PUSH1(20) PUSH1(44) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi

echo "$SP6# Valid EOF initcode with RJUMPV table size 3" >> $field1
echo "$SP6# Initcode (data): $empty_eof (code to be deployed)" >> $field1
echo "$SP6# Initcode: $asm" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2


label="eof1_initcode_rjumpv_255_0"
asm="PUSH1(0) RJUMPV(103,198,105,115,81,255,74,236,41,205,186,171,242,251,227,70,124,194,84,248,27,232,231,141,118,90,46,99,51,159,201,154,102,50,13,183,49,88,163,90,37,93,5,23,88,233,94,212,171,178,205,198,155,180,84,17,14,130,116,65,33,61,220,135,112,233,62,161,65,225,252,103,62,1,126,151,234,220,107,150,143,56,92,42,236,176,59,251,50,175,60,84,236,24,219,92,2,26,254,67,251,250,170,58,251,41,209,230,5,60,124,148,117,216,190,97,137,249,92,187,168,153,15,149,177,235,241,179,5,239,247,0,233,161,58,229,202,11,203,208,72,71,100,189,31,35,30,168,28,123,100,197,20,115,90,197,94,75,121,99,59,112,100,36,17,158,9,220,170,212,172,242,27,16,175,59,51,205,227,80,72,71,21,92,187,111,34,25,186,155,125,245,11,225,26,28,127,35,248,41,248,164,27,19,181,202,78,232,152,50,56,224,121,77,61,52,188,95,78,119,250,203,108,5,172,134,33,43,170,26,85,162,190,112,181,115,59,4,92,211,54,148,179,175,226,240,228,158,79,50,21,73,253,130,255) NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP PUSH1(20) PUSH2(0x0321) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
asm_tmp="PUSH1(0) RJUMPV(random 255 offsets) NOP * 255 STOP PUSH1(20) PUSH2(0x0321) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi

echo "$SP6# Valid EOF initcode with RJUMPV table size 255" >> $field1
echo "$SP6# Initcode (data): $empty_eof (code to be deployed)" >> $field1
echo "$SP6# Initcode: $asm_tmp" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof1_initcode_rjumpv_255_100"
asm="PUSH1(100) RJUMPV(103,198,105,115,81,255,74,236,41,205,186,171,242,251,227,70,124,194,84,248,27,232,231,141,118,90,46,99,51,159,201,154,102,50,13,183,49,88,163,90,37,93,5,23,88,233,94,212,171,178,205,198,155,180,84,17,14,130,116,65,33,61,220,135,112,233,62,161,65,225,252,103,62,1,126,151,234,220,107,150,143,56,92,42,236,176,59,251,50,175,60,84,236,24,219,92,2,26,254,67,251,250,170,58,251,41,209,230,5,60,124,148,117,216,190,97,137,249,92,187,168,153,15,149,177,235,241,179,5,239,247,0,233,161,58,229,202,11,203,208,72,71,100,189,31,35,30,168,28,123,100,197,20,115,90,197,94,75,121,99,59,112,100,36,17,158,9,220,170,212,172,242,27,16,175,59,51,205,227,80,72,71,21,92,187,111,34,25,186,155,125,245,11,225,26,28,127,35,248,41,248,164,27,19,181,202,78,232,152,50,56,224,121,77,61,52,188,95,78,119,250,203,108,5,172,134,33,43,170,26,85,162,190,112,181,115,59,4,92,211,54,148,179,175,226,240,228,158,79,50,21,73,253,130,255) NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP PUSH1(20) PUSH2(0x0321) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
asm_tmp="PUSH1(100) RJUMPV(random 255 offsets) NOP * 255 STOP PUSH1(20) PUSH2(0x0321) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi

echo "$SP6# Valid EOF initcode with RJUMPV table size 255" >> $field1
echo "$SP6# Initcode (data): $empty_eof (code to be deployed)" >> $field1
echo "$SP6# Initcode: $asm_tmp" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof1_initcode_rjumpv_255_254"
asm="PUSH1(254) RJUMPV(103,198,105,115,81,255,74,236,41,205,186,171,242,251,227,70,124,194,84,248,27,232,231,141,118,90,46,99,51,159,201,154,102,50,13,183,49,88,163,90,37,93,5,23,88,233,94,212,171,178,205,198,155,180,84,17,14,130,116,65,33,61,220,135,112,233,62,161,65,225,252,103,62,1,126,151,234,220,107,150,143,56,92,42,236,176,59,251,50,175,60,84,236,24,219,92,2,26,254,67,251,250,170,58,251,41,209,230,5,60,124,148,117,216,190,97,137,249,92,187,168,153,15,149,177,235,241,179,5,239,247,0,233,161,58,229,202,11,203,208,72,71,100,189,31,35,30,168,28,123,100,197,20,115,90,197,94,75,121,99,59,112,100,36,17,158,9,220,170,212,172,242,27,16,175,59,51,205,227,80,72,71,21,92,187,111,34,25,186,155,125,245,11,225,26,28,127,35,248,41,248,164,27,19,181,202,78,232,152,50,56,224,121,77,61,52,188,95,78,119,250,203,108,5,172,134,33,43,170,26,85,162,190,112,181,115,59,4,92,211,54,148,179,175,226,240,228,158,79,50,21,73,253,130,256) NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP STOP PUSH1(20) PUSH2(0x0322) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
asm_tmp="PUSH1(254) RJUMPV(random 255 offsets) NOP * 255 STOP PUSH1(20) PUSH2(0x0322) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi

echo "$SP6# Valid EOF initcode with RJUMPV table size 255" >> $field1
echo "$SP6# Initcode (data): $empty_eof (code to be deployed)" >> $field1
echo "$SP6# Initcode: $asm_tmp" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

label="eof1_initcode_rjumpv_255_256"
asm="PUSH2(0x100) RJUMPV(103,198,105,115,81,255,74,236,41,205,186,171,242,251,227,70,124,194,84,248,27,232,231,141,118,90,46,99,51,159,201,154,102,50,13,183,49,88,163,90,37,93,5,23,88,233,94,212,171,178,205,198,155,180,84,17,14,130,116,65,33,61,220,135,112,233,62,161,65,225,252,103,62,1,126,151,234,220,107,150,143,56,92,42,236,176,59,251,50,175,60,84,236,24,219,92,2,26,254,67,251,250,170,58,251,41,209,230,5,60,124,148,117,216,190,97,137,249,92,187,168,153,15,149,177,235,241,179,5,239,247,0,233,161,58,229,202,11,203,208,72,71,100,189,31,35,30,168,28,123,100,197,20,115,90,197,94,75,121,99,59,112,100,36,17,158,9,220,170,212,172,242,27,16,175,59,51,205,227,80,72,71,21,92,187,111,34,25,186,155,125,245,11,225,26,28,127,35,248,41,248,164,27,19,181,202,78,232,152,50,56,224,121,77,61,52,188,95,78,119,250,203,108,5,172,134,33,43,170,26,85,162,190,112,181,115,59,4,92,211,54,148,179,175,226,240,228,158,79,50,21,73,253,130,255) NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP NOP PUSH1(20) PUSH2(0x0322) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
asm_tmp="PUSH2(256) RJUMPV(random 255 offsets) NOP * 255 STOP PUSH1(20) PUSH2(0x0322) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN"
evm=$(mnem2evm "$asm")
eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
if [ "$create_type" -eq 2 ]; then
  address=$(create_address2 $create_address "" $eof_init)
fi

#t8n-runner --t8ntool /bin/evm --hard-fork Shanghai --data 0x$eof_init  --gas 0xffffff && cat ~/t8n-repl/alloc.json
echo "$SP6# Valid EOF initcode with RJUMPV table size 255" >> $field1
echo "$SP6# Initcode (data): $empty_eof (code to be deployed)" >> $field1
echo "$SP6# Initcode: $asm_tmp" >> $field1
echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

echo "$SP6- indexes:" >> $field2
echo "$SP6   data: ':label $label'" >> $field2
echo "$SP6  network:" >> $field2
echo "$SP6    - 'Shanghai'" >> $field2
echo "$SP6  result:" >> $field2
echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      storage:" >> $field2
echo "$SP6        '0': '$address'" >> $field2
echo "$SP6        '1': '1'" >> $field2
echo "$SP6   ${address:2}:" >> $field2
echo "$SP6      nonce: 1" >> $field2
echo "$SP6      code: '0x$empty_eof'" >> $field2
echo "$SP6      storage: {}" >> $field2

