levels = {}

function levels.load()

	for i=1,5 do
		local platform = logic.copyTable(cPlatform)
		platform:setPos(i*200,540)
		platform.hitbox:setSize(200,50)
		platform.drawable:setImage(platformImg)
		entity.addEntity(platform)
	end

end