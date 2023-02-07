#!/bin/bash

source ../common.sh
source ../common_4750.sh

FNAME="CREATE2_EOF1Invalid_FromEOFFiller.yml"

init_variables $1

empty_eof=$(eof_gen c:fe | tail -n1)

source ./invalid_create.sh

update_filler


