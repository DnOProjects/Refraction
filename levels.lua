bitser = require "bitser"

levels = {}

function levels.load()

	local platform = newComponent(cWall)
	platform:setSize(200,50)
	platform:setImage(platformImg)

	local highWall = newComponent(cWall)
	highWall:setSize(50,500)
	highWall:setImage(wallImg)

	local player = newComponent(cCharacter)
	player:setSize(50,100)
	player:setImage(playerImg)
	for i=2,3 do
		player:addCollider(i)
	end
	player.toRemove=false

	selectedLevelComponent=1

	levelComponents={
	player,
	platform,
	highWall,
	}

	if gameState == "creating" then
		newLevel = true
		level={}
		levels.loadLevel(currentLevel)
		entities[1]:setVect(0,0)
		for i=2,#entities do
			entities[i].toRemove = true
		end
	elseif gameState == "playing" then
		level=levels.loadLevel(currentLevel)
	end

	scroll=newComponent(cVect)

end

function levels.input(command,x,y)

	if x == nil or y == nil then
		if command == "left" then scroll.x=scroll.x+5 end
		if command == "right" then scroll.x=scroll.x-5 end
		if command == "up" then scroll.y=scroll.y+5 end
		if command == "down" then scroll.y=scroll.y-5 end
		if type(command) == "number" then selectedLevelComponent=command+1 end
		if command == "save" then 
			levels.saveLevel()
			love.event.quit()
		end
		if command == "play" then
			gameState = "playing"
			love.mouse.setVisible(false)
			scroll.x=0
			scroll.y=0
		end
		if command == "create" then
			gameState = "creating"
			love.mouse.setVisible(true)
		end
	else
		if command == "place" then
			local e=newComponent(levelComponents[selectedLevelComponent])
			e:setVect(x-scroll.x,y-scroll.y)
			e.componentID=selectedLevelComponent
			if selectedLevelComponent==1 then--player
				entities[1] = e
			else
				entity.addEntity(e)
			end
		elseif command == "destroy" then
			for i=1,#entities do
				local e=entities[i]
				if x - scroll.x < e.x + e.w and x - scroll.x > e.x and y - scroll.y < e.y + e.h and y - scroll.y > e.y then
					e.toRemove = true
				end
			end
		end
	end

end

function levels.draw()
	if gameState == "creating" then
		levelComponents[selectedLevelComponent]:setVect(love.mouse.getX(),love.mouse.getY())
		levelComponents[selectedLevelComponent]:drawHitbox()
	end
end		

function levels.saveLevel()
	if newLevel then file = io.output("Levels/level_"..tostring(#love.filesystem.getDirectoryItems("Levels")+1))
	else file = io.output("Levels/level_"..tostring(currentLevel)) end
	local simplifiedEntities = {}
	for i=1,#entities do
		if not entities[i].toRemove then
			local e = entities[i]
			print(e.componentID)
			simplifiedEntities[#simplifiedEntities+1]={x=e.x,y=e.y,ID=e.componentID} --TODO: make a system for adding more generalised variables that change within components
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
		e:setVect(se.x,se.y) --TODO: make a system for adding more generalised variables that change within components
		e.componentID=se.ID
		if se.ID==1 then--player
			entities[1] = e
		else
			entity.addEntity(e)
		end
	end
	io.close(file)
end