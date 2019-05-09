#!/usr/bin/bash

jabber_unread=0
if [ -f ~/.mcabber/mcabber.state ]; then
  jabber_unread=1
fi

echo $(sh ./statusbar.widgets/scripts/time_script)@$(sh ./statusbar.widgets/scripts/date_script)@$(sh ./statusbar.widgets/scripts/battery_percentage_script)%@$(sh ./statusbar.widgets/scripts/battery_charging_script)@$(sh ./statusbar.widgets/scripts/wifi_status_script)@$(sh ./statusbar.widgets/scripts/getVolumeStat.sh)@$jabber_unread@$(echo 'get count\r\n'|nc localhost 6677)
