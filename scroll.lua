scriptId = 'com.thalmic.dubhacks.scrolldemo'

myo.controlMouse(enabled)

scrolling = false
myo.controlMouse(true)
rollDefault = nil

function onPoseEdge(pose, edge)
	if pose == 'fist' and edge == 'on' then
		scrolling = true
		myo.vibrate('short')
		myo.controlMouse(false)
	elseif pose == 'fingersSpread' and edge == 'on' and scrolling then	
		scrolling = false
		rollDefault = nil
		myo.vibrate('short')
		myo.controlMouse(true)
	end
end

function onPeriodic()
	if scrolling then
		if rollDefault == nil then
			sampleRoll()
		end
		-- the user is about to start turning
		-- if current roll is greater than default scroll up
		myo.debug(myo.getRoll() - rollDefault)
		if (myo.getRoll() - rollDefault) > 0.3 then
			myo.keyboard('down_arrow', 'press')
		elseif (myo.getRoll() - rollDefault) < -0.3 then
			myo.keyboard('up_arrow', 'press')
		end
	end
end

function onForegroundWindowChange(app, title)
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
    return true
end

function activeAppName()
    return "painter"
end

function onActiveChange(isActive)
    myo.debug("onActiveChange")
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

function wait(millis) --guarantee wait of longer or equal than time given
    startTime = myo.getTimeMilliseconds()
    
    while myo.getTimeMilliseconds() - startTime < millis do
    end
end