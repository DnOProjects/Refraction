entity = {}

function entity.load()

	entities = {}

	entity.addEntity(cPlatform:new{x=100,y=100,w=500,h=500,color={1,1,1},image=platformImg})

end

function entity.update(dt)

	for i=1,#entities do
		local e = entities[i]
		if not e.toRemove then
			if e.update ~= nil then
				e:update(dt)
			end
		end
	end

	entity.removeEntities()

end

function entity.draw()

	for i=1,#entities do
		local e=entities[i]
		if e.draw then e:draw() end
	end

end

function entity.addEntity(e)

	if e.init ~= nil then
		e:init()
	end
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