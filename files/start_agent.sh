#!/bin/bash

CONFIG_FILE='/etc/zabbix/zabbix_agentd.conf'

if [[ -n "$ZABBIX_SERVER" ]]; then
  echo "Update zabix server to $ZABBIX_SERVER"
  sed -i 's/Server=127.0.0.1/Server='$ZABBIX_SERVER'/g' ${CONFIG_FILE}
fi

zabbix_agentd -c ${CONFIG_FILE}
