#!/bin/bash
TESTS_PATH="/home/hugo/workspace/tests/"
TESTS_SUITE="EIPTests/stEOF/stEIP3670"

SP4="    "
SP5="     "
SP6="      "
SP=$SP5

VALID_OPCODES=("00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "0a" "0b" "10" 
               "11" "12" "13" "14" "15" "16" "17" "18" "19" "1a" "1b" "1c" "1d" 
               "20" "30" "31" "32" "33" "34" "35" "36" "37" "38" "39" "3a" "3b" 
               "3c" "3d" "3e" "3f" "40" "41" "42" "43" "44" "45" "46" "47" "48" 
               "50" "51" "53" "54" "55" "59" "5a" "5b" "5f" "60" "61" "62" "63" "64" 
               "65" "66" "67" "68" "69" "6a" "6b" "6c" "6d" "6e" "6f" "70" "71"
               "72" "73" "74" "75" "76" "77" "78" "79" "7a" "7b" "7c" "7d" "7e" 
               "7f" "80" "81" "82" "83" "84" "85" "86" "87" "88" "89" "8a" "8b" 
               "8c" "8d" "8e" "8f" "90" "91" "92" "93" "94" "95" "96" "97" "98" 
               "99" "9a" "9b" "9c" "9d" "9e" "9f" "a0" "a1" "a2" "a3" "a4" "f0" 
               "f1" "f3" "f4" "f5" "fa" "fd" "fe" )

INVALID_OPCODES=( "0c" "0d" "0e" "0f" "1e" "1f" "21" "22" "23" "24" "25" "26"
                  "27" "28" "29" "2a" "2b" "2c" "2d" "2e" "2f" "49" "4a" "4b"
                  "4c" "4d" "4e" "4f" "56" "57" "5e" "a5" "a6" "a7" "a8"
                  "a9" "aa" "ab" "ac" "ad" "ae" "af" "b2" "b3" "b4" "b5" "b6"
                  "b7" "b8" "b9" "ba" "bb" "bc" "bd" "be" "bf" "c0" "c1" "c2"
                  "c3" "c4" "c5" "c6" "c7" "c8" "c9" "ca" "cb" "cc" "cd" "ce"
                  "cf" "d0" "d1" "d2" "d3" "d4" "d5" "d6" "d7" "d8" "d9" "da"
                  "db" "dc" "dd" "de" "df" "e0" "e1" "e2" "e3" "e4" "e5" "e6"
                  "e7" "e8" "e9" "ea" "eb" "ec" "ed" "ee" "ef" "f2" "f6" "f7"
                  "f8" "f9" "fb" "fc" "ff" )

function init_variables() {
  clean=0
  if [ "$1" == "clean" ]; then
    clean=1
  fi

  FPATH=$HOME/$FNAME

  f1="$FPATH.tmp1"
  f2="$FPATH.tmp2"
  f3="$FPATH.tmp3"
  rm $FPATH $f1 $f2 $f3 2> /dev/null
}

function update_filler() {
  echo "update_filler"
  inc_a=0
  inc_b=1

  if [[ "$clean" -eq 1 ]]; then
    inc_a=1
    inc_b=0
  fi  

  if [ "$1" == "valid_invalid" ]; then
    FILLER_PATH="$TESTS_PATH/src/$TESTS_SUITE_VI/$FNAME"
  else
    FILLER_PATH="$TESTS_PATH/src/GeneralStateTestsFiller/$TESTS_SUITE/$FNAME"
  fi

  cat $FILLER_PATH > $FPATH.bck

  flines=$(wc -l $FILLER_PATH | cut -d " " -f1)
  prev=0
  i=1
  while true; do
    f_start=$(cat $FILLER_PATH | grep -n ">@f$i" | cut -d ":" -f1)
    f_end=$(cat $FILLER_PATH | grep -n "<@f$i" | cut -d ":" -f1)

    echo "f$i [$f_start : $f_end]"

    if [[ -z "$f_start" || -z "$f_end" ]]; then
      echo "Stopped looking for f$i"
      cat $FILLER_PATH | tail -n$(( $flines - $prev + $inc_b )) >> $FPATH
      break
    fi

    cat $FILLER_PATH | head -n$(( $f_start - $inc_a )) | tail -n$(( $f_start - $prev - $inc_a + 1 )) >> $FPATH
    prev=$f_end
    fn="f$i"
    cat ${!fn} >> $FPATH

    if [ "$i" -eq 10 ] ; then
      break
    fi
    i=$(( $i + 1 ))
  done

  cat $FPATH > $FILLER_PATH
  echo $FILLER_PATH done
}
