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
	playingLevel=false
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

	levels.loadLevel(1)

end

function love.update(dt)

	input.update()
	entity.update(dt)

end

function love.draw()

	love.graphics.push()
	love.graphics.translate(scroll.x,scroll.y)
	entity.draw()
	love.graphics.pop()

	levels.draw()

end