entity = {}

function entity.load()

	entities = {}

	--imagine this is part of a platform placing function

	for i=1,2 do
		local platform = cPlatform:new{}
		platform:setPos(i*500,540)
		platform.hitbox:setSize(200,50)
		platform.drawable:setImage(platformImg)
		entity.addEntity(platform)
	end

end

function entity.update(dt)

	for i=1,#entities do
		local e = entities[i]
		if not e.toRemove and e.update then
			e:update(dt)
		end
	end

	entity.removeEntities()

end

function entity.draw()

	for i=1,#entities do
		local e=entities[i]
		if not e.toRemove and e.draw then
			e:draw() 
		end
	end

end

function entity.addEntity(e)

	entities[#entities+1] = e
	entities[#entities].toRemove = false

end

function entity.removeEntities()

	for i=#entities,1,-1 do
		if entities[i].toRemove then
			table.remove(entities,i)
		end
	end

end