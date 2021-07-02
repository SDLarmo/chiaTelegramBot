#!/bin/bash

CHAT_ID=""
TOKEN=""
LOG_PATH=~/.chia/mainnet/log/debug.log
MODE="SUMMARY"
MSG_INTERVAL="300"

MAX_RESPONSE_TIME=0

while (true)
do
	NEW_LINE=$(grep -w --text '[0-9] plots were eligible for farming' $LOG_PATH | tail -1)
	if [ "$OLD_LINE" != "$NEW_LINE" ] && [ "$NEW_LINE" != "" ]; then
		WAIT_TIME=0
		OLD_LINE=$NEW_LINE
		GOOD_PLOTS=$(grep -Eo '[0-9]{1,3}' <<< $(grep -o '[0-9]* plots were' <<< $NEW_LINE))
		TOTAL_PLOTS=$(grep -Eo '[0-9]{1,5}' <<< $(grep -o 'Total [0-9]* plots' <<< $NEW_LINE))
		TIME=$(grep -Eo '[0-9]{1,3}\.[0-9]{1,5} s.' <<< $NEW_LINE)
		RESPONSE_SECONDS=$(grep -Eo '[0-9]{1,3}' <<< $TIME | head -1)
		RESPONSE_MS_STRING=$(grep -Eo '[0-9]{1,5}' <<< $TIME | tail -1)
		RESPONSE_MS_NUMBER=$(($(expr $RESPONSE_MS_STRING + 0)/100))
		if [ "$RESPONSE_SECONDS" == "" ] || [ "$RESPONSE_MS_STRING" == "" ]; then
		  echo "ERROR IN PARSING LINE: $NEW_LINE"
		  exit 1
		fi
		RESPONSE_MS_WHOLE=$(($RESPONSE_SECONDS*1000+$RESPONSE_MS_NUMBER))
		PROOFS=$(grep -Eo '[0-9]{1}' <<< $(grep -o '[0-9]* proof' <<< $NEW_LINE))
		if [ "$MODE" = "INFO" ] || [ "$MODE" = "IMPORTANT" ]; then
      if (( $PROOFS > 0 )); then
        RESULT="! YOU WON !"
      else
        if (($RESPONSE_MS_WHOLE > 5000)); then
          RESULT="0 proofs. WARNING: Your farm is too slow."
        else
          RESULT="0 proofs."
        fi
      fi

      TEXT="$GOOD_PLOTS/$TOTAL_PLOTS farmed in $RESPONSE_MS_WHOLE ms. $RESULT"

      if [ "$MODE" = "INFO" ] || [ "$PROOFS" = "1" ]; then
        curl -s --data "text=$TEXT" --data "chat_id=$CHAT_ID" 'https://api.telegram.org/bot'$TOKEN'/sendMessage'
      fi
    else
      TOTAL_BLOCKS=$(($TOTAL_BLOCKS+1))
      TOTAL_PLOTS_PASSED=$(($TOTAL_PLOTS_PASSED+$GOOD_PLOTS))
      TOTAL_PLOTS_NUMBER=$((TOTAL_PLOTS_NUMBER+$TOTAL_PLOTS))
      TOTAL_PROOFS=$(($TOTAL_PROOFS+$PROOFS))
      TOTAL_RESPONSE_TIME=$(($TOTAL_RESPONSE_TIME+$RESPONSE_MS_WHOLE))
      if (( $RESPONSE_MS_WHOLE >= $MAX_RESPONSE_TIME )); then
       	MAX_RESPONSE_TIME=$RESPONSE_MS_WHOLE
      fi
    fi
	fi

	sleep 3

  CYCLE_TIME=$((CYCLE_TIME+3))
	WAIT_TIME=$(($WAIT_TIME+3))

	if [ "$MODE" = "SUMMARY" ] && (( $CYCLE_TIME >= MSG_INTERVAL )); then
	  EFFICIENCY=$((512*100*$TOTAL_PLOTS_PASSED/$TOTAL_PLOTS_NUMBER))
	  AVG_RESPONSE_TIME=$(($TOTAL_RESPONSE_TIME/$TOTAL_BLOCKS))
	  if (( $TOTAL_PROOFS > 0 )); then
      RESULT="! YOU WON ! Found $TOTAL_PROOFS proofs."
    else
      RESULT="Found $TOTAL_PROOFS proofs."
    fi
		TEXT="Farm summary in $CYCLE_TIME sec:
		Total blocks farmed: $TOTAL_BLOCKS
		Plots passed the filter: $TOTAL_PLOTS_PASSED times
		Efficiency: $EFFICIENCY%
		Average response time: $AVG_RESPONSE_TIME ms
		Maximum response time: $MAX_RESPONSE_TIME ms
		$RESULT"
		CYCLE_TIME=0
		TOTAL_BLOCKS=0
    TOTAL_PLOTS_PASSED=0
    TOTAL_PLOTS_NUMBER=0
    TOTAL_PROOFS=0
    TOTAL_RESPONSE_TIME=0
    MAX_RESPONSE_TIME=0
		curl -s --data "text=$TEXT" --data "chat_id=$CHAT_ID" 'https://api.telegram.org/bot'$TOKEN'/sendMessage'
	fi

	if (( $WAIT_TIME > 300 )) && (( $WAIT_TIME % 60 == 0 )); then
		WARNING="WARNING! No response in $WAIT_TIME sec."
		curl -s --data "text=$WARNING" --data "chat_id=$CHAT_ID" 'https://api.telegram.org/bot'$TOKEN'/sendMessage'
	fi
done
