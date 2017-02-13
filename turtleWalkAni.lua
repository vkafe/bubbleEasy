--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:395a2a8d7d0d0fcd88a10c6bcdf42e1f:037d492e107b68812da39ff511f9d67a:a345bff04bbb13954a499d1b5af7c31c$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- turtle0
            x=2,
            y=2,
            width=136,
            height=198,

            sourceX = 30,
            sourceY = 1,
            sourceWidth = 200,
            sourceHeight = 200
        },
        {
            -- turtle1
            x=140,
            y=2,
            width=129,
            height=194,

            sourceX = 37,
            sourceY = 1,
            sourceWidth = 200,
            sourceHeight = 200
        },
        {
            -- turtle2
            x=410,
            y=2,
            width=121,
            height=179,

            sourceX = 35,
            sourceY = 5,
            sourceWidth = 200,
            sourceHeight = 200
        },
        {
            -- turtle3
            x=271,
            y=2,
            width=137,
            height=180,

            sourceX = 31,
            sourceY = 20,
            sourceWidth = 200,
            sourceHeight = 200
        },
    },
    
    sheetContentWidth = 533,
    sheetContentHeight = 202
}

SheetInfo.frameIndex =
{

    ["turtle0"] = 1,
    ["turtle1"] = 2,
    ["turtle2"] = 3,
    ["turtle3"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
