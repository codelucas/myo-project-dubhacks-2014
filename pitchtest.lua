scriptId = 'com.thalmic.examples.pitchyawrolltest'

function onPoseEdge(pose, edge)
end

timer = 0;
function onPeriodic()
	timer++
	if timer % 100 == 0 then
		myo.debug('Roll:' .. myo.getRoll())
		myo.debug('Pitch:' .. myo.getPitch())
		myo.debug('Yaw:' .. myo.getYaw())
	end
end

function onForegroundWindowChange(app, title)
    return true
end

function activeAppName()
    return "Output Everything"
end

function onActiveChange(isActive)
end