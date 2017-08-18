#!/bin/bash

# log successful RADIUS authentication attempts to radcheck database
# and set account expiry date to one month in the future at login
# configure this script in mods-enabled/exec, e.g. program = "/etc/raddb/expiry.sh"
# then add 'exec' to 'post-auth' section in sites-enabled/default

source <(grep " = " /etc/raddb/mods-enabled/sql| grep -v "^.*#"| sed 's/ \= /\=/g')
my="mysql -u$login -p$password -h$server -D$radius_db"
if [[ -n "$CALLING_STATION_ID" ]]; then
  $my -e "INSERT INTO vpn_log (username,calling_station,vdom,nas_identifier,session_id) VALUES ($USER_NAME,$CALLING_STATION_ID,$FORTINET_VDOM_NAME,$NAS_IDENTIFIER,$ACCT_SESSION_ID);
else
  $my -e "INSERT INTO firewall_log (username,vdom,nas_identifier,session_id) VALUES ($USER_NAME,$FORTINET_VDOM_NAME,$NAS_IDENTIFIER,$ACCT_SESSION_ID);"
fi
$my -e "DELETE FROM radcheck WHERE username = $USER_NAME AND attribute = 'Expiration';"
$my -e "INSERT INTO radcheck (username,attribute,value) VALUES ($USER_NAME,'Expiration','`date -d '+1 month' +'%b %d %Y %H:%M:%S %Z'`');"
