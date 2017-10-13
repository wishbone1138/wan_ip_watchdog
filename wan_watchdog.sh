#!/bin/bash

TO_ADDR="youremail@gmail.com"
FROM_ADDR="\"WAN_WATCHDOG\" <from@yourdomain.org>"
SUBJECT="Subject: NETGHETTO WAN IP CHANGED"


CURRENT_IP=`curl -s -m 5 checkip.dyndns.org | sed -e 's/<[^>]*>//g' | awk -F ' ' '{print $6}' | sed -e 's/\r//g'`
echo "cur ip: $CURRENT_IP"

if [ "$CURRENT_IP" == "" ]
then
	echo "curl failed"
else


	PRE_IP=$(</tmp/lastip)

	echo "pre ip: $PRE_IP"

	PRE_HOST=`host $PRE_IP | awk -F ' ' '{print $5}'` 
	CUR_HOST=`host $CURRENT_IP | awk -F ' ' '{print $5}'`


	if [ $PRE_IP != $CURRENT_IP ] 
	then
		echo "IP CHANGED!"
		MSG_BODY="IP CHANGED:"$'\n'"OLD: $PRE_IP $PRE_HOST"$'\n'"NEW: $CURRENT_IP $CUR_HOST"

		echo $MSG_BODY

		MESSAGE="To: $TO_ADDR"$'\n'"From: $FROM_ADDR"$'\n'"$SUBJECT"$'\n\n'"$MSG_BODY"

		echo "SENDING: $MESSAGE"

		ssmtp -vvv "$TO_ADDR" <<< "$MESSAGE"

	
	else
		echo "IP SAME"
	fi

	echo "${CURRENT_IP}" > /tmp/lastip
fi
