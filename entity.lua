entity = {}

function entity.load()

	entities = {}
	
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
		if not e.toRemove and debugMode and e.drawHitbox then
			e:drawHitbox()
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