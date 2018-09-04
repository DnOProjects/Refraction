component = {}

function component:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

cPos = component:new{x=0,y=0}

cVect = component:new{x=0,y=0}

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

cHitbox = cPos:new{w,h}

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

cDrawable = component:new{pos=cPos:new{},color=cColor:new{},image}

cPlatform = component:new{drawable=cDrawable:new{},hitbox=cHitbox:new{}}

	function cPlatform:init()
		self.drawable.image = self.image
		self.drawable.x = self.x
		self.drawable.y = self.y
		self.drawable.color.r = self.color.r
		self.drawable.color.g = self.color.g
		self.drawable.color.b = self.color.b
		self.hitbox.x = self.x
		self.hitbox.y = self.y
		self.hitbox.w = self.w
		self.hitbox.h = self.h
	end

	function cPlatform:update(dt)
		
	end
	
	function cPlatform:draw()
		local image,x,y = self.drawable.image,self.drawable.x,self.drawable.y
		self.drawable.color:setDrawColor()
		love.graphics.draw(image,x,y)
	end