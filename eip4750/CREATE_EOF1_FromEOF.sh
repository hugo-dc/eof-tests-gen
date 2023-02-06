#!/bin/bash

source ../common.sh
source ../common_4750.sh

FNAME="CREATE_EOF1_FromEOFFiller.yml"

init_variables

yul="{ calldatacopy(0, 0, calldatasize()) sstore(0, create(0, 0, calldatasize())) sstore(1, 1) stop() }"
evm=$(yul_comp "$yul")
eof=$(eof_gen c:$evm | tail -n1)

echo "$SP6# code: \":yul $yul\"" > $f1
echo "${SP6}code: ':raw 0x$eof'" >> $f1

create_type=1
field1=$f2
field2=$f3
source ./valid_create.sh

update_filler


