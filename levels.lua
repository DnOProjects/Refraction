levels = {}

function levels.load()

	for i=1,5 do
		local platform = newComponent(cPlatform)
		platform:setVect(i*200,540)
		platform:setSize(200,50)
		platform:setImage(platformImg)
		entity.addEntity(platform)
	end

end