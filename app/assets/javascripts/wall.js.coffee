#= require jquery
#= require way.min
#= require underscore-min
#= require screenfull

unless String::trim then String::trim = -> @replace /^\s+|\s+$/g, ""
wall_id = null
wall = {}
SIZE = 5
per_page = SIZE
INTERVAL = 3000

window.main = {
  initialize : (id)->
    this.load(id)
  wall_url: (id) ->
    "/walls/#{id}.json"

  load: (id) ->
    $.get this.wall_url(id), (data) ->
      wall = data.wall
      way.set "wall", wall
      wall_id = id
      if wall.background_image_url
        $("body").css("background-image", "url(#{wall.background_image_url})")

      main.draw(0)
  draw: (start) ->
    normal = wall.messages
    sticky = wall.sticky_messages
    current = wall.messages.slice(start, start + per_page)

    if sticky.length > 0
      per_page = SIZE - sticky.length
      current = sticky.concat(normal.slice(start, start + per_page))

    next_start = start + (per_page - sticky.length)

    way.set "messages", current

    if normal[next_start]
      setTimeout ->
        main.draw(start + per_page)
      , INTERVAL
    else
      setTimeout ->
        main.load(wall_id)
      , INTERVAL

}

$(document).ready ->
  if screenfull.isFullscreen
    $("#exit_full_screen").show()
  else
    $("#enter_full_screen").show()

  if screenfull.enabled
    $("#enter_full_screen").click ->
      screenfull.request()
      $("#enter_full_screen").hide()
      $("#exit_full_screen").show()
    $("#exit_full_screen").click ->
      screenfull.exit()
      $("#exit_full_screen").hide()
      $("#enter_full_screen").show()
