#!/bin/bash
 
rm ./tmp/pids/server.pid  # server.pidが消去されずrails sが起動できない場合があるため削除している。
bundle exec rails s -p 3000 -b '0.0.0.0' -e development