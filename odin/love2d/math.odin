package love2d

import "core:c"
import "core:math"

rg_ptr: RandomGenerator

rg_random_default :: proc (rg: RandomGenerator) -> f32
{
	out_result: f64
	type_RandomGenerator_random(rg, &out_result)
	return cast(f32)out_result
}

rg_random_float :: proc (rg: RandomGenerator, min, max: f32) -> f32
{
	random := rg_random_default(rg)
	return random * (max - min) + min
}

rg_random_int :: proc (rg: RandomGenerator, min, max: int) -> int
{
	random := rg_random_default(rg)
	return int(int(random) * (max - min) + min)
}

rg_random :: proc {rg_random_default, rg_random_float, rg_random_int}

rg_randomNormal :: proc (rg: RandomGenerator, stddev, mean: f64) -> f32
{
	out_result: f64 = 0
	type_RandomGenerator_randomNormal(rg, stddev, mean, &out_result)
	return cast(f32)out_result
}

rg_setSeed_default :: proc (rg: RandomGenerator, low, high: c.uint)
{
	type_RandomGenerator_setSeed(rg, low, high)
}

rg_setSeed_long :: proc (rg: RandomGenerator, seed: c.long)
{
	rg_setSeed_default(rg, 0.00, 1.00)
}

rg_setSeed :: proc {rg_setSeed_default, rg_setSeed_long}

MathRandom :: proc () -> f32
{
	return rg_random(rg_ptr)
}

MathInitDefault :: proc ()
{
	open_love_math()
	rg_ptr = newRandomGenerator()
}

MathInitSeed :: proc (seed: int)
{
	MathInitDefault()
	if (seed != 0) {
		rg_setSeed(rg_ptr, cast(c.long)seed)
	}
}

MathInit :: proc {MathInitDefault, MathInitSeed}

MathColorFromBytes_rgba :: proc (r, g, b, a: int) -> (f32, f32, f32, f32)
{
	r := math.clamp(math.floor(f32(r) + 0.5)/255, 0, 1)
	g := math.clamp(math.floor(f32(g) + 0.5)/255, 0, 1)
	b := math.clamp(math.floor(f32(b) + 0.5)/255, 0, 1)
	a := math.clamp(math.floor(f32(a) + 0.5)/255, 0, 1)
	return r, g, b, a
}

MathColorFromBytes_rgb :: proc (r, g, b: int) -> (f32, f32, f32)
{
	r, g, b, a := MathColorFromBytes(r, g, b, 0)
	return r, g, b
}

MathColorFromBytes :: proc {MathColorFromBytes_rgb, MathColorFromBytes_rgba}

MathClose :: proc ()
{
	release(rg_ptr)
	rg_ptr = nil
}
