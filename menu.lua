-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

-- 'onRelease' event listener for background
local function onScreenTouch()
	-- go to level.lua scene
	composer.gotoScene( "level", "fade", 500 )
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view

	-- display a background image
	local background = display.newImageRect( "assets/menu/menu_back.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	-- add touch listener to background 
	background:addEventListener("touch", onScreenTouch );

	-- all display objects must be inserted into group
	sceneGroup:insert( background )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
end

function scene:destroy( event )
	local sceneGroup = self.view
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene