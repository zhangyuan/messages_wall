#= require jquery
#= require way.min
#= require underscore-min

unless String::trim then String::trim = -> @replace /^\s+|\s+$/g, ""
wall_id = null
wall = {}
SIZE = 5

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
      $("body").css("background-image", "url(#{wall.background_image_url})")
      main.draw(0)
  draw: (start) ->
    current = wall.messages.slice(start, start + SIZE)
    if current.length > 0
      way.set "messages", current

      setTimeout ->
        main.draw(start + SIZE)
      ,2000
    else
      setTimeout ->
        main.load(wall_id)
      , 2000
}

# $(document).ready ->
# 	current = []
# 	recent_messages = []
# 	size = 5

# 	reload = ->
# 		$.get '/messages/recent', (data) ->
# 			recent_messages = data.messages
# 			setTimeout reload, 20000
	
# 	updateClass = ->
# 		$(".message-box .content").each ->
# 				length = $(this).text().trim().length
# 				if length < 10
# 					$(this).addClass 'text-large'
# 				else if length > 10 && length < 40
# 					$(this).addClass 'text-medium'
# 				else
# 					$(this).addClass 'text-small'

# 	refresh = (start)->
# 		total = recent_messages.length
# 		console.log "start:" + start + " total: " + total
# 		if start < total
# 			current = recent_messages[start...(start + size)]
# 			start += size
# 		else
# 			current = recent_messages[0...size]
# 			start = 0

# 		way.set "messages", current

# 		setTimeout ->
# 			$(".message-box").fadeOut('slow')
# 			refresh start
# 			$(".message-box").fadeIn('slow')
# 			updateClass()
# 		, 3000

# 	reload()
# 	refresh(0)
		
