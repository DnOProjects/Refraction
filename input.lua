input = {}

function input.update()

	if gameState == "creating" then
		if love.keyboard.isDown("a") then levels.doScroll("left") end
		if love.keyboard.isDown("d") then levels.doScroll("right") end
		if love.keyboard.isDown("w") then levels.doScroll("up") end
		if love.keyboard.isDown("s") then levels.doScroll("down") end
		for i=0,9 do
			if love.keyboard.isDown(i) then levels.doScroll(i) end
		end
	elseif gameState == "playing" then
		if love.keyboard.isDown("w") or love.keyboard.isDown("space") then player.input("jump") end
		if love.keyboard.isDown("a") then player.input("left") end
		if love.keyboard.isDown("s") then player.input("duck") end
		if love.keyboard.isDown("d") then player.input("right") end
	end

	function love.keypressed(key)
		if gameState == "creating" then
			if key == "=" then levels.doScroll("save") end
			if key == "return" then levels.doScroll("play") end
		elseif gameState == "playing" then
			if key == "return" then levels.doScroll("create") end
		end
	end
	
end