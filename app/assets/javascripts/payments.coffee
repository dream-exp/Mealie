# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

dispatcher = new WebSocketRails(window.location.hostname + ':' + window.location.port + "/websocket")
channel = dispatcher.subscribe("payments")
channel.bind "create", (tweet) ->
	console.log(tweet)
	location.href = window.location.protocol + '//' + window.location.hostname + ':' + window.location.port + '/payments/confirmation/' + tweet