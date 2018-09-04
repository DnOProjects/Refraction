require "images"
require "logic"
require "bitser"
require "input"
require "entity"
require "player"
require "components"

function love.load()

	math.randomseed(os.time())
	love.mouse.setVisible(false)
	love.graphics.setDefaultFilter("nearest","linear", 100 )

	images.load()
	entity.load()
	player.load()

end

function love.update(dt)

	entity.update(dt)

end

function love.draw()

	entity.draw()

end