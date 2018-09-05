function newComponent(...)
	local cls, bases = {}, {...}
	for i, base in ipairs(bases) do
		for k, v in pairs(base) do
			cls[k] = v
		end
	end
	cls.__index, cls.is_a = cls, {[cls] = true}
	for i, base in ipairs(bases) do
		for c in pairs(base.is_a) do
			cls.is_a[c] = true
		end
		cls.is_a[base] = true
	end
	setmetatable(cls, {__call = function (c, ...)
		local instance = setmetatable({}, c)
		local init = instance._init
		if init then init(instance, ...) end
		return instance
	end})
	return cls
end

cFriction = newComponent()

	cFriction.friction=0.5 --scale 0-1

cAirResistance = newComponent()

	cAirResistance.airResistance=0.99 --scale 0-1

cCollides = newComponent()

	cCollides.collidesWith = {}

	function cCollides:addCollider(n)
		self.collidesWith[#self.collidesWith+1]=n
	end

	function cCollides:isColliding()
		for i=1,#entities do
			local e=entities[i]
			if e.hasHitbox then
				if logic.inList(self.collidesWith,e.componentID) then
					if self:isIntersecting(e) or e:isIntersecting(self) then
						return true
					end
				end
			end
		end
	end

cHasGravity = newComponent()

	cHasGravity.gravity=200

	function cHasGravity:updateGravity(dt)
		if self.isColliding==nil or not self:isColliding() then 
			self.yv=20
			if self.yv<self.gravity then self.yv=self.yv+(self.gravity*0.2) end
		end
	end

cVect = newComponent()

	cVect.x=0 --default values
	cVect.y=0

	function cVect:setVect(x,y)
		self.x=x
		self.y=y
	end

cVel = newComponent()

	cVel.xv=0
	cVel.yv=0

	function cVel:setVel(x,y)
		self.xv=x
		self.yv=y
	end

	function cVel:updateVelocity(dt)
		--if self.componentID==1 then self.canJump=false end
		if self.airResistance then
			self.xv=self.xv*self.airResistance
			self.yv=self.yv*self.airResistance
		end
		if self.collidesWith~=nil then
			self.x=self.x+self.xv*dt
			if self:isColliding() then
				self.x=self.x-self.xv*dt
			end
			self.y=self.y+self.yv*dt
			if self:isColliding() then
				self.y=self.y-self.yv*dt
				if self.xv~=0 and self.friction then self.xv=self.xv*self.friction end --applies ground friction when rubbing agaist a surface
				--if self.yv>0 and self.componentID==1 then self.canJump=true end
			end
		end
	end

cColor = newComponent()

	cColor.r=255 --default values
	cColor.g=255
	cColor.b=255
	cColor.a=255

	function cColor:setColor(r,b,g,a)
		local a = a or 1
		if r <= 1 and b <= 1 and g <= 1 and a <= 1 then
			self.r,self.g,self.b,self.a=r,g,b,a
		else
			a = a or 255
			self.r,self.g,self.b,self.a=r/255,g/255,b/255,a/255
		end
	end

	function cColor:setDrawColor()
	    love.graphics.setColor(self.r,self.b,self.g,self.a)
	end

cHitbox = newComponent(cVect)

	cHitbox.hasHitbox=true

	function cHitbox:setSize(w,h)
		self.w=w
		self.h=h
	end

	function cHitbox:isIntersecting(hitbox)
		local x,y,w,h=self.x,self.y,self.w,self.h
		local ox,oy,ow,oh=hitbox.x,hitbox.y,hitbox.w,hitbox.h
		if ((x>=ox and x<=ox+ow) or (x+w>=ox and x+w<=ox+ow)) and ((y>=oy and y<=oy+oh) or (y+h>=oy and y+h<=oy+oh)) then 
			return true
		else
			return false
		end
	end

	function cHitbox:drawHitbox()
		local x,y,w,h=self.x,self.y,self.w,self.h
		love.graphics.rectangle("line",x,y,w,h)
	end

cDrawable = newComponent(cVect,cColor)

	function cDrawable:setImage(image)
		self.image=image
	end

	function cDrawable:draw()
		self:setDrawColor()
		love.graphics.draw(self.image,self.x,self.y)
	end

cWall = newComponent(cHitbox,cDrawable)

cCharacter = newComponent(cHitbox,cDrawable,cHasGravity,cVel,cCollides,cFriction,cAirResistance)

	function cCharacter:update(dt)
		self:updateGravity(dt)
		self:updateVelocity(dt)
	end

	function cCharacter:onGround()
		for i=2,#entities do
			local e = entities[i]
			if self.y + self.h <= e.y + 1 and self.y + self.h >= e.y - 1 and self.x + self.w >= e.x and self.x <= e.x + e.w then
				return true
			end
		end
		return false
	end