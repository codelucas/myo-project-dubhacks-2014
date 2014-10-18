scriptId = 'com.thalmic.jprange.displayinfo'
 --Specify OS for scripting dependencies format is either 'MacOS' or 'Windows'
platform = 'Windows' 
--platform = 'MacOS'
listen = true
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
	if pose == 'fist' and platform == 'Windows' and listen then
		openChromeWin() 
	end
	if pose == 'fist' and platform == 'MacOS' and listen then
		openChromeMac() 
	end
end

function runNetflix()
	myo.keyboard('alt', 'down')
	myo.keyboard('d', 'down')
	myo.keyboard('alt', 'up')
	myo.keyboard('d', 'up')
	runCmd = "www.netflix.com"
    for c in runCmd2:gmatch"." do
    	 myo.keyboard(c, "press") 
	end
	myo.keyboard('return', "press")
end

function openChromeWin()
    myo.debug('Begin openChrome()')
    listen = false
    
    myo.keyboard('left_win', "press")
    wait(600)
    
    myo.debug('Type Run')
    runCmd = "run"
    for c in runCmd:gmatch"." do
    	 myo.keyboard(c, "press") 
	end
    myo.keyboard('return', "press")
    wait(600)
    
    myo.debug('Type Chrome')
    runChrm = "chrome"
    for c in runChrm:gmatch"." do
    	 myo.keyboard(c, "press") 
	end
      myo.keyboard('return', "press")
    wait(600)
   
    myo.debug('End openChrome()')
end

function openChromeMac()
    -- myo.debug('openChrome | attempting to write space-command')
    myo.keyboard("space", "press", "command")
    wait(100)
    myo.keyboard('backspace', 'press')
    myo.keyboard('backspace', 'press')
    wait(100)
    letters = {'g', 'o','o', 'g', 'l', 'e', 'space', 'c', 'h', 'r', 'o', 'm', 'e'}
    i = 1
    while letters[i] ~= nil do
        myo.keyboard(letters[i], "press")
        i = i + 1
    end

    wait(200)

    -- myo.debug('openChrome | About to press RETURN')
    myo.keyboard("return", "press")
    -- -- myo.debug('openChrome | Return Pressed!')
end


function wait(millis) --guarantee wait of longer or equal than time given
    startTime = myo.getTimeMilliseconds()
    
    while myo.getTimeMilliseconds() - startTime < millis do
    end
end
