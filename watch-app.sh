#!/bin/bash
echo "Watching http://localhost:3000 every second... (Ctrl+C to stop)"
echo ""
DOWN_COUNT=0
LAST_STATUS=""

while true; do
  TIME=$(date '+%H:%M:%S')
  RESPONSE=$(curl -s --max-time 1 http://localhost:3000/ 2>/dev/null)

  if [ $? -eq 0 ] && [ -n "$RESPONSE" ]; then
    VERSION=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin).get('message','?'))" 2>/dev/null || echo "up")
    if [ "$LAST_STATUS" = "DOWN" ]; then
      echo -e "\e[32m[$TIME] UP   - $VERSION  (was down ${DOWN_COUNT}s)\e[0m"
      DOWN_COUNT=0
    else
      echo -e "\e[32m[$TIME] UP   - $VERSION\e[0m"
    fi
    LAST_STATUS="UP"
  else
    DOWN_COUNT=$((DOWN_COUNT + 1))
    echo -e "\e[31m[$TIME] DOWN - connection refused (${DOWN_COUNT}s)\e[0m"
    LAST_STATUS="DOWN"
  fi
  sleep 1
done
