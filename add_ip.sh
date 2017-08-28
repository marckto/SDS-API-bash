#!/bin/bash

#utilization
#add_ip.sh <space> <subnet> <hostname> <IP (optional)>

if [[ -z $1 ]]; then
        VAR_site_name="lab"
        else
        VAR_site_name=$1
fi

if [[ -z $2 ]]; then
	VAR_subnet_name="ethernet_lab"
        else
        VAR_subnet_name=$2
fi


if [[ -z $3 ]]; then
        VAR_name="api_host_example.lab.com"
        else
        VAR_name=$3
fi

if [[ -z $4 ]]; then
        VAR_hostaddr=$(./find_free_IP.sh $VAR_subnet_name)
	if [[ $(echo $VAR_hostaddr | grep error_) != "" ]]; then
		echo $VAR_hostaddr
		exit 1
	fi
        else
        VAR_hostaddr=$4
fi

#echo $VAR_site_name $VAR_name $VAR_hostaddr

VAR_result=$(curl --silent -k -X POST -H 'X-IPM-Username: aXBtYWRtaW4=' -H 'X-IPM-password: YWRtaW4=' "https://192.168.254.100/rest/ip_add?hostaddr=$VAR_hostaddr&site_name=$VAR_site_name&name=$VAR_name")
echo $VAR_result

VAR_ip_id=$(echo $VAR_result | sed 's/\[{"ret_oid":"\([0-9]*\)"}\]/\1/g')
VAR_result_2=$(curl --silent -k -X GET  -H 'X-IPM-Username: aXBtYWRtaW4=' -H 'X-IPM-password: YWRtaW4=' "https://192.168.254.100/rest/ip_address_info?ip_id=$VAR_ip_id" | ./jq '.' | grep '"ip_addr"' | sed 's/"ip_addr": "\([0-9a-Z]*\)",/\1/g')

VAR_ip_full_addr=$(printf '%d.%d.%d.%d\n' `echo $VAR_result_2 | sed -r 's/(..)/0x\1 /g'`)


echo $VAR_ip_full_addr created
