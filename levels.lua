bitser = require "bitser"

levels = {}

function levels.load()

	local platform = newComponent(cWall)
	platform:setSize(200,50)
	platform:setImage(platformImg)

	local highWall = newComponent(cWall)
	highWall:setSize(50,500)
	highWall:setImage(wallImg)

	local player = newComponent(cPlayer)
	player:setVect(200,200)
	player:setSize(200,50)
	player:setColor(255,0,0)
	player:setImage(platformImg)
	player.toRemove=false

	selectedLevelComponent=1

	levelComponents={
	player,
	platform,
	highWall,
	}

end

function levels.doScroll(dir)

	if dir == "left" then scroll.x=scroll.x+5 end
	if dir == "right" then scroll.x=scroll.x-5 end
	if dir == "up" then scroll.y=scroll.y+5 end
	if dir == "down" then scroll.y=scroll.y-5 end
	if type(dir) == "number" then selectedLevelComponent=dir+1 end
	if dir == "save" then 
		levels.saveLevel()
		love.event.quit()
	end

end

function levels.draw()
	if creatingLevel then
		levelComponents[selectedLevelComponent]:setVect(love.mouse.getX(),love.mouse.getY())
		levelComponents[selectedLevelComponent]:drawHitbox()
	end
end

function love.mousepressed(x,y)
	local e=newComponent(levelComponents[selectedLevelComponent])
	e:setVect(x-scroll.x,y-scroll.y)
	e.componentID=selectedLevelComponent
	if selectedLevelComponent==1 then--player
		entities[1] = e
	else
		entity.addEntity(e)
	end
end

function levels.saveLevel()
	file = io.output("Levels/level_"..tostring(#love.filesystem.getDirectoryItems("Levels")+1))
	local simplifiedEntities = {}
	for i=1,#entities do
		if not entities[i].toRemove then
			local e = entities[i]
			print(e.componentID)
			simplifiedEntities[#simplifiedEntities+1]={x=e.x,y=e.y,ID=e.componentID}
		end
	end
	io.write(bitser.dumps(simplifiedEntities))
	io.close(file)
end

function levels.loadLevel(n)
	file = io.input("Levels/level_"..tostring(n))
	local simplifiedEntities=bitser.loads(io.read("*all"))
	for i=1,#simplifiedEntities do
		local se=simplifiedEntities[i]
		local e=newComponent(levelComponents[se.ID])
		e:setVect(se.x,se.y)
		e.componentID=se.ID
		if se.ID==1 then--player
			entities[1] = e
		else
			entity.addEntity(e)
		end
	end
	io.close(file)
end