-----------------------------------------------------------------------------------------
--
-- level.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local jslib = require( "simpleJoystick" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"

--------------------------------------------

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX
local shootBut = display.newCircle( screenW - 100, screenH - 45 , 30 )
local bulletSpeed = 2

-- shoot function
local function onPressShot( event )
	if ( event.phase == "began" ) then
		shootBut:setFillColor(0.4 , 0.4, 0.4)
    elseif ( event.phase == "ended" ) then
        shootBut:setFillColor(0.7 , 0.7, 0.7)
    end
	return true	
end

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	-- We need physics started to add bodies, but we don't want the simulaton
	-- running until the scene is on the screen.
	physics.start()
	physics.pause()

	-- create Player
	local player = display.newCircle( display.contentCenterX, display.contentCenterY , 20 )
	player:setFillColor(1 , 0.1, 0.15)
	-- create joystick
	local js = jslib.new( 35, 50 )
	js.x = display.screenOriginX + 60
	js.y = screenH - 60
	-- set shoot button
	shootBut:setFillColor(0.7 , 0.7, 0.7)
	shootBut:addEventListener("touch", onPressShot );
	-- create background
	local background = display.newRect( display.screenOriginX, display.screenOriginY, screenW, screenH )
	background.anchorX = 0 
	background.anchorY = 0
	background:setFillColor( 0.1, 0.1, 0.1 )


	-- movment function
 	function catchTimer( e )
		local x = math.cos(math.rad(js:getAngle())) * js:getDistance() 
		local y = math.sin(math.rad(js:getAngle())) * js:getDistance() * -1
		player:translate(x , y)
		return true
	end

	js:activate()
	timer.performWithDelay( 20, catchTimer, -1 )


	-- create Computer
	-- local player = display.newCircle( display.contentCenterX, display.contentCenterY , 20 )
	-- player:setFillColor(0.3 , 0.65, 0.95)


	

	-- add physics to the crate
	-- physics.addBody( crate, { density=1.0, friction=0.3, bounce=0.3 } )
	
	-- create a grass object and add physics (with custom shape)
	--local grass = display.newImageRect( "assets/level/grass.png", screenW, 82 )
	--grass.anchorX = 0
	---grass.anchorY = 1
	--  draw the grass at the very bottom of the screen
	--grass.x, grass.y = display.screenOriginX, display.actualContentHeight + display.screenOriginY
	
	-- define a shape that's slightly shorter than image bounds (set draw mode to "hybrid" or "debug" to see)
	--local grassShape = { -halfW,-34, halfW,-34, halfW,34, -halfW,34 }
	--physics.addBody( grass, "static", { friction=0.3, shape=grassShape } )
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( player )
	sceneGroup:insert( shootBut )
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene