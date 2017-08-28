#!/bin/bash

#$1 = subnet name
if [[ -z $1 ]]; then
	VAR_subnet_name="ethernet_lab"
        else
        VAR_subnet_name=$1
fi

#VAR_result=$(curl --silent -k -X GET -H 'X-IPM-Username: aXBtYWRtaW4=' -H 'X-IPM-password: YWRtaW4=' "https://192.168.254.100/rpc/ip_find_free_address?subnet_id=$VAR_subnet_id" | ./jq '.' | grep -e "hostaddr" | tail -1 | sed 's/"hostaddr": "\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\)",/\1/g')


VAR_result=$(curl --silent -k -X GET -H 'X-IPM-Username: aXBtYWRtaW4=' -H 'X-IPM-password: YWRtaW4=' "https://192.168.254.100/rpc/ip_block_subnet_list/WHERE/site_name='lab'%20and%20subnet_name='$VAR_subnet_name'/" | ./jq '.' |grep -e '"subnet_id"'| sed 's/"subnet_id": "\([0-9]*\)",/\1/g' )
echo $VAR_result
