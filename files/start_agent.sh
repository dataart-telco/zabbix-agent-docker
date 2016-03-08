#!/bin/bash

CONFIG_FILE='/etc/zabbix/zabbix_agentd.conf'

for i in $( set -o posix ; set | grep ^ZA_ | sort -rn ); do
    reg=$(echo ${i} | cut -d = -f1 | cut -c 4-)
    val=$(echo ${i} | cut -d = -f2)
    FIND_RESULT=`grep ^${reg}= $CONFIG_FILE`
    if [[ -n "$FIND_RESULT" ]]; then
        sed -i "s|^${reg}=.*|${reg}=${val}|g" $CONFIG_FILE 
    else
        echo "# Auto generated: $i"
        echo "${reg}=${val}" >> $CONFIG_FILE
    fi
done

zabbix_agentd -c ${CONFIG_FILE}
