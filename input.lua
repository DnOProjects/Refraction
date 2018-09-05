input = {}

function input.update()

	if creatingLevel then
		if love.keyboard.isDown("a") then levels.doScroll("left") end
		if love.keyboard.isDown("d") then levels.doScroll("right") end
		if love.keyboard.isDown("w") then levels.doScroll("up") end
		if love.keyboard.isDown("s") then levels.doScroll("down") end
		for i=0,9 do
			if love.keyboard.isDown(i) then levels.doScroll(i) end
		end
	elseif playingLevel then
		if love.keyboard.isDown("w") then player.input("jump") end
		if love.keyboard.isDown("a") then player.input("left") end
		if love.keyboard.isDown("s") then player.input("duck") end
		if love.keyboard.isDown("d") then player.input("right") end
	end

	function love.keypressed(key)
		if creatingLevel then
			if key == "=" then levels.doScroll("save") end
		end
	end
	
end