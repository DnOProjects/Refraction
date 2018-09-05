require "images"
require "logic"
require "bitser"
require "input"
require "components"
require "entity"
require "player"
require "levels"

function love.load()

	creatingLevel=true
	debugMode=true

	math.randomseed(os.time())
	if not creatingLevel then love.mouse.setVisible(false) end
	love.graphics.setDefaultFilter("nearest","linear", 100 )

	images.load()
	entity.load()
	player.load()
	levels.load()

	if creatingLevel then
		level={}
	else
		level=levels.loadLevel()
	end

	scroll=newComponent(cVect)

end

function love.update(dt)

	if creatingLevel then
		if love.keyboard.isDown("a") then scroll.x=scroll.x+5 end
		if love.keyboard.isDown("d") then scroll.x=scroll.x-5 end
		if love.keyboard.isDown("w") then scroll.y=scroll.y+5 end
		if love.keyboard.isDown("s") then scroll.y=scroll.y-5 end
		for i=0,9 do
			if love.keyboard.isDown(i) then selectedLevelComponent=i+1 end
		end
	end

	input.update()
	entity.update(dt)

end

function love.draw()

	love.graphics.push()
	love.graphics.translate(scroll.x,scroll.y)
	entity.draw()
	love.graphics.pop()

end