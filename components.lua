component = {}

function component:new(o)
	local o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

cVect = component:new{x=0,y=0}

	function cVect:setVect(x,y)
		self.x=x
		self.y=y
	end

cColor = component:new{r=1,g=1,b=1,a=1}

	function cColor:setColor(r,b,g,a)
		local a = a or 255
		self.r=r/255
		self.g=g/255
		self.b=b/255
		self.a=a/255
	end

	function cColor:setDrawColor()
	    love.graphics.setColor(self.r,self.b,self.g,self.a)
	end

cHitbox = cVect:new{w,h}

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

	function cHitbox:draw()
		local x,y,w,h=self.x,self.y,self.w,self.h
		love.graphics.rectangle("line",x,y,w,h)
	end

cDrawable = cVect:new{color=cColor:new{},image}

	function cDrawable:setImage(image)
		self.image=image
	end

cPlatform = {hitbox=cHitbox:new{},drawable=cDrawable:new{}}

	function cPlatform:update(dt)

	end

	function cPlatform:setPos(x,y)
		self.hitbox:setVect(x,y)
		self.drawable:setVect(x,y)
	end
	
	function cPlatform:draw()
		self.drawable.color:setDrawColor()
		love.graphics.draw(self.drawable.image,self.drawable.x,self.drawable.y)
	end