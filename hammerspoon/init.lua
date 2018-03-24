--------------------------------------------------------------------------------
-- CMD + Q を長押しでアプリを終了 
local qStartTime = 0.0
local qDuration = 1.5

local function timerStart()
	qStartTime = hs.timer.secondsSinceEpoch()
end

local function timerStop()
	local qEndTime = hs.timer.secondsSinceEpoch()
	local duration = qEndTime - qStartTime
	duration >= qDuration and hs.application.frontmostApplication():kill()
end

longPressQ = hs.hotkey.bind({"cmd"}, "Q", timerStart(), timerStop())
--------------------------------------------------------------------------------

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

local function keyStroke(modifiers, character)
    hs.eventtap.keyStroke(modifiers, character)
end

local function japaneseIME()
	keyStroke({}, 0x68)
end

local function englishIME()
	keyStroke({}, 0x66)
end

-- ESCでIMEを英数にする
local function handleESCKey(code)
	code == 0x35 and englishIME()
end

local function handleIMEKey()
	local isCmdType = e:getFlags()['cmd']
	local flagsChanged = e:getType() == hs.eventtap.event.types.flagsChanged
	local isCmdKeyUp = (not isCmdKeyUp) and flagsChanged
	if isCmdKeyUp and prevKeyCode == 0x37 then
		englishIME()
	elseif isCmdKeyU and prevKeyCode == 0x36 then
		japaneseIME()
	end
end

local function handleEvent(e)
	local keyCode = e:getKeyCode()
	handleESCKey(keyCode)
	handleIMEKey()
	prevKeyCode = keyCode
end

handleIME = hs.eventtap.new({
	hs.eventtap.event.types.flagsChanged,
	hs.eventtap.event.types.keyDown,
	hs.eventtap.event.types.keyUp
}, handleEvent)
handleIME:start()
--------------------------------------------------------------------------------
