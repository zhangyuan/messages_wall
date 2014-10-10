#= require jquery
#= require way.min
#= require underscore-min
#= require screenfull

unless String::trim then String::trim = -> @replace /^\s+|\s+$/g, ""
wall_id = null
wall = {}
SIZE = 5
per_page = SIZE
INTERVAL = 6000

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
    
    if wall.message_color
      $(".message-box .content").css("color",wall.message_color)
    if wall.message_background_color
      $(".message-box").css("background-color",wall.message_background_color)
    if wall.title_color
      $(".page-header h1").css("color", wall.title_color)

    this.updateClass()

    if normal[next_start]
      setTimeout ->
        main.draw(start + per_page)
      , INTERVAL
    else
      setTimeout ->
        main.load(wall_id)
      , INTERVAL
  updateClass: ->
    $(".message-box .content").each ->
      length = $(this).text().trim().length
      if length < 10
        $(this).addClass 'text-large'
      else if length > 10 && length < 40
        $(this).addClass 'text-medium'
      else
        $(this).addClass 'text-small'

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
