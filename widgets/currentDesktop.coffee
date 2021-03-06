icons: [
  "fab fa-chrome"
  "fas fa-folder"
  "fas fa-envelope"
  "fas fa-headphones-alt"
  "fas fa-rss"
  "fas fa-code"
  "fas fa-desktop"
  "fas fa-desktop"
  "fas fa-desktop"
  "fas fa-desktop"
]

command: "echo $(x=$(/usr/local/bin/chunkc tiling::query -d id);echo $(/usr/local/bin/chunkc tiling::query -D $(/usr/local/bin/chunkc tiling::query -m id))\",$x\")"

refreshFrequency: 500

render: (output) ->
  values = output.split(',')
  spaces = values[0].split(' ')

  htmlString = """
    <div class="currentDesktop-container" data-count="#{spaces.length}">
      <ul>
  """

  for i in [0..spaces.length - 1]
    htmlString += "<li id=\"desktop#{spaces[i]}\"><span class=\"white fa-sm #{@icons[i]}\"><span/></li>"

  htmlString += """
      <ul>
    </div>
  """

style: """
  position: absolute
  margin-top: 2px
  color: #aaa
  font-weight: 700

  ul
    list-style: none
    margin: 0 0 0 10px
    padding: 0

  li
    display: inline
    margin: 0 10px

  li.active
    color: #ededed
    border-bottom: 2px solid #ededed
"""

update: (output, domEl) ->
  values = output.split(',')
  spaces = values[0].split(' ')
  space = values[1]

  htmlString = ""
  for i in [0..spaces.length - 1]
    htmlString += "<li id=\"desktop#{spaces[i]}\"><span class=\"white fa-sm #{@icons[i]}\"><span/></li>"

  if ($(domEl).find('.currentDesktop-container').attr('data-count') != spaces.length.toString())
     $(domEl).find('.currentDesktop-container').attr('data-count', "#{spaces.length}")
     $(domEl).find('ul').html(htmlString)
     $(domEl).find("li#desktop#{space}").addClass('active')
  else
    $(domEl).find('li.active').removeClass('active')
    $(domEl).find("li#desktop#{space}").addClass('active')
