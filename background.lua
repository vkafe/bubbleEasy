--
-- Project: MyGame
-- Description: 
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2014 . All Rights Reserved.
--  Модуль заднего вона, должен шататься от акселеметра

local background = display.newImageRect( "bg0.png", display.viewableContentWidth+200,display.viewableContentHeight+200)
background.x=display.viewableContentWidth/2
background.y=display.viewableContentHeight/2


local acc = {}
local centerX = display.viewableContentWidth /2
local centerY = display.viewableContentHeight /2

shake=50

function acc:accelerometer(e)  

    background.x= centerX + (centerX * e.xGravity*10)  
	    background.y=centerY + (centerY * e.yGravity*10)  
	    
	    	if  background.x < centerX-shake  then 
	    		background.x=centerX-shake
	    	end
	    	if  background.x > centerX+shake  then 
	    		background.x=centerX+shake
	    	 end
	    	 if  background.y < centerY-shake  then 
	    		 background.y=centerY-shake
	    	 end
	    	if  background.y > centerY+shake  then 
	    		background.y=centerY+shake
	    	 end

	end


--Runtime:addEventListener("accelerometer", acc)
