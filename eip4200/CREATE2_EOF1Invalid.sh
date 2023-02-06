#!/bin/bash

source ../common.sh
source ../common_4200.sh

FNAME="CREATE2_EOF1InvalidFiller.yml"

init_variables $1

field1=$f1
field2=$f2

legacy=1
source ./invalid_create.sh

update_filler
