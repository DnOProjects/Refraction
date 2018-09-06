input = {}

function input.update()

	if gameState == "creating" then
		if love.keyboard.isDown("a") then levels.input("left") end
		if love.keyboard.isDown("d") then levels.input("right") end
		if love.keyboard.isDown("w") then levels.input("up") end
		if love.keyboard.isDown("s") then levels.input("down") end
		for i=0,9 do
			if love.keyboard.isDown(i) then levels.input(i) end
		end
	elseif gameState == "playing" then
		if love.keyboard.isDown("w") or love.keyboard.isDown("space") then player.input("jump") end
		if love.keyboard.isDown("a") then player.input("left") end
		if love.keyboard.isDown("s") then player.input("duck") end
		if love.keyboard.isDown("d") then player.input("right") end
	end

	function love.keypressed(key)
		if gameState == "creating" then
			if key == "=" then levels.input("save") end
			if key == "return" then levels.input("play") end
		elseif gameState == "playing" then
			if key == "return" then levels.input("create") end
		end
	end

	function love.mousepressed(x,y,button)
		if gameState == "creating" then
			if button == 1 then
				levels.input("place",x,y)
			elseif button == 2 then
				levels.input("destroy",x,y)
			end
		end
	end
	
end