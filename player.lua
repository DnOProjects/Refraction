player = {}

function player.input(command)

	local p = entities[1]

	if command == "left" then
		p:setVect(p.x-10,p.y)
		if p:isColliding() then p:setVect(p.x+10,p.y) end
	elseif command == "right" then
		p:setVect(p.x+10,p.y)
		if p:isColliding() then p:setVect(p.x-10,p.y) end
	elseif command == "jump" then

	elseif command == "duck" then

	end

end