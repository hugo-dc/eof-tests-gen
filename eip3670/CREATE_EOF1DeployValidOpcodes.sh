#!/bin/bash
source ./common.sh

FNAME="CREATE_EOF1DeployValidOpcodesFiller.yml"
FPATH=$HOME/$FNAME

f1="$FPATH.tmp1"
f2="$FPATH.tmp2"

rm $f1 $f2

for op in ${VALID_OPCODES[@]}; do
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
    is_push=$(opinfo 0x$op --ispush)
    asm_code="$op_name"

    if [ "$is_push" == "true" ]; then
      pushlen=$(opinfo 0x$op --immediates)
      if [ "$pushlen" -eq "1" ]; then
        asm_code="$op_name(1)" 
      else
        asm_code="$op_name(0x"
        asm_code="$asm_code$(python -c "print('ff' * $pushlen)"))"
      fi
    fi
  fi
  is_terminating=$(opinfo 0x$op --is-terminating)
  if [ "$is_terminating" == "false" ]; then
    asm_code="$asm_code STOP"
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

FILLER_PATH="$TESTS_PATH/src/GeneralStateTestsFiller/$TESTS_SUITE/$FNAME"

cat $FILLER_PATH > $FPATH 
cat $FILLER_PATH > $FPATH.bck #backup

f1_start=$(cat $FILLER_PATH | grep -n ">@f1" | cut -d ":" -f1)
f1_end=$(cat $FILLER_PATH | grep -n "<@f1" | cut -d ":" -f1)

f2_start=$(cat $FILLER_PATH | grep -n ">@f2" | cut -d ":" -f1)
f2_end=$(cat $FILLER_PATH | grep -n "<@f2" | cut -d ":" -f1)

flines=$(wc -l $FILLER_PATH | cut -d " " -f1)

cat $FILLER_PATH | head -n$f1_start > $FPATH
cat $f1  >> $FPATH
cat $FILLER_PATH | tail -n$(( $flines - $f1_end + 1 )) | head -n$(( $f2_start - $f1_end + 1 )) >> $FPATH
cat $f2  >> $FPATH
cat $FILLER_PATH | tail -n$(( $flines - $f2_end + 1 )) >> $FPATH

cat $FPATH > $FILLER_PATH
echo $FILLER_PATH done

