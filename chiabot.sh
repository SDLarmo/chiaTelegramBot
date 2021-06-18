#!/bin/bash

CHAT_ID=""
TOKEN=""
LOG_PATH=~/.chia/mainnet/log/debug.log
LOG_LEVEL="INFO"

while (true)
do
	NEW_LINE=$(grep -w '[0-9] plots were eligible for farming' $LOG_PATH | tail -1)
	if [ "$OLD_LINE" != "$NEW_LINE" ]; then
		WAIT_TIME=0
		OLD_LINE=$NEW_LINE
		GOOD_PLOTS=$(grep -Eo '[0-9]{1,3}' <<< $(grep -o '[0-9]* plots were' <<< $NEW_LINE))
		TOTAL_PLOTS=$(grep -Eo '[0-9]{1,3}' <<< $(grep -o 'Total [0-9]* plots' <<< $NEW_LINE))
		TIME=$(grep -Eo '[0-9]{1,3}\.[0-9]{1,5} s.' <<< $NEW_LINE)
		RESPONSE_SECONDS=$(grep -Eo '[0-9]{1,3}' <<< $TIME | head -1)
		PROOFS=$(grep -Eo '[0-9]{1}' <<< $(grep -o '[0-9]* proof' <<< $NEW_LINE))
		if (( $PROOFS > 0 )); then
			RESULT="! YOU WON !"
		else
			if (($RESPONSE_SECONDS > 4)); then
				RESULT="0 proofs. WARNING: Your farm is too slow."
			else
				RESULT="0 proofs."
			fi
		fi

		TEXT="$GOOD_PLOTS/$TOTAL_PLOTS farmed in $TIME $RESULT"

		if [ "$LOG_LEVEL" = "INFO" ] || [ "$PROOFS" = "1" ]; then
			curl -s --data "text=$TEXT" --data "chat_id=$CHAT_ID" 'https://api.telegram.org/bot'$TOKEN'/sendMessage'
		fi
	fi

	sleep 3

	WAIT_TIME=$(($WAIT_TIME+3))
	if (( $WAIT_TIME > 300 )); then
		WARNING="WARNING! No response in $WAIT_TIME sec."
		curl -s --data "text=$WARNING" --data "chat_id=$CHAT_ID" 'https://api.telegram.org/bot'$TOKEN'/sendMessage'
	fi
done
