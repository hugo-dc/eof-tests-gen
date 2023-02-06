#!/bin/bash

source ../common.sh
source ../common_4200.sh

FNAME="CREATE2_EOF1_FromEOFFiller.yml"

init_variables $1

create_address="b94f5374fce5edbc8e2a8697c15331677e6ebf0b"
create_type=2

yul="{ calldatacopy(0, 0, calldatasize()) sstore(0, create2(0, 0, calldatasize(), 0)) sstore(1, 1) stop() }"

echo "${SP6}code: \":yul-eof $yul\"" >> $f1

field1=$f2
field2=$f3

source ./valid_create.sh

update_filler

