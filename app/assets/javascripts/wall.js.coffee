#= require jquery
#= require way.min
#= require underscore-min

unless String::trim then String::trim = -> @replace /^\s+|\s+$/g, ""

$(document).ready ->
	current = []
	recent_messages = []
	size = 5

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
			current = recent_messages[start...(start + size)]
			start += size
		else
			current = recent_messages[0...size]
			start = 0

		way.set "messages", current

		setTimeout ->
			$(".message-box").fadeOut('slow')
			refresh start
			$(".message-box").fadeIn('slow')
			updateClass()
		, 3000

	reload()
	refresh(0)
		
