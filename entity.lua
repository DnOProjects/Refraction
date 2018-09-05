entity = {}

function entity.load()

	entities = {}
	
end

function entity.update(dt)

	for i=1,#entities do
		local e = entities[i]
		if not e.toRemove then
			if e.update then
				e:update(dt)
			end
		end
	end

	entity.removeEntities()

end

function entity.draw()

	for i=1,#entities do
		local e=entities[i]
		if not e.toRemove then
			if e.draw and (e.visible == nil or e.visible == true) then
				e:draw() 
			end
			if debugMode and e.drawHitbox then
				e:drawHitbox()
			end
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