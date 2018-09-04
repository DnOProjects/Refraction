player = {}

function player.load()

	player = logic.copyTable(cPlayer)

	player:setPos(200,200)
	player.hitbox:setSize(200,50)
	player.drawable.color:setColor(255,0,0)
	player.drawable:setImage(platformImg)

end

function player.input(command)

	if command == "left" then

	elseif command == "right" then

	elseif command == "jump" then

	elseif command == "duck" then

	end

end