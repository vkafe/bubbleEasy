-- Project: MyGame
-- Description:
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2014 . All Rights Reserved.
---- cpmgen main.lua
display.setStatusBar( display.HiddenStatusBar )

function color(r,g,b) 
	return (r/255), (g/255), (b/255)
 end	    


anchor = {
    TopLeft = function(t) t.anchorX, t.anchorY = 0, 0; end,
    TopCenter = function(t) t.anchorX, t.anchorY = .5, 0; end,
    TopRight = function(t) t.anchorX, t.anchorY = 1, 0; end,
    CenterLeft = function(t) t.anchorX, t.anchorY = 0, .5; end,
    Center = function(t) t.anchorX, t.anchorY = .5, .5; end,
    CenterRight = function(t) t.anchorX, t.anchorY = 1, .5; end,
    BottomLeft = function(t) t.anchorX, t.anchorY = 0, 1; end,
    BottomCenter = function(t) t.anchorX, t.anchorY = .5, 1; end,
    BottomRight = function(t) t.anchorX, t.anchorY = 1, 1; end,
}






 
 
--------создание рекламы
 ads = require "ads"
 
local banner = "ca-app-pub-7571093472122380/2935358034"

 
ads.init( "admob", banner )


ads.show( "banner", { x=display.screenOriginX, y=display.viewableContentHeight-40, appId=banner} )


    --[[
 AdBuddiz = require "plugin.adbuddiz"
  AdBuddiz.setAndroidPublisherKey( "00554e5c-e2ef-482e-bb35-e6bf92290fcf")
  AdBuddiz.setIOSPublisherKey( "6580dc15-74d4-4a9c-9fd0-1728c4f6b02b" )
  AdBuddiz.cacheAds()
 local function onSystemEvent( event )

if (event.type == "applicationResume") then
    AdBuddiz.showAd()

  
   end
end
Runtime:addEventListener( "system", onSystemEvent )    ]]--
----конец блока реклама

 --AdBuddiz.showAd()


--local sprite = require("sprite")   ----добавить библиотеку для работы со спрайтами
local str = require("str")
--display.setStatusBar(display.HiddenStatusBar)  ----убрать статусбар

 require("background")    -----добавить мoдуль  заднего фоно

require("play")     -----добавить мoдуль  игры



































