scriptId = 'WindowsMain'
 --Specify OS for scripting dependencies format is either 'MacOS' or 'Windows'
platform = 'Windows' 
--platform = 'MacOS'
chromeOpen = false
currentAddress = ''
mControl = false
state = ''

myo.debug("\n\n Connection Successful: Begin Script " .. scriptId)  --my.debug() prints to console

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
	if pose == 'fist' and chromeOpen == false then
		openChromeWin() 
	end
	if pose == 'fingersSpread' and chromeOpen == true and currentAddress == '' then
		navNetflixWin()
	end
	
	if pose == 'thumbToPinky' and edge == 'on' and chromeOpen == true and currentAddress == 'www.netflix.com' and mControl == false then
		mouseOn()
	end
	if pose == 'fingersSpread' and mControl == true and chromeOpen == true and currentAddress == 'www.netflix.com' then
		mouseOff()
	end
	if pose == 'fingersSpread' and chromeOpen == true and currentAddress == 'www.netflix.com' and mControl == false  then
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
    
    myo.keyboard('f11', "press")
    state = 'NetflixNavigation'
    
    
end

function mouseOn()
	mControl = true
	myo.controlMouse(mControl)
		myo.debug("mouse control is on")
	state = 'mouseOn'
	myo.vibrate("short")
	
end

function mouseOff()
	mControl = false
	myo.controlMouse(mControl)
		myo.debug("mouse control is off")
	state = 'mouseOff'
	myo.vibrate("short")
	wait(3500)
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

--cell 1 is address string, 2 is chromeopen boolean, 3 is state string
function statusCheck()
	statusArray = { currentAddress, chromeOpen, state }
	return statusArray
end
