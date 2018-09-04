player = {}

function player.load()

	local player = cPlayer
	player:setPos(200,200)
	player.hitbox:setSize(200,50)
	player.drawable.color:setColor(255,0,0)
	player.drawable:setImage(platformImg)
	entity.addEntity(player)

end

function player.input(command)

	local p = entities[1]

	if command == "left" then
		p:setPos(100,200)
	elseif command == "right" then
		p:setPos(300,200)
	elseif command == "jump" then

	elseif command == "duck" then

	end

end