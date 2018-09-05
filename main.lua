require "images"
require "logic"
require "bitser"
require "input"
require "components"
require "entity"
require "player"
require "levels"

function love.load()

	love.graphics.setBackgroundColor(0,1,1)

	gameState = "playing"
	debugMode=false

	math.randomseed(os.time())
	if not (gameState == "creating") then love.mouse.setVisible(false) end
	love.graphics.setDefaultFilter("nearest","linear", 100 )

	images.load()
	entity.load()
	levels.load()

	if gameState == "creating" then
		level={}
		levels.loadLevel(7)
	elseif gameState == "playing" then
		level=levels.loadLevel(7)
	end

	scroll=newComponent(cVect)

end

function love.update(dt)

	input.update()
	entity.update(dt)
	player.update(dt)

end

function love.draw()

	love.graphics.push()
	love.graphics.translate(scroll.x,scroll.y)
	entity.draw()
	love.graphics.pop()

	levels.draw()

end