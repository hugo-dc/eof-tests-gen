#!/bin/bash

empty_eof=$(eof_gen c:fe | tail -n1)

test_invalid_initcode=0

if [[ "$test_invalid_initcode" -eq 1 ]]; then
    label="invalid_eof_initcode_truncated_rjump"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN STOP"
    asm_wrong="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP("
    evm=$(mnem2evm "$asm")
    evm_wrong="${evm::-2}5c" # Replaces STOP by RJUMP
    eof_init=$(eof_gen c:$evm_wrong d:$empty_eof | tail -n1)
    echo "$SP6# Invalid EOF Initcode containing truncated RJUMP" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
    echo "$SP6# Initcode: $asm_wrong" >> $field1
    echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1

    echo "$SP6- indexes:" >> $field2
    echo "$SP6   data: ':label $label'" >> $field2
    echo "$SP6  network:" >> $field2
    echo "$SP6    - 'Shanghai'" >> $field2
    echo "$SP6  result:" >> $field2
    echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 1" >> $field2
    echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_truncated_rjump2"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN STOP"
    asm_wrong="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(0?"
    evm=$(mnem2evm "$asm")
    evm_wrong="${evm::-2}5c00"
    eof_init=$(eof_gen c:$evm_wrong d:$empty_eof | tail -n1)
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
    echo "$SP6# Initcode: $asm_wrong" >> $field1
    echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1
    echo "$SP6- indexes:" >> $field2
    echo "$SP6   data: ':label $label'" >> $field2
    echo "$SP6  network:" >> $field2
    echo "$SP6    - 'Shanghai'" >> $field2
    echo "$SP6  result:" >> $field2
    echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 1" >> $field2
    echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjump_target_oob"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(-30) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# Invalid EOF Initcode containing RJUMP with target outside of code bounds" >> $field1
    echo "$SP6# - Jump into header" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjump_target_oob2"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(-40) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to before code begin" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjump_target_oob3"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(2) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump into data section" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjump_target_oob4"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(25) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to after code end" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjump_target_oob5"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(21) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to code end" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjump_to_self_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(-1) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# Invalid EOF Initcode containing RJUMP with target PUSH/RJUMP/RJUMPI/RJUMPV immediate " >> $field1
    echo "$SP6# - Jump to same RJUMP immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjump_to_other_rjump_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(1) STOP RJUMP(-5) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to another RJUMP immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjump_to_rjumpi_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(-16) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to RJUMPI immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjump_to_push_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(-5) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to PUSH immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2

    label="invalid_eof_initcode_rjump_to_rjumpv_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(4) PUSH1(255) RJUMPV(0) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to RJUMPV immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2

    label="invalid_eof_initcode_rjumpv_count_0_zero_immediates"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) STOP"
    asm_wrong="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(0) RJUMPV()"
    evm=$(mnem2evm "$asm")
    evm_wrong="${evm::-2}5e00" # Replaces STOP by RJUMPV
    eof_init=$(eof_gen c:$evm_wrong d:$empty_eof | tail -n1)
    echo "$SP6# Invalid EOF Initcode containing containing RJUMPV with count 0, and zero immediates" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
    echo "$SP6# Initcode: $asm_wrong" >> $field1
    echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1
    echo "$SP6- indexes:" >> $field2
    echo "$SP6   data: ':label $label'" >> $field2
    echo "$SP6  network:" >> $field2
    echo "$SP6    - 'Shanghai'" >> $field2
    echo "$SP6  result:" >> $field2
    echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 1" >> $field2
    echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2

    label="invalid_eof_initcode_rjumpv_count_0_one_immediates"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) STOP"
    asm_wrong="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(0) RJUMPV(0)"
    evm=$(mnem2evm "$asm")
    evm_wrong="${evm::-2}5e000000" # Replaces STOP by RJUMPV
    eof_init=$(eof_gen c:$evm_wrong d:$empty_eof | tail -n1)
    echo "$SP6# Invalid EOF Initcode containing containing RJUMPV with count 0, and one immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
    echo "$SP6# Initcode: $asm_wrong" >> $field1
    echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1
    echo "$SP6- indexes:" >> $field2
    echo "$SP6   data: ':label $label'" >> $field2
    echo "$SP6  network:" >> $field2
    echo "$SP6    - 'Shanghai'" >> $field2
    echo "$SP6  result:" >> $field2
    echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 1" >> $field2
    echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_truncated_rjumpv"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) STOP"
    asm_wrong="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(0) RJUMPV("
    evm=$(mnem2evm "$asm")
    evm_wrong="${evm::-2}5e" # Replaces STOP by RJUMPV
    eof_init=$(eof_gen c:$evm_wrong d:$empty_eof | tail -n1)
    echo "$SP6# Invalid EOF Initcode containing containing truncated RJUMPV" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
    echo "$SP6# Initcode: $asm_wrong (no counter, no immediates)" >> $field1
    echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1
    echo "$SP6- indexes:" >> $field2
    echo "$SP6   data: ':label $label'" >> $field2
    echo "$SP6  network:" >> $field2
    echo "$SP6    - 'Shanghai'" >> $field2
    echo "$SP6  result:" >> $field2
    echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 1" >> $field2
    echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2

    label="invalid_eof_initcode_truncated_rjumpv2"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) STOP"
    asm_wrong="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPV(0?"
    evm=$(mnem2evm "$asm")
    evm_wrong="${evm::-2}5e01"
    eof_init=$(eof_gen c:$evm_wrong d:$empty_eof | tail -n1)
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
    echo "$SP6# Initcode: $asm_wrong (only counter, no immediate)" >> $field1
    echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1
    echo "$SP6- indexes:" >> $field2
    echo "$SP6   data: ':label $label'" >> $field2
    echo "$SP6  network:" >> $field2
    echo "$SP6    - 'Shanghai'" >> $field2
    echo "$SP6  result:" >> $field2
    echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 1" >> $field2
    echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2

    label="invalid_eof_initcode_truncated_rjumpv3"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) STOP"
    asm_wrong="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPV(1?"
    evm=$(mnem2evm "$asm")
    evm_wrong="${evm::-2}5e0100"
    eof_init=$(eof_gen c:$evm_wrong d:$empty_eof | tail -n1)
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
    echo "$SP6# Initcode: $asm_wrong (counter, but only 1 byte as immediate)" >> $field1
    echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1
    echo "$SP6- indexes:" >> $field2
    echo "$SP6   data: ':label $label'" >> $field2
    echo "$SP6  network:" >> $field2
    echo "$SP6    - 'Shanghai'" >> $field2
    echo "$SP6  result:" >> $field2
    echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 1" >> $field2
    echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2

    label="invalid_eof_initcode_rjumpv_oob"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(0) RJUMPV(-33) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# Invalid EOF Initcode containing RJUMPV with target outside of code bounds" >> $field1
    echo "$SP6# - Jump into header" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpv_oob2"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPV(-43) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to before code begin" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpv_oob3"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPV(2) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump into data section" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpv_oob4"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPV(25) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to after code end" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpv_oob5"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPV(23) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to code end" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2

    label="invalid_eof_initcode_rjumpv_to_self_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPV(-1) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# Invalid EOF Initcode containing RJUMPV with target PUSH/RJUMP/RJUMPI/RJUMPV immediate " >> $field1
    echo "$SP6# - Jump to same RJUMPV immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpv_to_rjump_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(1) STOP PUSH1(1) RJUMPV(-8) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to RJUMP immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpv_to_rjumpi_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPV(-19) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to RJUMPI immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpv_to_push_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPV(-5) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to PUSH immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2

    label="invalid_eof_initcode_rjumpv_to_other_rjumpv_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPV(4) PUSH1(255) RJUMPV(0) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to another RJUMPV immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_truncated_rjumpi"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN STOP"
    asm_wrong="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMPI("
    evm=$(mnem2evm "$asm")
    evm_wrong="${evm::-2}5d" # Replaces STOP by RJUMPI
    eof_init=$(eof_gen c:$evm_wrong d:$empty_eof | tail -n1)
    echo "$SP6# Invalid EOF Initcode containing containing truncated RJUMPI" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
    echo "$SP6# Initcode: $asm_wrong" >> $field1
    echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1
    echo "$SP6- indexes:" >> $field2
    echo "$SP6   data: ':label $label'" >> $field2
    echo "$SP6  network:" >> $field2
    echo "$SP6    - 'Shanghai'" >> $field2
    echo "$SP6  result:" >> $field2
    echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 1" >> $field2
    echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_truncated_rjumpi2"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN STOP"
    asm_wrong="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMPI(0?"
    evm=$(mnem2evm "$asm")
    evm_wrong="${evm::-2}5d00"
    eof_init=$(eof_gen c:$evm_wrong d:$empty_eof | tail -n1)
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
    echo "$SP6# Initcode: $asm_wrong" >> $field1
    echo "$SP6- ':label $label :raw 0x$eof_init'" >> $field1
    echo "$SP6- indexes:" >> $field2
    echo "$SP6   data: ':label $label'" >> $field2
    echo "$SP6  network:" >> $field2
    echo "$SP6    - 'Shanghai'" >> $field2
    echo "$SP6  result:" >> $field2
    echo "$SP6   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 1" >> $field2
    echo "$SP6   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $field2
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpi_oob"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(0) RJUMPI(-32) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# Invalid EOF Initcode containing RJUMPI with target outside of code bounds" >> $field1
    echo "$SP6# - Jump into header" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpi_oob2"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPI(-42) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to before code begin" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpi_oob3"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPI(2) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump into data section" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpi_oob4"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPI(25) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to after code end" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpi_oob5"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPI(23) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to code end" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpi_to_self_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPI(-1) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# Invalid EOF Initcode containing RJUMPI with target PUSH/RJUMP/RJUMPI/RJUMPV immediate " >> $field1
    echo "$SP6# - Jump to same RJUMPI immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpi_to_rjump_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN RJUMP(1) STOP PUSH1(1) RJUMPI(-7) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to RJUMP immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpi_to_other_rjumpi_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPI(-18) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to another RJUMPI immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2


    label="invalid_eof_initcode_rjumpi_to_push_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPI(-4) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to PUSH immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2

    label="invalid_eof_initcode_rjumpi_to_rjumpv_immediate"
    asm="PUSH1(0) RJUMPI(12) PUSH1(20) PUSH1(40) PUSH1(0) CODECOPY PUSH1(20) PUSH1(0) RETURN PUSH1(1) RJUMPI(4) PUSH1(255) RJUMPV(0) STOP"
    evm=$(mnem2evm "$asm")
    eof_init=$(eof_gen c:$evm d:$empty_eof | tail -n1)
    echo "$SP6# - Jump to another RJUMPV immediate" >> $field1
    echo "$SP6# Code to be deployed: $empty_eof (contained in initcode's data)" >> $field1
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
    echo "$SP6      nonce: 0" >> $field2
    echo "$SP6      storage:" >> $field2
    echo "$SP6        '0': '0'" >> $field2
    echo "$SP6        '1': '1'" >> $field2

fi

comment_start="Valid EOF"
yul_type="yul-eof"
if [[ "$legacy" -eq 1 ]]; then
  comment_start="Legacy"
  yul_type="yul"
fi

label="valid_init_invalid_code_truncated_rjump_a"
asm="RJUMP(0)"
evm=$(mnem2evm $asm)
wrong_evm=${evm::-4}
wrong_eof=$(eof_gen c:$wrong_evm | tail -n1)
wrong_asm="RJUMP("
echo "$SP6# $comment_start initcode trying to deploy invalid EOF code containing truncated RJUMP" >> $field1
echo "$SP6# Code to be deployed: $wrong_asm - 0x$wrong_eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_truncated_rjump_b"
asm="RJUMP(0)"
evm=$(mnem2evm $asm)
wrong_evm=${evm::-2}
wrong_eof=$(eof_gen c:$wrong_evm | tail -n1)
wrong_asm="RJUMP(0"
echo "$SP6# Code to be deployed: $wrong_asm - 0x$wrong_eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjump_into_header"
asm="RJUMP(-5)"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "" >> $field1
echo "$SP6# $comment_start initcode trying to deploy invalid EOF code containing RJUMP with target outside of code bounds" >> $field1
echo "$SP6# - Jump into header" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjump_to_before_code_begin"
asm="RJUMP(-23)"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# - Jump before code begin" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjump_into_data_section"
asm="RJUMP(2)"
data="aabbccdd"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm d:$data | tail -n1)

echo "$SP6# - Jump into data section" >> $field1
echo "$SP6# Code to be deployed: $asm - Data: $data - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjump_to_after_code_end"
asm="RJUMP(2)"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# - Jump after code end" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjump_to_code_end"
asm="RJUMP(1) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# - Jump to code end" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2

label="valid_init_invalid_code_rjump_to_self_immediate"
asm="RJUMP(-1)"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "" >> $field1
echo "$SP6# $comment_start initcode trying to deploy invalid EOF code containing RJUMP with target PUSH/RJUMP/RJUMPI/RJUMPV/CALLF immediate" >> $field1
echo "$SP6# - Jump to same RJUMP Immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjump_to_rjump_immediate"
asm="RJUMP(3) STOP RJUMP(-4)"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# - Jump to another RJUMP immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1



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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjump_to_rjumpi_immediate"
asm="RJUMP(5) STOP PUSH1(1) RJUMPI(-6) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000001"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type
echo "$SP6# - Jump to RJUMPI immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjump_to_push_immediate"
asm="RJUMP(2) NOP PUSH1(1) PUSH1(1) SSTORE STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000002"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type
echo "$SP6# - Jump to PUSH immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2

label="valid_init_invalid_code_rjump_to_rjumpv_immediate"
asm="RJUMP(5) STOP PUSH1(1) RJUMPV(0) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000001"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type
echo "$SP6# - Jump to RJUMPV immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2

label="valid_init_invalid_code_rjump_to_callf_immediate"
asm1="RJUMP(2) CALLF(1) STOP"
evm1=$(mnem2evm "$asm1")
asm2="PUSH1(1) PUSH1(1) SSTORE RETF"
evm2=$(mnem2evm "$asm2")
eof=$(eof_gen c:$evm c:$evm2 | tail -n1)
correct_type1="00000002"
eof=$(eof_dasm "$eof" ~ts 1 $correct_type1) # Fix type

echo "$SP6# - Jump to CALLF immediate" >> $field1
echo "$SP6# Code to be deployed: 0x$eof" >> $field1
echo "$SP6#   Code[0]: $asm1" >> $field1
echo "$SP6#   Code[1]: $asm2" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_truncated_rjumpi_a"
asm="PUSH1(0) RJUMPI(0)"
evm=$(mnem2evm "$asm")
wrong_evm=${evm::-4}
wrong_eof=$(eof_gen c:$wrong_evm | tail -n1)
wrong_asm=${asm::-2}
echo "" >> $field1
echo "$SP6# $comment_start initcode trying to deploy invalid EOF code containing truncated RJUMPI" >> $field1
echo "$SP6# Code to be deployed: $wrong_asm - 0x$wrong_eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_truncated_rjumpi_b"
asm="PUSH1(0) RJUMPI(0)"
evm=$(mnem2evm "$asm")
wrong_evm=${evm::-2}
wrong_eof=$(eof_gen c:$wrong_evm | tail -n1)
wrong_asm="${asm::-1}?"
echo "$SP6# Code to be deployed: $wrong_asm - 0x$wrong_eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpi_into_header"
asm="PUSH1(1) RJUMPI(-7) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# $comment_start initcode trying to deploy invalid EOF code containing RJUMPI with target outside of code bounds" >> $field1
echo "$SP6# - Jump into header" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpi_to_before_code_begin"
asm="PUSH1(1) RJUMPI(-25) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# - Jump to before code begin" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpi_into_data_section"
asm="PUSH1(1) RJUMPI(2) STOP"
data="aabbccdd"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm d:$data | tail -n1)

echo "$SP6# - Jump into data section" >> $field1
echo "$SP6# Code to be deployed: $asm - Data $data - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpi_to_after_code_end"
asm="PUSH1(1) RJUMPI(2) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# - Jump to after code end" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpi_to_code_end"
asm="PUSH1(1) RJUMPI(1) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# - Jump to code end" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpi_to_self_immediate"
asm="PUSH1(1) RJUMPI(-1) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000001"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type

echo "$SP6# $comment_start initcode trying to deploy invalid EOF code containing RJUMPI with target PUSH/RJUMP/RJUMPI/RJUMPV/CALLF immediate" >> $field1
echo "$SP6# - Jump to same RJUMPI immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpi_to_rjumpi_immediate"
asm="PUSH1(1) RJUMPI(5) STOP PUSH1(1) RJUMPI(-11) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000001"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type
echo "$SP6# - Jump to another RJUMPI immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpi_to_rjump_immediate"
asm="PUSH1(1) RJUMPI(3) STOP RJUMP(-9)"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000001"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type

echo "$SP6# - Jump to RJUMP Immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpi_to_push_immediate"
asm="PUSH1(1) RJUMPI(-4) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000001"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type

echo "$SP6# - Jump to PUSH Immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2

label="valid_init_invalid_code_rjumpi_to_rjumpv_immediate"
asm="PUSH1(1) RJUMPI(5) STOP PUSH1(1) RJUMPV(0) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000001"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type

echo "$SP6# - Jump to RJUMPV immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2

label="valid_init_invalid_code_rjumpi_to_callf_immediate"
asm1="PUSH1(1) RJUMPI(2) CALLF(1) STOP"
evm1=$(mnem2evm "$asm1")
asm2="PUSH1(1) PUSH1(1) SSTORE RETF"
evm2=$(mnem2evm "$asm2")
eof=$(eof_gen c:$evm c:$evm2 | tail -n1)
correct_type0="00000001"
correct_type1="00000002"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type0) # Fix type 0
eof=$(eof_dasm "$eof" ~ts 1 $correct_type1) # Fix type 1

echo "$SP6# - Jump to CALLF immediate" >> $field1
echo "$SP6# Code to be deployed: 0x$eof" >> $field1
echo "$SP6#   Code[0]: $asm1" >> $field1
echo "$SP6#   Code[1]: $asm2" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2

label="valid_init_invalid_code_rjumpv_count0_zero_immediates"
asm="PUSH1(1) RJUMPV(0)"
evm=$(mnem2evm "$asm")
wrong_evm="${evm::-8}5e00"
wrong_eof=$(eof_gen c:$wrong_evm | tail -n1)
correct_type="00000001"
wrong_eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type
wrong_asm="PUSH1(1) RJUMPI("
echo "$SP6# $comment_start Initcode trying to deploy invalid EOF code containing RJUMPV with count 0, and zero immediates" >> $field1
echo "$SP6# Code to be deployed: $wrong_asm - 0x$wrong_eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2

label="valid_init_invalid_code_rjumpv_count0_one_immediate"
asm="PUSH1(1) RJUMPV(0)"
evm=$(mnem2evm "$asm")
wrong_evm="${evm::-8}5e000000"
wrong_eof=$(eof_gen c:$wrong_evm | tail -n1)
correct_type="00000001"
wrong_eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type
wrong_asm="PUSH1(1) RJUMPI("
echo "$SP6# $comment_start Initcode trying to deploy invalid EOF code containing RJUMPV with count 0, and one immediate" >> $field1
echo "$SP6# Code to be deployed: $wrong_asm - 0x$wrong_eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2

label="valid_init_invalid_code_truncated_rjumpv_a"
asm="PUSH1(1) RJUMPV(0)"
evm=$(mnem2evm "$asm")
wrong_evm=${evm::-4}
wrong_eof=$(eof_gen c:$wrong_evm | tail -n1)
wrong_asm="PUSH1(1) RJUMPI("
echo "$SP6# $comment_start Initcode trying to deploy invalid EOF code containing truncated RJUMPV" >> $field1
echo "$SP6# Code to be deployed: $wrong_asm - 0x$wrong_eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_truncated_rjumpv_b"
asm="PUSH1(1) RJUMPV(0)"
evm=$(mnem2evm "$asm")
wrong_evm=${evm::-2}
wrong_eof=$(eof_gen c:$wrong_evm | tail -n1)
wrong_asm="RJUMPI(0?"
echo "$SP6# Code to be deployed: $wrong_asm - 0x$wrong_eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$wrong_eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpv_into_header"
asm="PUSH1(1) RJUMPV(-7) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# $comment_start Initcode trying to deploy invalid EOF code containing RJUMPV with target outside of code bounds" >> $field1
echo "$SP6# - Jump into header" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpv_to_before_code_begin"
asm="PUSH1(1) RJUMPV(-15) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# - Jump to before code begin" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpv_into_data_section"
asm="PUSH1(1) RJUMPV(2) STOP"
data="aabbccdd"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm d:$data | tail -n1)
echo "$SP6# - Jump into data section" >> $field1
echo "$SP6# Code to be deployed: $asm - Data: $data - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpv_to_after_code_end"
asm="PUSH1(1) RJUMPV(2) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# - Jump to after code end" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpv_to_code_end"
asm="PUSH1(1) RJUMPV(1) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
echo "$SP6# - Jump to code end" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2

label="valid_init_invalid_code_rjumpv_to_self_immediate"
asm="PUSH1(1) RJUMPV(-1) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000001"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type
echo "$SP6# $comment_start Initcode trying to deploy invalid EOF code containing RJUMPV with target PUSH/RJUMP/RJUMPI/RJUMPV's immediate" >> $field1
echo "$SP6# - Jump to same RJUMPV Immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpv_to_rjumpi_immediate"
asm="PUSH1(1) RJUMPV(5) STOP PUSH1(1) RJUMPI(-9) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000001"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type
echo "$SP6# - Jump to RJUMPI immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2

label="valid_init_invalid_code_rjumpv_to_rjump_immediate"
asm="PUSH1(1) RJUMPV(5) STOP PUSH1(1) RJUMP(-9) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000001"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type
echo "$SP6# - Jump to RJUMP immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - $eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpv_to_push_immediate"
asm="PUSH1(1) RJUMPV(2) STOP PUSH1(1) PUSH1(1) SSTORE STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000002"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type
echo "$SP6# - Jump to PUSH immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2


label="valid_init_invalid_code_rjumpv_to_other_rjumpv_immediate"
asm="PUSH1(1) RJUMPV(5) STOP PUSH1(1) RJUMPV(0) STOP"
evm=$(mnem2evm "$asm")
eof=$(eof_gen c:$evm | tail -n1)
correct_type="00000001"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type) # Fix type
echo "$SP6# - Jump to other RJUMPV immediate" >> $field1
echo "$SP6# Code to be deployed: $asm - 0x$eof" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2

label="valid_init_invalid_code_rjumpv_to_callf_immediate"
asm1="PUSH1(0) RJUMPV(2) CALLF(1) STOP"
evm1=$(mnem2evm "$asm1")
asm2="PUSH1(1) PUSH1(1) SSTORE RETF"
evm2=$(mnem2evm "$asm2")
eof=$(eof_gen c:$evm c:$evm2 | tail -n1)
correct_type0="00000001"
correct_type1="00000002"
eof=$(eof_dasm "$eof" ~ts 0 $correct_type0) # Fix type 0
eof=$(eof_dasm "$eof" ~ts 0 $correct_type1) # Fix type 1
echo "$SP6# - Jump to CALLF immediate" >> $field1
echo "$SP6# Code to be deployed: 0x$eof" >> $field1
echo "$SP6#   Code[0]: $asm1" >> $field1
echo "$SP6#   Code[1]: $asm2" >> $field1
echo "$SP6- ':label $label :$yul_type object \"c\" { code { datacopy(0, dataoffset(\"r\"), datasize(\"r\")) return(0, datasize(\"r\")) } data \"r\" hex\"$eof\" }'" >> $field1

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
echo "$SP6        '0': '0'" >> $field2
echo "$SP6        '1': '1'" >> $field2



#eof_init=$(returneofdata "$eof" | tail -n1) ; t8n-runner --t8ntool /bin/evm --hard-fork Shanghai --data 0x$eof_init  --gas 0xffffff && cat ~/t8n-repl/alloc.json ; sleep 3

