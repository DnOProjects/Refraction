player = {}

function player.load()

	local player = cPlayer
	player:setVect(200,200)
	player:setSize(200,50)
	player:setColor(255,0,0)
	player:setImage(platformImg)
	entity.addEntity(player)

end

function player.input(command)

	local p = entities[1]

	if command == "left" then
		p:setVect(100,200)
	elseif command == "right" then
		p:setVect(300,200)
	elseif command == "jump" then

	elseif command == "duck" then

	end

end