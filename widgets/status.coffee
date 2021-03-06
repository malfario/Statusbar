command: "sh ./statusbar.widgets/scripts/status.sh"

refreshFrequency: 10000 # ms

render: (output) ->
  """
    <div class="compstatus"></div>
  """

style: """
  position: absolute
  margin: 0 auto
  padding-left: 10px
  right: 18px
  .wifi
    font: 14px FontAwesome
    top: 1px
    position: relative
    left: 10px
  .charging
    font: 12px FontAwesome
    position: relative
    top: 0px
    right: -11px
    z-index: 1
  """
timeAndDate: (date, time) ->
  # returns a formatted html string with the date and time
  # return "<span class='white'><span class='icon'>&nbsp&nbsp;</span>#{date}&nbsp<span> ⎢ </span><span class='icon'>&nbsp;</span>#{time}</span></span>";
  return "<span class='white'>#{date}&nbsp#{time}</span>";

batteryStatus: (battery, state) ->
  #returns a formatted html string current battery percentage, a representative icon and adds a lighting bolt if the
  # battery is plugged in and charging

  # If no battery exists, battery is only '%' character
  if state == 'AC' and battery == "%"
    return "<span class='green icon'></span>"

  batnum = parseInt(battery)
  if state == 'AC' and batnum >= 90
    return "<span class='charging white sicon'></span><span class='green icon '></span>&nbsp;<span class='white'>#{batnum}%</span>"
  else if state == 'AC' and batnum >= 50 and batnum < 90
    return "<span class='charging white icon'></span><span class='green icon'></span>&nbsp;<span class='white'>#{batnum}%</span>"
  else if state == 'AC' and batnum < 50 and batnum >= 15
    return "<span class='charging white icon'></span><span class='yellow icon'></span>&nbsp;<span class='white'>#{batnum}%</span>"
  else if state == 'AC' and batnum < 15
    return "<span class='charging white icon'></span><span class='red icon'></span>&nbsp;<span class='white'>#{batnum}%</span>"
  else if batnum >= 90
    return "<span class='green icon'>&nbsp</span>&nbsp;<span class='white'>#{batnum}%</span>"
  else if batnum >= 50 and batnum < 90
    return "<span class='green icon'>&nbsp</span>&nbsp;<span class='white'>#{batnum}%</span>"
  else if batnum < 50 and batnum >= 25
    return "<span class='yellow icon'>&nbsp</span>&nbsp;<span class='white'>#{batnum}%</span>"
  else if batnum < 25 and batnum >= 15
    return "<span class='yellow icon'>&nbsp</span>&nbsp;<span class='white'>#{batnum}%</span>"
  else if batnum < 15
    return "<span class='red icon'>&nbsp</span>&nbsp;<span class='white'>#{batnum}%</span>"

getWifiStatus: (status, netName, netIP) ->
  if status == "Wi-Fi"
    return "<span class='wifi '>&nbsp&nbsp&nbsp&nbsp;</span><span class='white'>#{netName}&nbsp</span>"
  if status == 'USB 10/100/1000 LAN' or status == 'Apple USB Ethernet Adapter'
    return "<span class='wifi '>&nbsp&nbsp&nbsp&nbsp;</span><span class='white'>#{netIP}</span>"
  else
    return "<span class='grey wifi'>&nbsp&nbsp&nbsp</span><span class='white'>--&nbsp&nbsp&nbsp</span>"

getVolume: (str) ->
  if str == "muted"
    return "<span class='volume'>&nbsp;&nbsp;</span>"
  else
    return "<span class='volume'>&nbsp;&nbsp;</span><span class='white'>#{str}&nbsp</span>"

getJabberUnread: (unread) ->
  if unread > 0
    clazz = "white fas fa-comment-dots"
  else
    clazz = "white far fa-comment"
  return "<span class='jabber'><span class='#{clazz}'></span></span>"

getMailUnread: (count) ->
  if count > 0
    return "<span class='mail'><span class='white fas fa-envelope'>&nbsp;</span><span class='white'>#{count}</span></span>"
  else
    return "<span class='mail'><span class='white far fa-envelope'></span></span>"

update: (output, domEl) ->
  # split the output of the script
  values = output.split('@')

  time = values[0].replace /^\s+|\s+$/g, ""
  date = values[1]
  battery = values[2]
  isCharging = values[3]
  netStatus = values[4].replace /^\s+|\s+$/g, ""
  netName = values[5]
  netIP = values[6]
  volume = values[7]
  jabberUnread = values[8]
  mailUnread = values[9]

  # create an HTML string to be displayed by the widget
  # htmlString = @getVolume(volume) + "<span>" + " | " + "</span>" +
  #              @getWifiStatus(netStatus, netName, netIP) + "<span>" + " ⎢ " + "</span>" +
  #              @batteryStatus(battery, isCharging) + "<span>" + " ⎢ " + "</span>" +
  #              @timeAndDate(date,time)
  htmlString = @getJabberUnread(jabberUnread) +
               "<span>&nbsp;&nbsp;&nbsp;</span>" +
               @getMailUnread(mailUnread) +
               "<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>" +
               @timeAndDate(date, time)

  $(domEl).find('.compstatus').html(htmlString)
