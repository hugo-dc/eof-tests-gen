#!/bin/bash

FNAME="CREATE_EOF1DeployValidOpcodes.yml"
FPATH=$HOME/$FNAME

f1="$FPATH.tmp1"
f2="$FPATH.tmp2"

rm $f1 $f2

SP="     "

valid_opcodes=("00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "0a" "0b" "10" 
               "11" "12" "13" "14" "15" "16" "17" "18" "19" "1a" "1b" "1c" "1d" 
               "20" "30" "31" "32" "33" "34" "35" "36" "37" "38" "39" "3a" "3b" 
               "3c" "3d" "3e" "3f" "40" "41" "42" "43" "44" "45" "46" "47" "48" 
               "50" "51" "53" "54" "55" "59" "5a" "5b" "80" "81" "82" "83" "84" 
               "85" "86" "87" "88" "89" "8a" "8b" "8c" "8d" "8e" "8f" "90" "91" 
               "92" "93" "94" "95" "96" "97" "98" "99" "9a" "9b" "9c" "9d" "9e" 
               "9f" "a0" "a1" "a2" "a3" "a4" "f0" "f1" "f3" "f4" "f5" "fa" "fd" 
               "fe" )
for op in ${valid_opcodes[@]}; do
  stack_req=$(opinfo 0x$op --inputs)
  op_name=$(opinfo 0x$op --name)

  asm_code=""
  if [ "$stack_req" -ge "1" ]; then
    if [ "$stack_req" -eq "1" ]; then
      asm_code="PUSH1(1) $op_name"
    else
      asm_code="PUSH1(1) $(python -c "print('DUP1 ' * ($stack_req - 1))") $op_name"
    fi
  else
    asm_code="$op_name"
  fi

  evm=$(mnem2evm "$asm_code")
  eof=$(eof_gen c:$evm | tail -n1)
  yul_initcode=$(yulreturn $eof)
  evm_initcode=$(yul_comp "$yul_initcode")

  op_name_lower=$(echo $op_name | tr '[:upper:]' '[:lower:]')

  echo "$SP# Deployed EOF Code: $asm_code " >> $f1
  echo "$SP- ':label $op_name_lower :raw 0x$evm_initcode'" >> $f1

  echo "$SP- indexes:" >> $f2
  echo "$SP    data: ':label $op_name_lower'" >> $f2
  echo "$SP  network:" >> $f2
  echo "$SP    - 'Shanghai'" >> $f2
  echo "$SP  result:" >> $f2
  echo "$SP   a94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $f2 
  echo "$SP      nonce: 1" >> $f2
  echo "$SP   b94f5374fce5edbc8e2a8697c15331677e6ebf0b:" >> $f2
  echo "$SP      nonce: 1" >> $f2
  echo "$SP      storage:" >> $f2
  echo "$SP        1: 1" >> $f2
  echo "$SP   f1ecf98489fa9ed60a664fc4998db699cfa39d40:" >> $f2
  echo "$SP      nonce: 1" >> $f2
  echo "$SP      storage: {}" >> $f2
  echo "$SP      code: '0x$eof'" >> $f2
done

cat $f1 > $FPATH
cat $f2 >> $FPATH

cat $FPATH
