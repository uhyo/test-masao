# Client-side Code
# Bind to socket events
#SS.socket.on 'disconnect', ->  $('#message').text('SocketStream server is down :-(')
#SS.socket.on 'reconnect', ->   $('#message').text('SocketStream server is up :-)')

# This method is called automatically when the websocket connection is established. Do not rename/delete
exports.init = ->
  evinit()

  SS.server.app.init (obj)->
  	if obj.err?
  		document.getElementById("message").textContent=obj.err
  		return
  	showMasaoList obj.files

  
showMasaoList=(files)->
	ul=document.getElementById "masaolist"
	while ul.firstChild
		ul.removeChild ul.firstChilddocument.getElementById("message").textContent=obj.err
	for file in files
		li=document.createElement "li"
		li.textContent=file
		ul.appendChild li
		
evinit=->
	document.addEventListener "click",(e)->
		t=e.target
		return if t.tagName.toLowerCase()!="li"
		p=findParent e.target,(node)->
			node.id=="masaolist"
		return if !p
		SS.server.app.getMasao t.textContent,(obj)->
			setMasao obj
	,false
		
		
findParent = (node,callback)->
	while node=node.parentNode
		if callback(node)
			break
	node
	
setMasao = (obj)->
	if !obj.options? || !obj.params?
		document.getElementById("message").textContent="不正な正男データです！"
		return
	game=document.getElementById "masaogame"
	while game.firstChild
		game.removeChild game.firstChild
	h1=document.createElement("h1")
	h1.textContent=obj.options.title
	game.appendChild h1
	
	object=document.createElement("object")
	object.type="application/x-java-applet"
	object.width=512
	object.height=320
#	object.data="masao/mc_c.jar"
#	obj.params.code=obj.masao?.code ? "MasaoConstruction.class"
	object.setAttribute "classid","java:#{obj.masao?.code ? 'MasaoConstruction.class'}"
	object.archive="masao/mc_c.jar"
	
	root_directory="masao/"
	kdef=
		filename_title:"title.gif"
		filename_pattern:"pattern.gif"
		filename_gameover:"gameover.gif"
		filename_ending:"ending.gif"
		
	for name,value of kdef
		obj.params[name] = root_directory + (obj.params[name] ? value)
	
	if obj.masao?.id
		object.id=obj.masao.id
	for name,value of obj.params
		param=document.createElement("param")
		param.name=name
		param.value=value
		object.appendChild param
	game.appendChild(object)
	
	
