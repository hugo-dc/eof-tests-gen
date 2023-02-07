#!/bin/bash

source ../common.sh
source ../common_4750.sh

FNAME="CREATE_EOF1_FromEOFFiller.yml"

init_variables

yul="{ calldatacopy(0, 0, calldatasize()) sstore(0, create(0, 0, calldatasize())) sstore(1, 1) stop() }"

echo "${SP6}code: ':yul-eof $yul'" >> $f1

create_address="b94f5374fce5edbc8e2a8697c15331677e6ebf0b"
create_type=1
field1=$f2
field2=$f3
source ./valid_create.sh

update_filler


