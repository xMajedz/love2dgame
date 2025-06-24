package mathf

import love2d_dll ".."

import "core:c"
import "core:fmt"
import "core:math"

RandomGenerator :: love2d_dll.RandomGenerator
newRandomGenerator :: love2d_dll.newRandomGenerator

rg: ^RandomGenerator

rg_random_default :: proc (rg_ptr: ^RandomGenerator) -> c.float {
	out_result: c.double
	love2d_dll.type_RandomGenerator_random(rg_ptr.ptr, &out_result)
	return cast(c.float)out_result
}

rg_random_float :: proc (rg_ptr: ^RandomGenerator, min, max: c.float) -> c.float {
	random := rg_random_default(rg_ptr)
	return random * (max - min) + min
}

rg_random_int :: proc (rg_ptr: ^RandomGenerator, min, max: c.int) -> c.int {
	random := rg_random_default(rg_ptr)
	return c.int(c.int(random) * (max - min) + min)
}

rg_random :: proc {rg_random_default, rg_random_float, rg_random_int}

rg_randomNormal :: proc (rg_ptr: ^RandomGenerator, stddev, mean: c.double) -> c.float {
	out_result: c.double = 0
	love2d_dll.type_RandomGenerator_randomNormal(rg_ptr.ptr, stddev, mean, &out_result)
	return cast(c.float)out_result
}

rg_setSeed_default :: proc (rg_ptr: ^RandomGenerator, low, high: c.uint) {
	love2d_dll.type_RandomGenerator_setSeed(rg_ptr, low, high)
}

rg_setSeed_long :: proc (rg_ptr: ^RandomGenerator, seed: c.long) {
	rg_setSeed_default(rg_ptr, 0.00, 1.00)
}

rg_setSeed :: proc {rg_setSeed_default, rg_setSeed_long}

random :: proc () -> c.float {
	return rg_random(rg)
}

init_default :: proc () {
	love2d_dll.open_love_math()
	rg = newRandomGenerator()
}

init_seed :: proc (seed: int) {
	init_default()
	rg_setSeed(rg, cast(c.long)seed)
}

init :: proc {init_default, init_seed}

colorFromBytes_rgba :: proc (r, g, b, a: int) -> (c.float, c.float, c.float, c.float) {
	r := math.clamp(math.floor(c.float(r) + 0.5)/255, 0, 1)
	g := math.clamp(math.floor(c.float(g) + 0.5)/255, 0, 1)
	b := math.clamp(math.floor(c.float(b) + 0.5)/255, 0, 1)
	a := math.clamp(math.floor(c.float(a) + 0.5)/255, 0, 1)
	return r, g, b, a
}

colorFromBytes_rgb :: proc (r, g, b: int) -> (c.float, c.float, c.float) {
	r, g, b, a := colorFromBytes(r, g, b, 0)
	return r, g, b
}

colorFromBytes :: proc {colorFromBytes_rgb, colorFromBytes_rgba}

close :: proc () {
	rg.release(rg)
	rg.ptr = nil
	free(rg)
	rg = nil
}
