#!/bin/bash

#!/bin/bash

set -x

APP_ID=$1

# 获取${APP_ID}/layer下面的layer文件
layer_file=(${APP_ID}/*.layer)
if [[ -z "$layer_file" ]]; then
  echo "No layer file found in ${APP_ID}/"
  exit -1
fi

sudo ll-cli repo set-default dev || true

sudo ll-cli install "./${layer_file[0]}" || true


export DISPLAY=:0 && ll-cli run "$APP_ID" &

sleep 5

ps_output=$(ll-cli ps | tail -n+2 | awk '{print $1}')

if echo "$ps_output" | grep "$APP_ID" > /dev/null; then
  ll-cli kill -s9 "$APP_ID"
  sudo ll-cli uninstall "$APP_ID"
  sudo ll-cli prune
else
  echo "failed: $APP_ID no running (no match APP_ID)"
  sudo ll-cli uninstall "$APP_ID"
  sudo ll-cli prune
  exit -1
fi
