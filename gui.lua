gui = {}

function gui.load()

	ui = {}

	for x=1,10 do
		local hotbar = newComponent(cUI)
		hotbar:setSize(100,100)
		hotbar:setVect(300+110*x,970)
		hotbar:setTextSize(2,2)
		hotbar:setType(1,x,1)
		hotbar:setImage(hotbarImg)
		hotbar:scaleToHitbox()
		gui.addUI(hotbar)
		local hotbarImage=newComponent(visualLevelComponents[x])
		hotbarImage:setSize(hotbarImage.image:getWidth()/2,hotbarImage.image:getHeight()/2)
		hotbarImage:setVect(300+110*x,970+40)
		hotbarImage:scaleToHitbox()
		hotbarImage:setPhysics(false)
		gui.addUI(hotbarImage)
	end
	for x=1,3 do
		for y=1,3 do
			local colorbar = newComponent(cUI)
			colorbar:setSize(100,100)
			colorbar:setVect(1480+110*x,300+110*y)
			colorbar:setType(2,x,y)
			colorbar:setImage(hotbarImg)
			colorbar:scaleToHitbox()
			gui.addUI(colorbar)
		end
	end
	
end

function gui.update(dt)

	for i=1,#ui do
		local u = ui[i]
		if not u.toRemove then
			if u.update and gameState == "creating" and u.physics ~= false then
				u:update(dt)
			end
		end
	end

	gui.removeUI()

end

function gui.draw()

	for i=1,#ui do
		local u=ui[i]
		if not u.toRemove and u.draw and u.visible ~= false then
			if gameState == "creating" then
				if u.type==1 then
					if visualLevelComponent==u.uiX then
						u:setColor(0.52,0.52,0.52)
					else
						u:setColor(0.1,0.1,0.1)
					end
					u:setText(u.uiX)
					u:drawText()
				else

				end
				u:draw()
			end
		end
	end

end

function gui.addUI(u)

	ui[#ui+1] = u
	ui[#ui].toRemove = false

end

function gui.removeUI()

	for i=#ui,1,-1 do
		if ui[i].toRemove then
			table.remove(ui,i)
		end
	end

end