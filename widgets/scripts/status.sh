#!/usr/bin/bash

jabber_unread=0
if [ -f ~/.mcabber/mcabber.state ]; then
  jabber_unread=1
fi

echo $(sh ./scripts/time_script)@$(sh ./scripts/date_script)@$(sh ./scripts/battery_percentage_script)%@$(sh ./scripts/battery_charging_script)@$(sh ./scripts/wifi_status_script)@$(sh ./scripts/getVolumeStat.sh)@$jabber_unread@$(cat ~/.imapstats)
