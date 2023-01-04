#!/bin/bash
source ./common.sh

FNAME="CreateTransactionEOF1InvalidOpcodesFiller.yml"
FPATH=$HOME/$FNAME

f1="$FPATH.tmp1"
f2="$FPATH.tmp2"

rm $f1 $f2

echo "$SP# Invalid opcodes, in deployed code" >  $f1
echo "$SP# EOF Code: <invalid_opcode> stop()" >> $f1
echo "$SP# Initcode: { mstore(0, 0xef000101000402000100020300000000000000<invalid_opcode>00) return(11, 21) }" >> $f1 

echo "$SP# Invalid opcodes in initcode" >  $f2
echo "$SP# Initcode:"                   >> $f2
echo "$SP#   {"                         >> $f2
echo "$SP#     <invalid_opcode>"        >> $f2
echo "$SP#     mstore(0, 0xef000101000402000100010300000000000000fe000000000000000000000000)" >> $f2
echo "$SP#     return(0, 20)"           >> $f2
echo "$SP#   }"                         >> $f2
echo "$SP# EOF Code: 0xfe"              >> $f2

for op in ${INVALID_OPCODES[@]}; do
  evm=$op"00"
  eof=$(eof_gen c:$evm | tail -n1)
  yul="{ mstore(0, 0x$eof) return(11, 21) }"
  evminit=$(yul_comp "$yul")
  echo "$SP- 'label inv_$op :raw 0x$evminit'" >> $f1

  valid_yul_init="{ mstore(0, 0xef000101000402000100010300000000000000fe000000000000000000000000) return(0, 20) }"
  valid_evm_init=$(yul_comp "$valid_yul_init")
  invalid_evm_init=$op$valid_evm_init
  invalid_eof_init=$(eof_gen c:$invalid_evm_init | tail -n1)
  echo "$SP- 'label invinit_$op :raw 0x$invalid_eof_init'" >> $f2
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

