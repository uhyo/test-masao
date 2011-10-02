# Server-side Code
message= "SocketStream version #{SS.version} is up and running. This message was sent over Socket.IO so everything is working OK. !!!"

fs=require 'fs'

exports.actions =
  # server init
  init: (cb) ->
    fs.readdir "masaos", (err,files)->
    	if err
    		if err.errno==2
    			fs.mkdir "masaos","755",->
    				SS.server.app.init cb
    		else
    			cb {err:"load err!",files:[]}
    		return
    	cb {files:files}
  
  getMasao: (filename,cb) ->
  	fs.readFile "masaos/#{filename}", "utf8", (err,data)->
  		if err
  			cb {error:"no such file!"}
  		console.log data
  		cb JSON.parse data
