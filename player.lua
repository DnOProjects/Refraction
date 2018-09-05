player = {}

function player.load()

	local player = cPlayer
	player:setVect(200,200)
	player:setSize(200,50)
	player:setColor(255,0,0)
	player:setImage(platformImg)
	player.componentID=1
	entity.addEntity(player)

end

function player.input(command)

	local p = entities[1]

	if command == "left" then
		p:setVect(p.x-10,p.y)
	elseif command == "right" then
		p:setVect(p.x+10,p.y)
	elseif command == "jump" then

	elseif command == "duck" then

	end

end