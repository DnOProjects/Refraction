player = {}

function player.input(command)

	local p = entities[1]

	if command == "left" then
		p:setVect(p.x-10,p.y)
	elseif command == "right" then
		p:setVect(p.x+10,p.y)
	elseif command == "jump" then
		p:setVect(p.x,p.y-10)
	elseif command == "duck" then

	end

end