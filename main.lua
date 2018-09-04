require "images"
require "logic"
require "bitser"
require "entity"
require "components"

function love.load()

	math.randomseed(os.time())
	love.mouse.setVisible(false)
	love.graphics.setDefaultFilter("nearest","linear", 100 )

	images.load()
	entity.load()

end

function love.update(dt)

	entity.update(dt)

end

function love.draw()

	entity.draw()

end