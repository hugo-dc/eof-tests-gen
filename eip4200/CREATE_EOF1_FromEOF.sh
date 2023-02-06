#!/bin/bash

source ../common.sh
source ../common_4200.sh

FNAME="CREATE_EOF1_FromEOFFiller.yml"

init_variables $1

field1=$f1
field2=$f2
create_address="b94f5374fce5edbc8e2a8697c15331677e6ebf0b"
create_type=1

source ./valid_create.sh

update_filler
