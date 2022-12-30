FNAME="CREATE2_EOF1Invalid_FromEOF.yml"
FPATH=$HOME/$FNAME

SP="     "
f0="$FPATH.tmp0"
f1="$FPATH.tmp1"
f2="$FPATH.tmp2"
f3="$FPATH.tmp3"
f4="$FPATH.tmp4"

echo "$SP# Valid legacy initcode returning invalid EOF code - Truncated PUSH data at the end" > $f1
echo "$SP# Valid legacy initcode returning invalid EOF code - Containing undefined instruction (0xf6) after STOP" > $f2
echo "$SP# Valid EOF initcode returning invalid EOF code - Truncated PUSH data at the end" > $f3
echo "$SP# Valid EOF initcode returning invalid EOF code - Containing undefined instruction (0xf6 after STOP" > $f4

contract_yul="{ calldatacopy(0, 0, calldatasize()) sstore(0, create2(0, 0, calldatasize(), 0)) sstore(1, 1) }"
contract_evm=$(yul_comp "$contract_yul")
contract_eof=$(eof_gen c:$contract_evm | tail -n1)

echo "$SP # code: ':yul $contract_yul'"   > $f0
echo "${SP} code: ':raw 0x$contract_eof'" >> $f0

yul_start="sstore(1, 1) sstore(2, 2)"

for i in {1..32}; do
  valid_yul="{ $yul_start }"
  invalid_yul1="{ $yul_start push$i("

  cparameters=$(python -c "print('ff' * $i)")
  valid_push="PUSH1(1)"
  if [ "$i" -ne 1 ]; then
    valid_push="PUSH$i(0x$cparameters)" 
  fi
  valid_push_evm=$(mnem2evm "$valid_push")

  valid_evm="$(yul_comp "$valid_yul")$valid_push_evm"
  invalid_evm1=$(python -c "print('$valid_evm'[:-($i*2)])")
  invalid_evm2=$(python -c "print('$valid_evm'[:-2])")

  invalid_eof1=$(eof_gen c:$invalid_evm1 | tail -n1)
  invalid_eof2=$(eof_gen c:$invalid_evm2 | tail -n1)

  wparameters=$(python -c "print('ff' * ($i-1))")
  invalid_yul2="{ $yul_start push$i(0x$wparameters"

  yul_initcode1=$(yulreturn "$invalid_eof1")
  yul_initcode_evm1=$(yul_comp "$yul_initcode1")
  yul_initcode_eof1=$(eof_gen c:$yul_initcode_evm1 | tail -n1)

  yul_initcode2=$(yulreturn "$invalid_eof2")
  yul_initcode_evm2=$(yul_comp "$yul_initcode2")
  yul_initcode_eof2=$(eof_gen c:$yul_initcode_evm2 | tail -n1)

  echo "$SP# EOF Code: $invalid_yul1 - $invalid_eof1"  >> $f1
  echo "$SP- ':yul $yul_initcode1'"                    >> $f1
  echo "$SP# EOF Code: $invalid_yul2 - $invalid_eof2"  >> $f1
  echo "$SP- ':yul $yul_initcode2'"                    >> $f1

  echo "$SP# Init code: $yul_initcode1" >> $f3
  echo "$SP# Returns EOF code: $invalid_yul1" >> $f3
  echo "$SP- ':raw 0x$yul_initcode_eof1'" >> $f3
  echo "$SP# Init code: $yul_initcode2" >> $f3
  echo "$SP# Returns EOF code: $invalid_yul2" >> $f3
  echo "$SP- ':raw 0x$yul_initcode_eof2'" >> $f3

done

valid_yul="{ $yul_start stop() }"
invalid_yul="{ $yul_start stop() 0xf6 }"
invalid_evm="$(yul_comp "$valid_yul")f6" # Compile valid yul and adds 0xf6 at the end
invalid_eof=$(eof_gen c:$invalid_evm | tail -n1)
yul_initcode=$(yulreturn $invalid_eof)
eof_initcode=$(eof_gen c:$(yul_comp "$yul_initcode") | tail -n1)

echo "$SP# Returns EOF code: $invalid_yul - $invalid_eof" >> $f2
echo "$SP- ':yul $yul_initcode'" >> $f2

echo "$SP# Init code: $yul_initcode" >> $f4
echo "$SP# Code: $invalid_yul" >> $f4
echo "$SP- ':raw 0x$eof_initcode'" >> $f4


cat $f0 > $FPATH

echo "" >> $FPATH
cat $f1 >> $FPATH

echo "" >> $FPATH
cat $f2 >> $FPATH

echo "" >> $FPATH
cat $f3 >> $FPATH

echo "" >> $FPATH
cat $f4 >> $FPATH


cat $FPATH
