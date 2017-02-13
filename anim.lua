--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:8835124e4b656d3db968c5516d22a09a:6c1f7ba5afc42abbe41c45cdc4e2ab20:11a46df5cc134d2aeebc767572eea8a0$
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
            -- 01
            x=410,
            y=2,
            width=73,
            height=198,

            sourceX = 20,
            sourceY = 2,
            sourceWidth = 97,
            sourceHeight = 202
        },
        {
            -- 02
            x=877,
            y=2,
            width=70,
            height=193,

            sourceX = 27,
            sourceY = 7,
            sourceWidth = 97,
            sourceHeight = 202
        },
        {
            -- 03
            x=557,
            y=2,
            width=78,
            height=197,

            sourceX = 17,
            sourceY = 3,
            sourceWidth = 97,
            sourceHeight = 202
        },
        {
            -- 04
            x=2,
            y=2,
            width=82,
            height=200,

            sourceX = 10,
            sourceY = 1,
            sourceWidth = 97,
            sourceHeight = 202
        },
        {
            -- 05
            x=86,
            y=2,
            width=82,
            height=200,

            sourceX = 7,
            sourceY = 1,
            sourceWidth = 97,
            sourceHeight = 202
        },
        {
            -- 06
            x=170,
            y=2,
            width=82,
            height=199,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 97,
            sourceHeight = 202
        },
        {
            -- 07
            x=485,
            y=2,
            width=70,
            height=198,

            sourceX = 11,
            sourceY = 2,
            sourceWidth = 97,
            sourceHeight = 202
        },
        {
            -- 08
            x=949,
            y=2,
            width=70,
            height=193,

            sourceX = 16,
            sourceY = 7,
            sourceWidth = 97,
            sourceHeight = 202
        },
        {
            -- 09
            x=804,
            y=2,
            width=71,
            height=196,

            sourceX = 16,
            sourceY = 5,
            sourceWidth = 97,
            sourceHeight = 202
        },
        {
            -- 10
            x=254,
            y=2,
            width=75,
            height=199,

            sourceX = 13,
            sourceY = 2,
            sourceWidth = 97,
            sourceHeight = 202
        },
        {
            -- 11
            x=331,
            y=2,
            width=77,
            height=198,

            sourceX = 12,
            sourceY = 3,
            sourceWidth = 97,
            sourceHeight = 202
        },
        {
            -- 12
            x=637,
            y=2,
            width=78,
            height=197,

            sourceX = 9,
            sourceY = 4,
            sourceWidth = 97,
            sourceHeight = 202
        },
        {
            -- 13
            x=717,
            y=2,
            width=85,
            height=196,

            sourceX = 6,
            sourceY = 5,
            sourceWidth = 97,
            sourceHeight = 202
        },
    },
    
    sheetContentWidth = 1021,
    sheetContentHeight = 204
}

SheetInfo.frameIndex =
{

    ["01"] = 1,
    ["02"] = 2,
    ["03"] = 3,
    ["04"] = 4,
    ["05"] = 5,
    ["06"] = 6,
    ["07"] = 7,
    ["08"] = 8,
    ["09"] = 9,
    ["10"] = 10,
    ["11"] = 11,
    ["12"] = 12,
    ["13"] = 13,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
