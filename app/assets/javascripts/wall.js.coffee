#= require jquery
#= require way.min
#= require underscore-min

unless String::trim then String::trim = -> @replace /^\s+|\s+$/g, ""

$(document).ready ->
	current = []
	recent_messages = []

	reload = ->
		$.get '/messages/recent', (data) ->
			recent_messages = data.messages
			setTimeout reload, 20000
	
	updateClass = ->
		$(".message-box .content").each ->
				length = $(this).text().trim().length
				if length < 10
					$(this).addClass 'text-large'
				else if length > 10 && length < 40
					$(this).addClass 'text-medium'
				else
					$(this).addClass 'text-small'

	refresh = (start)->
		total = recent_messages.length
		console.log "start:" + start + " total: " + total
		if start < total
			current = recent_messages[start...(start + 4)]
			start += 1
		else
			current = recent_messages[0...4]
			start = 0

		way.set "messages", current

		setTimeout ->
			refresh start
			updateClass()
		, 2000

	reload()
	refresh(0)
		
