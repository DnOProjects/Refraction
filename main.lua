require "images"
require "logic"
require "bitser"
require "input"
require "components"
require "entity"
require "player"
require "levels"

function love.load()

	math.randomseed(os.time())
	love.mouse.setVisible(false)
	love.graphics.setDefaultFilter("nearest","linear", 100 )

	images.load()
	entity.load()
	player.load()
	levels.load()

end

function love.update(dt)

	input.update()
	entity.update(dt)

end

function love.draw()

	entity.draw()

end