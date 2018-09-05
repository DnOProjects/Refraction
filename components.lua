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
					if self:isIntersecting(e) then
						return true
					end
				end
			end
		end
	end

	function cCollides:updateCollision(dt)
		for i=1,#entities do
			local e=entities[i]
			if e.hasHitbox then
				if logic.inList(self.collidesWith,e.componentID) then
					if self:isIntersecting(e) then
						self.xv,self.yv=0,0
					end
				end
			end
		end
	end

cHasGravity = newComponent()

	function cHasGravity:updateGravity(dt)
		if self.isColliding==nil or not self:isColliding() then 
			self.yv=20 
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

	function cVect:setVel(x,y)
		self.xv=x
		self.yv=y
	end

	function cVel:updateVelocity(dt)
		self.x=self.x+self.xv*dt
		self.y=self.y+self.yv*dt
	end

cColor = newComponent()

	cColor.r=255 --default values
	cColor.g=255
	cColor.b=255
	cColor.a=255

	function cColor:setColor(r,b,g,a)
		local a = a or 255
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

cPlayer = newComponent(cHitbox,cDrawable,cHasGravity,cVel,cCollides)

	function cPlayer:update(dt)
		self:updateGravity(dt)
		self:updateVelocity(dt)
		self:updateCollision(dt)
	end