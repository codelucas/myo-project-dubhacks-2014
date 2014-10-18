scriptId = 'WindowsMain'
 --Specify OS for scripting dependencies format is either 'MacOS' or 'Windows'
platform = 'Windows' 
--platform = 'MacOS'
chromeOpen = false
currentAddress = ''
mControl = false
--states: start, navigation, video
state = 'start'
--is user scrolling
scrolling = false
--gauge for scrolling
rollDefault = nil
fastForward = false
rewind = false
myo.debug("\n\n Connection Successful: Begin Script " .. scriptId)  --my.debug() prints to console

function onPeriodic()
	myo.debug(state)
	if state == 'navigation' and scrolling then
		if rollDefault == nil then
			sampleRoll()
		end
		-- the user is about to start turning
		-- if current roll is greater than default scroll up
		--myo.debug(myo.getRoll() - rollDefault)
		if (myo.getRoll() - rollDefault) > 0.3 then
			myo.keyboard('down_arrow', 'press')
		elseif (myo.getRoll() - rollDefault) < -0.3 then
			myo.keyboard('up_arrow', 'press')
		end
		if fastForward then
			myo.keyboard('left_shift', 'down')
			myo.keyboard('right_arrow', 'press')
			myo.keyboard('left_shift', 'up')
		elseif rewind then
			myo.keyboard('left_shift', 'down')
			myo.keyboard('left_arrow', 'press')
			myo.keyboard('left_shift', 'up')
		end
			
	end
end

function sampleRoll()
	myo.debug('sampling default roll')
	--for 1 sec sample the roll and create a continuous average updating default 
	rollSum = 0
	rollNum = 25
	for var = 0, rollNum - 1, 1 do
		rollSum = rollSum + myo.getRoll()
		wait(10)
	end
	rollDefault = rollSum / rollNum
	myo.debug('sampling default roll finished')
end

function onPoseEdge(pose, edge)
	myo.debug(pose)
	if pose == 'fist' and state == 'start' and not chromeOpen then
		openChromeWin() 
		chromeOpen = true
	end
	if pose == 'fingersSpread' and chromeOpen and currentAddress == '' then
		navNetflixWin()
		state = 'navigation'
	end
	if chromeOpen and currentAddress == 'www.netflix.com' and state == 'navigation' then
		if pose == 'fist' and edge == 'on' then
			scrolling = true
			myo.vibrate('short')
			myo.controlMouse(false)
		elseif pose == 'fingersSpread' and edge == 'on' then
			if scrolling then	
				scrolling = false
				fastForward = false
				rewind = false
				rollDefault = nil
				myo.vibrate('short')
				myo.controlMouse(true)
			end
		elseif pose == 'thumbToPinky' and edge == 'on' then 
			myo.mouse('left', 'click')  
		end
		if scrolling then
			if pose == 'waveOut' then
				fastForward = true
				myo.debug('fast forwarding')
			end
			if pose == 'waveIn' then
				rewind = true;
				myo.debug('rewinding')
			end
		end
	end
end

function openChromeWin()
    myo.debug('Begin openChrome()')
    
    myo.keyboard('left_win', "press")
    wait(600)
   
    runCmd = "run"
    for c in runCmd:gmatch"." do
    	 myo.keyboard(c, "press") 
	end
    myo.keyboard('return', "press")
    wait(600)
   
    runChrm = "chrome"
    for c in runChrm:gmatch"." do
    	 myo.keyboard(c, "press") 
	end
    myo.keyboard('return', "press")
    myo.vibrate("short")
    wait(300)
   
    myo.debug('End openChrome()')
end


function navNetflixWin()
	myo.debug('Begin navNetflixWin()')
	myo.keyboard('d', "press", "alt") --focus on address bar
	wait(200)
	firstP = "www"
	lastP = "com"
	runAddress = "netflix"
	for c in firstP:gmatch"." do
		myo.keyboard(c, "press")
	end
	myo.keyboard("period", "press")
	for c in runAddress:gmatch"." do
		myo.keyboard(c, "press")
	end
	myo.keyboard("period", "press")
	for c in lastP:gmatch"." do
		myo.keyboard(c, "press")
	end
	myo.keyboard('return', "press")
	wait(600)
	myo.vibrate("short")
	currentAddress = 'www.netflix.com'
	myo.controlMouse(true)
	wait(600)
	myo.debug('end navNetflixWin()')
end

-- function mouseOn()
	-- mControl = true
	-- myo.controlMouse(mControl)
		-- myo.debug("mouse control is on")
	-- state = 'mouseOn'
	-- myo.vibrate("short")
	
-- end

-- function mouseOff()
	-- mControl = false
	-- myo.controlMouse(mControl)
		-- myo.debug("mouse control is off")
	-- state = 'mouseOff'
	-- myo.vibrate("short")
	-- wait(3500)
-- end

-- function mouseClick()
	-- myo.mouse("left", "click")
	-- myo.mouse("left", "click")
	-- myo.debug("click called")
-- end


function wait(millis) --guarantee wait of longer or equal than time given
    startTime = myo.getTimeMilliseconds()
    
    while myo.getTimeMilliseconds() - startTime < millis do
    end
end

--cell 1 is address string, 2 is chromeopen boolean, 3 is state string
function statusCheck()
	statusArray = { currentAddress, chromeOpen, state }
	return statusArray
end

function onForegroundWindowChange(app, title)
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
    return true
end

function activeAppName()
    return 'Digital Handsurfing'
end

function onActiveChange(isActive)
    myo.debug("onActiveChange")
end
