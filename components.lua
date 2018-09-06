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
		if (self.jumping==nil or not self.jumping) and (self.isColliding==nil or not self:isColliding()) then 
			self.yv=200
			if self.yv<self.gravity then self.yv=self.yv+(self.gravity*0.2) end
		end
	end

cVect = newComponent()

	cVect.x=0 --default values
	cVect.y=0
	cVect.orx=0
	cVect.ory=0

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
		if r <= 1 and b <= 1 and g <= 1 and (a == nil or a <= 1) then
			local a = a or 1
			self.r,self.g,self.b,self.a=r,g,b,a
		else
			local a = a or 255
			self.r,self.g,self.b,self.a=r/255,g/255,b/255,a/255
		end
	end

	function cColor:setDrawColor()
	    love.graphics.setColor(self.r,self.b,self.g,self.a)
	end

cHitbox = newComponent(cVect)

	cHitbox.hasHitbox=true

	function cHitbox:setPhysics(physics)
		self.physics=physics
	end

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

	cDrawable.drawW=1
	cDrawable.drawH=1

	function cDrawable:setVisible(visible)
		self.visible=visible
	end

	function cDrawable:setImage(image)
		self.image=image
	end

	function cDrawable:draw()
		self:setDrawColor()
		love.graphics.draw(self.image,self.x,self.y,0,self.drawW,self.drawH)
	end

	function cDrawable:scaleToHitbox()
		if self.hasHitbox and self.image ~= nil then
			self.drawW = self.w/self.image:getWidth()
			self.drawH = self.h/self.image:getHeight()
		end
	end

cText = newComponent(cVect)

	cText.textW=1
	cText.textH=1

	function cText:setTextSize(w,h)
		self.textW=w
		self.textH=h
	end

	function cText:setText(text)
		self.text=text
	end

	function cText:drawText()
		self:setDrawColor()
		love.graphics.print(self.text,self.x+5,self.y+5,0,self.textW,self.textH)
	end

cUI = newComponent(cHitbox,cDrawable,cText)

	function cUI:setType(type,uiX,uiY)
		self.type=type
		self.uiX=uiX
		self.uiY=uiY
	end

cWall = newComponent(cHitbox,cDrawable)

cCharacter = newComponent(cHitbox,cDrawable,cHasGravity,cVel,cCollides,cFriction,cAirResistance)

	cCharacter.jumpHeight = 200

	function cCharacter:update(dt)
		self:updateGravity(dt)
		self:updateVelocity(dt)
	end

	function cCharacter:onGround()
		for i=2,#entities do
			local e = entities[i]
			if self.y + self.h <= e.y and self.y + self.h >= e.y - 5 and self.x + self.w >= e.x and self.x <= e.x + e.w then
				return true
			end
		end
		return false
	end

	function cCharacter:headColliding()
		for i=2,#entities do
			local e = entities[i]
			if self.y <= e.y + e.h + 5 and self.y >= e.y + e.h and self.x + self.w >= e.x and self.x <= e.x + e.w then
				return true
			end
		end
		return false
	end