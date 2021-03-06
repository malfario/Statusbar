command: "sh ./statusbar.widgets/scripts/getActiveApp.sh"

refreshFrequency: 1000

render: (output) ->
  """
    <link rel="stylesheet" type="text/css" href="./statusbar.widgets/assets/colors.css">
    <link rel="stylesheet" type="text/css" href="./statusbar.widgets/assets/fontawesome/css/all.min.css">
    <div class="activeApp"></div>
  """

style: """
  width: 100%
  position: absolute
  margin: 0 auto
  margin-top: 2px
  text-align: center
  font: 12px "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif
  color: #a5a5a5
  font-weight: 600
"""

update: (output, domEl) ->
  $(domEl).find('.activeApp').html(output);
