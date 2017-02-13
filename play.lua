--
-- Project: bg0.png
-- Description: 
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2014 . All Rights Reserved.
-- 




-----level  = {red greem blue} если уровень easy level={red green blue gray yelow} если уровень hard

----level={"red", "green", "blue", "gray", "yelow"} 

------ 24 skin
local function onSystemEvent( event )

if ( event.type == "applicationOpen" ) then
    AdBuddiz.showAd()

  
   end
end
Runtime:addEventListener( "system", onSystemEvent )
level={} 
for x=1,9,1 do
level[x]="shet"..x
end


--->рисуем игровое поле
razmerKletki=70
mejduKletok=2
xKletok=8
yKletok=10
GameScore=0
HiScore =0
song=1

songPu = audio.loadSound("pu.wav")
songFit = audio.loadSound("fit.wav")
songCok = audio.loadSound("cok.wav")




local filePath = system.pathForFile( "bubleboo.hs", system.DocumentsDirectory )

-- io.open opens a file at filePath. returns nil if no file found
--
local file = io.open( filePath, "r" )
if file then
	-- read all contents of file into a string
	
 dataStr = file:read( "*a" )
	local datavars = str.split( dataStr, ",")
	
HiScore = tonumber(datavars[1])
	song=tonumber(datavars[2])
	
io.close( file )

else
	
	-- create file b/c it doesn't exist yet
	file = io.open( filePath, "w" )
	file:write( HiScore..","..song)
	
io.close( file )

end



local function ScreenXY( xpo,ypo)       ---возвращает экранные координаты по координатам игрового поля 
      return (razmerKletki+mejduKletok)*(xpo-1)+((display.viewableContentWidth-(mejduKletok+razmerKletki)*xKletok)/2),  (razmerKletki+mejduKletok)*(ypo-1)+((display.viewableContentHeight-(mejduKletok+razmerKletki)*yKletok)/2)-35
end	
	    

	    
	
	
	
	
	
	
	local objDestroer = function( obj )
        obj:removeSelf()
end    
	    
	    
	    
	    
	    
	
local Score = display.newText("Score:"..GameScore, 0, 30, native.systemFontBold,  75 )     
 Score:setFillColor(color(255, 255, 255))
  anchor.TopLeft( Score)
 local Score2 = display.newText("Hi:"..HiScore, 460, 40, native.systemFontBold, 40 )     
 Score2:setFillColor(color(255, 255, 255))
 anchor.TopLeft( Score2)










 
local function printscore (upscore)    -----------показывает набранные очки , эвент?
	      
        if upscore>0 then
        	  upscore=upscore+upscore-1
        GameScore=GameScore+upscore
        
        	upScoreTxt= display.newText("+"..upscore, scrX, scrY, native.systemFontBold, 50 )
        		upScoreTxt:setFillColor(color(255, 2, 35))
    	transition.to( upScoreTxt, { time=2500, alpha=0, x=scrX, y=(scrY-50), onComplete=objDestroer} )
    	
end	
if GameScore>HiScore then
	HiScore=GameScore
	Score2.text = "Hi:"..HiScore
	local filePath = system.pathForFile( "bubleboo.hs", system.DocumentsDirectory )
	file = io.open( filePath, "w" )
	file:write( HiScore..","..song)
	
io.close( file )

	
end
Score.text = "Score:"..GameScore

        	
       
end
    
	                          
--- gameField -таблица игрового поля nil - не играющая клетка, object.newRect - пустая клетка, ?? object.newImage - играющая фишка?? 
---gameField [x][y] .typeKletki вспопогательная переменная pusto не играет, plitka пустое поле, red green blue gray yelow фишки
---gameField [x][y] .posex  и .posey  координаты на игровом поле

gameField = {}

for x=1,xKletok,1 do
	gameField[x]={}
	
	for y=1,yKletok,1 do
		scrX, scrY = ScreenXY( x,y)
		gameField [x][y]=  display.newRect(scrX, scrY , razmerKletki, razmerKletki )
anchor.TopLeft( gameField [x][y] )
	gameField [x][y]:setFillColor( color(28, 28, 28),0.6)
		gameField [x][y].typeKletki="plitka"
		gameField [x][y].posex=x
		gameField [x][y].posey=y
		
	end
end

------------------------------------------------------------> игровое поле нарисовано

creditsShow=0


local function onTouch( event )

		
	local t = event.target


	local phase = event.phase
	if "began" == phase then
		-- Make target the top-most object
		local parent = t.parent
		parent:insert( t )
		
		
			-- выделить задействованную  фишку 
	
		fishkaLightSet = display.newImage( "light.png")
		fishkaLightSet.x = t.x
		fishkaLightSet.y = t.y
		
		fishkaLight = display.newRect(0, 0 , 0, 0 )
		fishkaLight.x = t.x
		fishkaLight.y = t.y
		
		
		display.getCurrentStage():setFocus( t )

		-- Spurious events can be sent to the target, e.g. the user presses 
		-- elsewhere on the screen and then moves the finger over the target.
		-- To prevent this, we add this flag. Only when it's true will "move"
		-- events be sent to the target.
		t.isFocus = true
	
t.xmove=0
t.ymove=0

		-- Store initial position
		t.x0 = event.x - t.x
		t.y0 = event.y - t.y
	elseif t.isFocus then
		if "moved" == phase then
			-- Make object move (we subtract t.x0,t.y0 so that moves are
			-- relative to initial grab point, rather than object "snapping").

			t.xmove=t.xmove +(fishkaLight.x - event.x) 
			t.ymove=t.ymove +(fishkaLight.y - event.y) 

			
	--		print("t.xmove="..t.xmove.."  t.ymove="..t.ymove)
			
--print (">event.y = "..event.y.." >t.y= "..t.y.." >t.y0= "..t.y0 )
--print (">event.x = "..event.x.." >t.x= "..t.x.." >t.x0= "..t.x0 )
	i=t.posex
	u=t.posey
	fishka=t.typeKletki
	upScore=0
		if math.abs(t.xmove) > math.abs(t.ymove)  then 
			
			if t.xmove < -300 then
	----------------------------------			print ("right")
				
			
				while i< xKletok  do
					
					
					if gameField [i+1][u].typeKletki == t.typeKletki then  
						gameField [i+1][u]:removeSelf()
						audio.play(songPu)
						gameField [i+1][u].typeKletki="plitka"
		gameField [i+1][u].posex=i+1
		gameField [i+1][u].posey=u
						
						
						
						upScore=upScore+1
	
		
				
				elseif  gameField [i+1][u].typeKletki ~= "plitka" then 
						
						
					break
					
	
						
					end	
					i=i+1
				end
			
			
				display.getCurrentStage():setFocus( nil )
			t.isFocus = false
			
			ii=t.posex
			uu=t.posey
			iitx=t.x
			iity=t.y
				t:removeSelf()
				gameField [ii][uu].typeKletki="plitka"
		gameField [ii][uu].posex=ii
		gameField [ii][uu].posey=uu
			
				
						gameField [i][u] = display.newImageRect( fishka..".png",razmerKletki,razmerKletki)
	gameField  [i][u] .typeKletki=fishka
	scrX, scrY = ScreenXY( i,u)
	
gameField [i][u] .x=iitx
						gameField [i][u] .y=iity
	fishkaLight:removeSelf()
	fishkaLightSet:removeSelf()
	transition.to( gameField [i][u], { time=250,  x=scrX+(razmerKletki+mejduKletok)/2, y=(scrY+(razmerKletki+mejduKletok)/2)} )
	audio.play(songFit)
	gameField [i][u] .posex=i
		gameField [i][u]  .posey=u
	gameField [i][u]:addEventListener( "touch", onTouch )
	

	printscore(upScore)
	
	
	local xRand=math.random (xKletok)
local yRand=math.random (yKletok)
local fishkaRand=level[math.random (#level )]
if gameField [xRand][yRand] .typeKletki=="plitka" then
	gameField [xRand][yRand] = display.newImageRect( fishkaRand..".png", razmerKletki,razmerKletki)
	gameField [xRand][yRand] .typeKletki=fishkaRand
	scrX, scrY = ScreenXY( xRand,yRand)
	gameField [xRand][yRand].x=scrX+(razmerKletki+mejduKletok)/2
	gameField [xRand][yRand].y=scrY+(razmerKletki+mejduKletok)/2
	gameField [xRand][yRand] .posex=xRand
		gameField [xRand][yRand] .posey=yRand
	gameField [xRand][yRand]:addEventListener( "touch", onTouch )
end
	
	
	
	return true			
			end	
			
			if t.xmove > 300 then
	----------------------------------------------------------------------			print ("left")
	
				while i>1  do
					
					
					if gameField [i-1][u].typeKletki == t.typeKletki then  
						gameField [i-1][u]:removeSelf()
						audio.play(songPu)
						gameField [i-1][u].typeKletki="plitka"
		gameField [i-1][u].posex=i-1
		gameField [i-1][u].posey=u
						
						
						
						upScore=upScore+1
	
		
				
				elseif  gameField [i-1][u].typeKletki ~= "plitka" then 
						
						
					break
					
	
						
					end	
					i=i-1
				end
			
			
				display.getCurrentStage():setFocus( nil )
			t.isFocus = false
			
			ii=t.posex
			uu=t.posey
			iitx=t.x
			iity=t.y
				t:removeSelf()
				gameField [ii][uu].typeKletki="plitka"
		gameField [ii][uu].posex=ii
		gameField [ii][uu].posey=uu
			
				
						gameField [i][u] = display.newImageRect( fishka..".png", razmerKletki,razmerKletki)
	gameField  [i][u] .typeKletki=fishka
	scrX, scrY = ScreenXY( i,u)
	
gameField [i][u] .x=iitx
						gameField [i][u] .y=iity
	fishkaLight:removeSelf()
	fishkaLightSet:removeSelf()
	transition.to( gameField [i][u], { time=250,  x=scrX+(razmerKletki+mejduKletok)/2, y=(scrY+(razmerKletki+mejduKletok)/2)} )
	audio.play(songFit)
	gameField [i][u] .posex=i
		gameField [i][u]  .posey=u
	gameField [i][u]:addEventListener( "touch", onTouch )
	

	printscore(upScore)
	
	local xRand=math.random (xKletok)
local yRand=math.random (yKletok)
local fishkaRand=level[math.random (#level )]
if gameField [xRand][yRand] .typeKletki=="plitka" then
	gameField [xRand][yRand] = display.newImageRect( fishkaRand..".png", razmerKletki, razmerKletki)
	gameField [xRand][yRand] .typeKletki=fishkaRand
	scrX, scrY = ScreenXY( xRand,yRand)
	gameField [xRand][yRand].x=scrX+(razmerKletki+mejduKletok)/2
	gameField [xRand][yRand].y=scrY+(razmerKletki+mejduKletok)/2
	gameField [xRand][yRand] .posex=xRand
		gameField [xRand][yRand] .posey=yRand
	gameField [xRand][yRand]:addEventListener( "touch", onTouch )
end
	
	
	
	return true
	
			end	
			
			
				
			
			
			
	t.x = event.x - t.x0
	fishkaLightSet.x=t.x		
		    else 
			   
			if t.ymove > 300 then
	--------------------------------------------------------------------			print ("up")
		
				while u> 1  do
					
					
					if gameField [i][u-1].typeKletki == t.typeKletki then  
						gameField [i][u-1]:removeSelf()
						audio.play(songPu)
						gameField [i][u-1].typeKletki="plitka"
		gameField [i][u-1].posex=i
		gameField [i][u-1].posey=u-1
						
						
						
						upScore=upScore+1
		
		
				
				elseif  gameField [i][u-1].typeKletki ~= "plitka" then 
						
						
					break
					
	
						
					end	
					u=u-1
				end
			
			
					display.getCurrentStage():setFocus( nil )
			t.isFocus = false
			
			ii=t.posex
			uu=t.posey
			iitx=t.x
			iity=t.y
				t:removeSelf()
				gameField [ii][uu].typeKletki="plitka"
		gameField [ii][uu].posex=ii
		gameField [ii][uu].posey=uu
			
				
						gameField [i][u] = display.newImageRect( fishka..".png", razmerKletki,razmerKletki)
						
	gameField  [i][u] .typeKletki=fishka
	scrX, scrY = ScreenXY( i,u)
	
gameField [i][u] .x=iitx
						gameField [i][u] .y=iity
	fishkaLight:removeSelf()
	fishkaLightSet:removeSelf()
	transition.to( gameField [i][u], { time=250,  x=scrX+(razmerKletki+mejduKletok)/2, y=(scrY+(razmerKletki+mejduKletok)/2)} )
	audio.play(songFit)
	gameField [i][u] .posex=i
		gameField [i][u]  .posey=u
	gameField [i][u]:addEventListener( "touch", onTouch )
	

	printscore(upScore)
	
	local xRand=math.random (xKletok)
local yRand=math.random (yKletok)
local fishkaRand=level[math.random (#level )]
if gameField [xRand][yRand] .typeKletki=="plitka" then
	gameField [xRand][yRand] = display.newImageRect( fishkaRand..".png",razmerKletki,razmerKletki)
	gameField [xRand][yRand] .typeKletki=fishkaRand
	scrX, scrY = ScreenXY( xRand,yRand)
	gameField [xRand][yRand].x=scrX+(razmerKletki+mejduKletok)/2
	gameField [xRand][yRand].y=scrY+(razmerKletki+mejduKletok)/2
	gameField [xRand][yRand] .posex=xRand
		gameField [xRand][yRand] .posey=yRand
	gameField [xRand][yRand]:addEventListener( "touch", onTouch )
end
	
	
	
	return true	
	
	
			end	
			if t.ymove < -300 then
	-------------------------------------------------------------------------			print ("down")
	
				while u< yKletok  do
					
					
					if gameField [i][u+1].typeKletki == t.typeKletki then  
						gameField [i][u+1]:removeSelf()
						audio.play(songPu)
						gameField [i][u+1].typeKletki="plitka"
		gameField [i][u+1].posex=i
		gameField [i][u+1].posey=u+1
						
						
						
						upScore=upScore+1
		
		
				
				elseif  gameField [i][u+1].typeKletki ~= "plitka" then 
						
						
					break
					
	
						
					end	
					u=u+1
				end
			
			
			display.getCurrentStage():setFocus( nil )
			t.isFocus = false
			
			ii=t.posex
			uu=t.posey
			iitx=t.x
			iity=t.y
				t:removeSelf()
				gameField [ii][uu].typeKletki="plitka"
		gameField [ii][uu].posex=ii
		gameField [ii][uu].posey=uu
			
				
						gameField [i][u] = display.newImageRect( fishka..".png",razmerKletki,razmerKletki)
						
	gameField  [i][u] .typeKletki=fishka
	scrX, scrY = ScreenXY( i,u)
	
gameField [i][u] .x=iitx
						gameField [i][u] .y=iity
	fishkaLight:removeSelf()
	fishkaLightSet:removeSelf()
	transition.to( gameField [i][u], { time=250,  x=scrX+(razmerKletki+mejduKletok)/2, y=(scrY+(razmerKletki+mejduKletok)/2)} )
	audio.play(songFit)
	gameField [i][u] .posex=i
		gameField [i][u]  .posey=u
	gameField [i][u]:addEventListener( "touch", onTouch )
	

	printscore(upScore)
	
	local xRand=math.random (xKletok)
local yRand=math.random (yKletok)
local fishkaRand=level[math.random (#level )]
if gameField [xRand][yRand] .typeKletki=="plitka" then
	gameField [xRand][yRand] = display.newImageRect( fishkaRand..".png",razmerKletki,razmerKletki)
	gameField [xRand][yRand] .typeKletki=fishkaRand
	scrX, scrY = ScreenXY( xRand,yRand)
	gameField [xRand][yRand].x=scrX+(razmerKletki+mejduKletok)/2
	gameField [xRand][yRand].y=scrY+(razmerKletki+mejduKletok)/2
	gameField [xRand][yRand] .posex=xRand
		gameField [xRand][yRand] .posey=yRand
	gameField [xRand][yRand]:addEventListener( "touch", onTouch )
end
	
	
	return true	
			end	
			
			
   t.y = event.y - t.y0
	fishkaLightSet.y=t.y		
		
		end
			
		elseif "ended" == phase or "cancelled" == phase then
---- t:removeSelf()
			display.getCurrentStage():setFocus( nil )
			t.isFocus = false
			t.x=fishkaLight.x
			t.y=fishkaLight.y
			fishkaLightSet:removeSelf()
			fishkaLight:removeSelf()
				
		end
	end

				
	-- Important to return true. This tells the system that the event
	-- should not be propagated to listeners of any objects underneath.
	return true
end








local function randomBuble ()
	
local x=math.random (xKletok)
local y=math.random (yKletok)
local fishka=level[math.random (#level )]
if gameField [x][y] .typeKletki=="plitka" then
	gameField [x][y] = display.newImageRect( fishka..".png",razmerKletki,razmerKletki)
	gameField [x][y] .typeKletki=fishka
	scrX, scrY = ScreenXY( x,y)
	gameField [x][y].x=scrX+(razmerKletki+mejduKletok)/2
	gameField [x][y].y=scrY+(razmerKletki+mejduKletok)/2
	gameField [x][y] .posex=x
		gameField [x][y] .posey=y
	gameField [x][y]:addEventListener( "touch", onTouch )
	
end	
end	








	
--заполнение игрового поля при старте 20%
for x=1,(xKletok*yKletok)/4,1 do
randomBuble ()
end





-----   музыка


soundtrack = audio.loadStream("track.mp3")

--if song == 1   then
--backgroundMusicChannel = audio.play(soundtrack, {loops = -1})
--end
 if song==2 then
           
	songPu = audio.loadSound("pu.wav")
songFit = audio.loadSound("fit.wav")
audio.stop (  )
--textMute.text="SILENT"
              elseif song==0 then
          
audio.stop (  )
       
	songPu = audio.loadSound("silence.wav")
songFit = audio.loadSound("silence.wav")
--textMute.text="SONG ON"
audio.stop (  )
               elseif song==1 then
            
	songPu = audio.loadSound("pu.wav")
songFit = audio.loadSound("fit.wav")
backgroundMusicChannel = audio.play(soundtrack, {loops = -1})
--textMute.text="SONG OFF"
              end



-----  менюхи

    



local function creditsDestroy (event)
	
		creditsViewRec:removeSelf()
			creditsViewTxt:removeSelf()
			 creditsViewImg:removeSelf()
			 NewGameYes:removeSelf()
creditsShow=0
	

end




              
    local function NewGameStart (event)      
    	
    	  GameScore=0
               printscore (0)
                    
   for x=1,xKletok,1 do
		for y=1,yKletok,1 do
		if  gameField [x][y].typeKletki ~="plitka" then
		gameField [x][y]:removeEventListener( "touch", onTouch )
		gameField [x][y]:removeSelf()
		gameField [x][y].typeKletki="plitka"
		gameField [x][y].posex=x
		gameField [x][y].posey=y
		end
	end
end
               
          for x=1,(xKletok*yKletok)/4,1 do
randomBuble ()
end     

    --	 creditsDestroy()
    end




local function creditsView(txt)
	creditsShow=1
 scrX, scrY = ScreenXY( 1,1)
 
 
		creditsViewRec = display.newRect( scrX,  scrY  , (razmerKletki+mejduKletok)*xKletok, (razmerKletki+mejduKletok)*yKletok )
		creditsViewRec:setFillColor( color(15, 15, 15),0.8)
		anchor.TopLeft(creditsViewRec)
		creditsViewRec:addEventListener("touch",  creditsDestroy)
		creditsViewTxt = display.newText(  txt, display.viewableContentWidth*0.5, display.viewableContentHeight*0.5+70,native.systemFontBold,37 )
anchor.Center(creditsViewTxt )
creditsViewImg = display.newImage( "logo.png", display.viewableContentWidth*0.5,scrY+130)
 anchor.Center(creditsViewImg)
 NewGameYes=display.newText(  "", display.viewableContentWidth*0.5, display.viewableContentHeight*0.5+70,native.systemFontBold,57 )
   if txt==NewGameTxt then
   
   NewGameYes.text="Yes!"
   NewGameYes:addEventListener("touch",  NewGameStart)
   end
   
end




  
    
    
    
    
    
---кнопки

NewGameTxt="Start new GAME?\n\n\n\n\n      No, thanks."

local function NewGame (event)
        if event.phase == "began" then
        	audio.play(songCok)
                --делаем что-нибудь во время фазы "began"
              buttonNewGame:setFillColor( color(255, 206, 26),0.7)
               if creditsShow==0 then creditsView(NewGameTxt)  else creditsDestroy() end
        elseif event.phase == "moved" then
                --делаем что-нибудь во время фазы "moved"
             buttonNewGame:setFillColor(color( 15, 15, 15),0.7)
        elseif event.phase == "ended" then
                --делаем что-нибудь во время фазы "ended"
              buttonNewGame:setFillColor(color( 15, 15, 15),0.7)
            
        end
end





local function Credits (event)
        if event.phase == "began" then
        	audio.play(songCok)
                --делаем что-нибудь во время фазы "began"
              buttonCredits:setFillColor(color(  255, 206, 26),0.7)
              if creditsShow==0 then creditsView("Develop:\nVadim Lyakh\nvadim.lyakh@gmail.com\n\nMusic:\nBurya & Vestnik\nSummer memories\nhttp://promodj.com/buryavestnik ")  else creditsDestroy() end
              
              
        elseif event.phase == "moved" then
                --делаем что-нибудь во время фазы "moved"
            buttonCredits:setFillColor( color( 15, 15, 15),0.7)
        elseif event.phase == "ended" then
                --делаем что-нибудь во время фазы "ended"
              buttonCredits:setFillColor( color( 15, 15, 15),0.7)
        end
end


local function Mute (event)
      if event.phase == "began" then
                --делаем что-нибудь во время фазы "began"
                audio.play(songCok)
                print(song)
              buttonMute:setFillColor( color(255, 206, 26),0.7)
              if song==1 then
              song=2
              file = io.open( filePath, "w" )
	file:write( HiScore..","..song)
	io.close( file )
	songPu = audio.loadSound("pu.wav")
songFit = audio.loadSound("fit.wav")
audio.stop (  )
--textMute.text="SILENT"
              elseif song==2 then
              song=0
              file = io.open( filePath, "w" )
	file:write( HiScore..","..song)
	io.close( file )
audio.stop (  )
                          
              file = io.open( filePath, "w" )
	file:write( HiScore..","..song)
	io.close( file )
	songPu = audio.loadSound("silence.wav")
songFit = audio.loadSound("silence.wav")
--textMute.text="SONG ON"
audio.stop (  )
               elseif song==0 then
              song=1
              file = io.open( filePath, "w" )
	file:write( HiScore..","..song)
	io.close( file )

                          
              file = io.open( filePath, "w" )
	file:write( HiScore..","..song)
	io.close( file )
	songPu = audio.loadSound("pu.wav")
songFit = audio.loadSound("fit.wav")
backgroundMusicChannel = audio.play(soundtrack, {loops = -1})
--textMute.text="SONG OFF"
              end
              
        elseif event.phase == "moved" then
                --делаем что-нибудь во время фазы "moved"
            buttonMute:setFillColor( color(15, 15, 15),0.7)
        elseif event.phase == "ended" then
                --делаем что-нибудь во время фазы "ended"
              buttonMute:setFillColor( color(15, 15, 15),0.7)
        end
end




----рисуем кнопки

scrX, scrY = ScreenXY( 1,yKletok+1)
 buttonNewGame = display.newRect(scrX+razmerKletki, scrY+(razmerKletki/2) , razmerKletki*2+mejduKletok, razmerKletki/1.5 )
		buttonNewGame:setFillColor( color(15, 15, 15),0.7)
		anchor.Center( buttonNewGame)
local textNewGame = display.newText("NEW",scrX+razmerKletki,scrY+(razmerKletki/2),native.systemFontBold,27)
buttonNewGame:addEventListener("touch",  NewGame)
anchor.Center( textNewGame)
 buttonCredits = display.newRect(scrX+((razmerKletki+mejduKletok)*3)+razmerKletki, scrY+(razmerKletki/2) , razmerKletki*2, razmerKletki/1.5 )
		buttonCredits:setFillColor( color(15, 15, 15),0.7)
		anchor.Center(buttonCredits)
local textCredits = display.newText("CREDIT",scrX+((razmerKletki+mejduKletok)*3)+razmerKletki,scrY+(razmerKletki/2),native.systemFontBold,27)
buttonCredits:addEventListener("touch",  Credits)
anchor.Center(textCredits)
buttonMute = display.newRect(scrX+((razmerKletki+mejduKletok)*6)+razmerKletki, scrY+(razmerKletki/2) , razmerKletki*2, razmerKletki/1.5 )
		buttonMute:setFillColor( color(15, 15, 15),0.7)
		anchor.Center(buttonMute)
 textMute = display.newText("MUTE",scrX+((razmerKletki+mejduKletok)*6)+razmerKletki,scrY+(razmerKletki/2),native.systemFontBold,27)
buttonMute:addEventListener("touch",  Mute)
anchor.Center(textMute)



function Egg7Detection(event)
	
	local sum=1
	local typeKletki=gameField [sum][yKletok].typeKletki

	while typeKletki~="plitka" and typeKletki==gameField [sum][yKletok].typeKletki and sum<xKletok do
	sum=sum+1
	end
	if sum==xKletok then
		
		------
		for  i=1,xKletok,1 do
		
	
			transition.to( gameField [i][yKletok], { time=1000, alpha=0, x=gameField [i][yKletok].x, y=(gameField [i][yKletok].y-100), onComplete=objDestroer} )
	--	gameField [i][yKletok]:removeSelf()
						audio.play(songPu)
						gameField [i][yKletok].typeKletki="plitka"
		gameField [i][yKletok].posex=i
		gameField [i][yKletok].posey=yKletok
						
		end
		printscore(25.5)
		
	end
	
end



Runtime:addEventListener("enterFrame",Egg7Detection)



function Egg13(event)
	sprite:removeSelf()
	audio.stop( backgroundMusicChannel2)
	gameField [4][5]:removeSelf()
	gameField [5][5]:removeSelf()
	gameField [4][6]:removeSelf()
	gameField [5][6]:removeSelf()
	
	audio.play(songPu)
	gameField [4][5].posex=4
	gameField [5][5].posex=5
	gameField [4][6].posex=4
	gameField [5][6].posex=5
	
	gameField [4][5].posey=5
	gameField [5][5].posey=5
	gameField [4][6].posey=6
	gameField [5][6].posey=6
	
	gameField [4][5].typeKletki="plitka"
	gameField [5][5].typeKletki="plitka"
	gameField [4][6].typeKletki="plitka"
	gameField [5][6].typeKletki="plitka"
		printscore(50.5)
		
	
	
end




function Egg13Detection(event)

if gameField [4][5].typeKletki~="plitka" and gameField [4][5].typeKletki==gameField [5][5].typeKletki and  gameField [4][5].typeKletki==gameField [4][6].typeKletki and  gameField [4][5].typeKletki==gameField [5][6].typeKletki  then
Runtime:removeEventListener( "enterFrame", Egg13Detection)
local soundtrack2 = audio.loadStream("drums.wav")
 backgroundMusicChannel2 = audio.play(soundtrack2, {loops = -1})

 local sheetInfo = require("anim")
 local myImageSheet = graphics.newImageSheet( "anim.png", sheetInfo:getSheet() )
--local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )

  local sequenceData = {
    { name = "normalRun", start=1, count=13, time=800 },

  }
 
sprite = display.newSprite( myImageSheet, sequenceData )
sprite.x = display.contentWidth/2  --center the sprite horizontally
sprite.y = display.contentHeight/2  --center the sprite vertically
sprite:addEventListener("touch",  Egg13)
 	
sprite:play()
end

end


Runtime:addEventListener("enterFrame",Egg13Detection)

















