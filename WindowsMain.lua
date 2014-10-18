scriptId = 'WindowsMain'
 --Specify OS for scripting dependencies format is either 'MacOS' or 'Windows'
platform = 'Windows' 
--platform = 'MacOS'
chromeOpen = false
currentAddress = ''
mControl = false
myo.debug("\n\n Connection Successful: Begin Script " .. scriptId)  --my.debug() prints to console
rollDefault = nil

function onPeriodic()
	
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

function onPoseEdge(pose, edge)
	if pose == 'fist' and platform == 'Windows' and chromeOpen == false then
		openChromeWin() 
	end
	if pose == 'fist' and platform == 'MacOS' and chromeOpen == false then
		openChromeMac() 
	end
	if pose == 'fingersSpread' and chromeOpen == true and currentAddress == '' and  platform == 'Windows' then
		navNetflixWin()
	end
	if pose == 'fingersSpread' and chromeOpen == true and currentAddress == '' and platform == 'MacOS' then
		navNetflixMac()
	end
	if pose == 'thumbToPinky' and chromeOpen == true and currentAddress == 'www.netflix.com' and platform == 'Windows' then
		toggleMouse()
	end
	
	if pose == 'fingersSpread' and chromeOpen == true and currentAddress == 'www.netflix.com' and platform == 'Windows' then
		mouseClick()
	end
end

function openChromeWin()
    myo.debug('Begin openChrome()')
    chromeOpen = true
    
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
    wait(600)
   
    myo.debug('End openChrome()')
end

function openChromeMac()
    myo.debug('openChrome Mac version')
    chromeOpen = true
    
    myo.keyboard("space", "press", "command")
    wait(600)
    myo.keyboard('backspace', 'press')
    myo.keyboard('backspace', 'press')
    wait(600)
    letters = {'g', 'o','o', 'g', 'l', 'e', 'space', 'c', 'h', 'r', 'o', 'm', 'e'}
    i = 1
    while letters[i] ~= nil do
        myo.keyboard(letters[i], "press")
        i = i + 1
    end

    wait(100)

    -- myo.debug('openChrome | About to press RETURN')
    myo.keyboard("return", "press")
    
     wait(600)
    -- -- myo.debug('openChrome | Return Pressed!')
end

--focus search bar alt + d
function navNetflixWin()
	myo.debug('Begin navNetflixWin()')
	myo.keyboard('d', "press", "alt") --focus on address bar
	
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
    wait(600)
    
    myo.debug('end navNetflixWin()')
end

function navNetflixMac()
	myo.debug('Begin navNetflixWin()')
	myo.keyboard('l', "press", "command") --focus on address bar
	
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
    
    currentAddress = 'www.netflix.com'
    wait(600)
    
    myo.debug('end navNetflixWin()')
end

function toggleMouse()
	mControl = not mControl	
	myo.controlMouse(mControl)
	
	if myo.mouseControlEnabled() then
		myo.debug("mouse control is true")
	else
		myo.debug("mouse control is false")
	end
	myo.vibrate("short")
	
end

function mouseClick()
	myo.mouse("left", "click")
	myo.mouse("left", "click")
	myo.debug("click called")
end


function wait(millis) --guarantee wait of longer or equal than time given
    startTime = myo.getTimeMilliseconds()
    
    while myo.getTimeMilliseconds() - startTime < millis do
    end
end
