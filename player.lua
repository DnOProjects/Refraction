player = {}

function player.update(dt)

	local p = entities[1]

	if p.jumping == true and p.y <= p.ory - p.jumpHeight then
		p.ory = 0
		p.jumping = false
	end

end

function player.input(command)

	local p = entities[1]

	if command == "left" then
		p:setVel(-300,p.yv)
	elseif command == "right" then
		p:setVel(300,p.yv)
	elseif command == "jump" then
		if p:onGround() then	
			p:setVel(p.xv,-400)
			p.ory = p.y
			p.jumping = true
		end
	elseif command == "duck" then
		p:setVect(p.x,p.y+30)
		if p:isColliding() then p:setVect(p.x,p.y-30) end
	end

end