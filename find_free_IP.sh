#!/bin/bash

if [[ -z $1 ]]; then
        VAR_subnet_id=$(./get_subnet_id.sh "ethernet_lab")
        else
        VAR_subnet_id=$(./get_subnet_id.sh $1)
fi

if [[ $VAR_subnet_id == "" ]]; then
	echo "error:subnet_not_found"
fi

VAR_result=$(curl --silent -k -X GET -H 'X-IPM-Username: aXBtYWRtaW4=' -H 'X-IPM-password: YWRtaW4=' "https://192.168.254.100/rpc/ip_find_free_address?subnet_id=$VAR_subnet_id" | ./jq '.' | grep -e "hostaddr" | tail -1 | sed 's/"hostaddr": "\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\)",/\1/g')

if [[ -z $VAR_result ]]; then
	echo "error_no_free_ip"
	else
	echo $VAR_result
fi
