player = {}

function player.input(command)

	local p = entities[1]

	if command == "left" then
		p:setVel(-300,p.y)
	elseif command == "right" then
		p:setVel(300,p.y)
	elseif command == "jump" and p:onGround() then
		p:setTarg(p.x,p.y-50)
		if p:isColliding() then p:setVect(p.x,p.y+10) end
	elseif command == "duck" then
		p:setVect(p.x,p.y+30)
		if p:isColliding() then p:setVect(p.x,p.y-30) end
	end

end