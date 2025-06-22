package timer

import love2d_dll ".."
import "core:c"

startTime: f64 = 0
startTimer: f64

init :: proc () -> love2d_dll.bool4 {
	startTimer = getTimeRaw()
	return love2d_dll.timer_open_timer()
}

step :: proc () {
	love2d_dll.timer_step()
}

sleep :: proc (t: f32) {
	c_t: c.float = t
	love2d_dll.timer_sleep(c_t)
}

sleepByMaxFPS :: proc () {

}

getTimeRaw :: proc () -> f64 {
	out_time: c.double
	love2d_dll.timer_getTime(&out_time)
	return out_time
}

getTime :: proc () -> f64 {
	return getTimeRaw() - startTime
}

getDelta :: proc () -> f32 {
	out_delta: c.float
	love2d_dll.timer_getDelta(&out_delta)
	return out_delta
}

getFPS :: proc () -> f32 {
	out_fps: c.float
	love2d_dll.timer_getFPS(&out_fps)
	return out_fps
}

getAverageDelta :: proc () -> f32 {
	out_averagedelta: c.float
	love2d_dll.timer_getAverageDelta(&out_averagedelta)
	return out_averagedelta
}

isLimitMaxFPS :: proc () -> bool {
	return false
}
