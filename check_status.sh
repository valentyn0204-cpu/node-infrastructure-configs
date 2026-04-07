#!/bin/bash
# Node Infrastructure Health Check Script

echo "=== System Status: Dell Inspiron & Sony Server ==="
uptime

echo -e "\n=== Containerized Nodes (Docker Status) ==="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo -e "\n=== Network & Connectivity Analysis (RPC/DNS) ==="
# Анализ логов на наличие специфических ошибок связи
LOG_ERRORS=$(tail -n 50 /var/log/syslog | grep -iE "error|rpc|dns|timeout" | tail -n 5)

if [ -z "$LOG_ERRORS" ]; then
    echo "[OK] No critical network errors detected in recent logs."
else
    echo "[WARNING] Detected communication issues:"
    echo "$LOG_ERRORS"
fi

echo -e "\n=== Resource Usage ==="
free -h | grep -E "Mem|Total"
df -h / | tail -n 1 | awk '{print "Disk Usage: " $5}'

echo -e "\n=== Status Check Complete ==="
