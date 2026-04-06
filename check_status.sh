#!/bin/bash
echo "Checking node status on Dell Inspiron and Sony Server..."
docker ps --format "table {{.Names}}\t{{.Status}}"
echo "Analyzing logs for RPC/DNS errors..."
tail -n 20 /var/log/syslog | grep -iE "error|rpc|dns"
