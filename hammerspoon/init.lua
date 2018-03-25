--------------------------------------------------------------------------------
-- 右CMD単体押しでかな、左CMD単体押しで英数切り替え
--
--
-- 0x35 ESC
-- 0x68 かな
-- 0x66 英数
-- 0x37 Command(left)
-- 0x36 Command(right)
local prevKeyCode
local escape = 0x35
local leftCommand = 0x37
local rightCommand = 0x36
local eisuu = 0x66
local kana = 0x68

local function keyStroke(modifiers, character)
    hs.eventtap.keyStroke(modifiers, character)
end

local function jp()
    keyStroke({}, kana)
end

local function eng()
    keyStroke({}, eisuu)
end

local function handleEvent(e)
    local keyCode = e:getKeyCode()
    if keyCode == escape then
        eng()
    end


    local isCmdKeyUp = not(e:getFlags()['cmd']) and e:getType() == hs.eventtap.event.types.flagsChanged
    if isCmdKeyUp and prevKeyCode == leftCommand then
        eng()
    elseif isCmdKeyUp and prevKeyCode == rightCommand then
        jp()
    end

    prevKeyCode = keyCode
end

eventtap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, handleEvent)
eventtap:start()
--------------------------------------------------------------------------------
