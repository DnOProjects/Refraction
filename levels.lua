levels = {}

function levels.load()

	local platform = newComponent(cWall)
	platform:setSize(200,50)
	platform:setImage(platformImg)

	local highWall = newComponent(cWall)
	highWall:setSize(50,500)
	highWall:setImage(wallImg)

	selectedLevelComponent=1
	levelComponents={
	platform,
	highWall,
	}

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
	entity.addEntity(e)
end