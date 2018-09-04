input = {}

function love.keypressed(key)
	if key == "w" then
		player.input("jump")
	elseif key == "a" then
		player.input("left")
	elseif key == "s" then
		player.input("duck")
	elseif key == "d" then
		player.input("right")
	end
end