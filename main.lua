require "images"
require "logic"
require "bitser"
require "input"
require "components"
require "entity"
require "player"
require "levels"
require "gui"

function love.load()

	love.graphics.setBackgroundColor(143/255, 196/255, 232/255)

	gameState = "playing"
	debugMode=false
	currentLevel=9

	math.randomseed(os.time())
	if not (gameState == "creating") then love.mouse.setVisible(false) end
	love.graphics.setDefaultFilter("nearest","linear", 100 )

	images.load()
	entity.load()
	levels.load()
	gui.load()

end

function love.update(dt)

	input.update()
	entity.update(dt)
	player.update(dt)
	gui.update(dt)

end

function love.draw()

	love.graphics.push()
	love.graphics.translate(scroll.x,scroll.y)
	entity.draw()
	love.graphics.pop()

	levels.draw()
	gui.draw()

end