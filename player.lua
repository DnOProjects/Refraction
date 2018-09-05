player = {}

function player.update(dt)

	local p = entities[1]

	if p.jumping == true and (p.y <= p.ory - p.jumpHeight or p:headColliding()) then
		p.ory = 0
		p.jumping = false
	end

end

function player.input(command)

	local p = entities[1]

	if command == "left" then p:setVel(-300,p.yv) end
	if command == "right" then p:setVel(300,p.yv) end
	if command == "jump" then
		if p:onGround() then	
			p:setVel(p.xv,-400)
			p.ory = p.y
			p.jumping = true
		end
	end
	if command == "duck" then
		if p:onGround() == false then
			p.jumping = false
			p:setVect(p.x,p.y+10)
			if p:isColliding() then p:setVect(p.x,p.y-10) end
		end
	end

end