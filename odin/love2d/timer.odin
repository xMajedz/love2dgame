package love2d

startTime: f64 = 0
startTimer: f64

TimerInit :: proc () -> bool
{
	startTimer = TimerGetTimeRaw()
	return cast(bool)timer_open_timer()
}

TimerStep :: proc ()
{
	timer_step()
}

TimerSleep :: proc (t: f32)
{
	c_t: f32 = t
	timer_sleep(c_t)
}

TimerSleepByMaxFPS :: proc ()
{

}

TimerGetTimeRaw :: proc () -> f64
{
	out_time: f64
	timer_getTime(&out_time)
	return out_time
}

TimerGetTime :: proc () -> f64 {
	return TimerGetTimeRaw() - startTime
}

TimerGetDelta :: proc () -> f32
{
	out_delta: f32
	timer_getDelta(&out_delta)
	return out_delta
}

TimerGetFPS :: proc () -> f32
{
	out_fps: f32
	timer_getFPS(&out_fps)
	return out_fps
}

TimerGetAverageDelta :: proc () -> f32
{
	out_averagedelta: f32
	timer_getAverageDelta(&out_averagedelta)
	return out_averagedelta
}

TimerIsLimitMaxFPS :: proc () -> bool
{
	return false
}
