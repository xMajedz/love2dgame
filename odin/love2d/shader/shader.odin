package shader

import love2d_dll ".."

import "core:os"
import "core:strings"
import "core:fmt"

GLSL_VERSION := make(map[string]string)
GLSL_MAP := make(map[string]string)

GLSL_SYNTAX ,GLSL_UNIFORMS, GLSL_FUNCTIONS :string

VERTEX_SHADER, FRAGMENT_SHADER: string

DEFAULTCODE_VERTEX: string
DEFAULTCODE_PIXEL: string
DEFAULTCODE_VIDEOPIXEL: string
DEFAULTCODE_ARRAYPIXEL: string

Tuple :: struct($First, $Second: typeid) { first: First, second: Second }

read_file :: proc (file_path: string) -> string {
	data, OK := os.read_entire_file(file_path)

	if !OK { return "" }

	return cast(string)data
}

init_GLSL :: proc () {
	GLSL_VERSION["glsl1,F"] = "#version 120"
	GLSL_VERSION["glsl1,T"] = "#version 100"
	GLSL_VERSION["glsl3,F"] = "#version 330 core"
	GLSL_VERSION["glsl3,T"] = "#version 300 es"
	
	VERTEX_SHADER = read_file("love2d/shader/VERTEX_SHADER.txt")
	FRAGMENT_SHADER = read_file("love2d/shader/FRAGMENT_SHADER.txt")

	GLSL_SYNTAX = read_file("love2d/shader/GLSL_SYNTAX.txt")
	GLSL_UNIFORMS = read_file("love2d/shader/GLSL_UNIFORMS.txt")
	GLSL_FUNCTIONS = read_file("love2d/shader/GLSL_FUNCTIONS.txt")

	GLSL_MAP["VERTEX_HEADER"] = read_file("love2d/shader/VERTEX_HEADER.txt")
	GLSL_MAP["VERTEX_FUNCTIONS"] = read_file("love2d/shader/VERTEX_FUNCTIONS.txt")
	GLSL_MAP["VERTEX_MAIN"] = read_file("love2d/shader/VERTEX_MAIN.txt")

	GLSL_MAP["PIXEL_HEADER"] = read_file("love2d/shader/PIXEL_HEADER.txt")
	GLSL_MAP["PIXEL_FUNCTIONS"] = read_file("love2d/shader/PIXEL_FUNCTIONS.txt")
	GLSL_MAP["PIXEL_MAIN"] = read_file("love2d/shader/PIXEL_MAIN.txt")

	GLSL_MAP["PIXEL_MAIN_CUSTOM"] = read_file("love2d/shader/PIXEL_MAIN_CUSTOM.txt")

	DEFAULTCODE_VERTEX = read_file("love2d/shader/DEFAULTCODE_VERTEX.txt")
	DEFAULTCODE_PIXEL = read_file("love2d/shader/DEFAULTCODE_PIXEL.txt")
	DEFAULTCODE_VIDEOPIXEL = read_file("love2d/shader/DEFAULTCODE_VIDEOPIXEL.txt")
	DEFAULTCODE_ARRAYPIXEL = read_file("love2d/shader/DEFAULTCODE_ARRAYPIXEL.txt")
}

createStageCode :: proc (stage, code, lang: string, gles, glsl1on3, gamma_correct, custom: bool) -> string {
	custom_part: string = ""	
	if custom {
		custom_part = GLSL_MAP[strings.concatenate([]string{stage, "_MAIN_CUSTOM"})]
	} else {
		custom_part = GLSL_MAP[strings.concatenate([]string{stage, "_MAIN"})]
	}

	parts: []string = {
		GLSL_VERSION[strings.concatenate([]string{lang, ",", (gles ? "T" : "F")})],
                strings.concatenate([]string{"#define ", stage, " ", stage}),
                glsl1on3 ? "#define LOVE_GLSL1_ON_GLSL3 1" : "",
                gamma_correct ? "#define LOVE_GAMMA_CORRECT 1" :  "",
                GLSL_SYNTAX,
                GLSL_MAP[strings.concatenate([]string{stage, "_HEADER"})],
                GLSL_UNIFORMS,
                GLSL_FUNCTIONS,
                GLSL_MAP[strings.concatenate([]string{stage, "_FUNCTIONS"})],
                custom_part,
                ((lang == "glsl1" || glsl1on3) && !gles) ? "#line 0" : "#line 1" ,
                code,
	}

	return strings.join(parts, "\n")
}

init :: proc () {
	init_GLSL()
	lang_idx: []string = {"glsl1", "essl1", "glsl3", "essl3"}
	lang_map := make(map[string]Tuple(string, bool))
	lang_map["glsl1"] = {"glsl1", false}
	lang_map["essl1"] = {"glsl1", true}
	lang_map["glsl3"] = {"glsl3", false}
	lang_map["essl3"] = {"glsl3", true}

	code: [2*4*4]string

	gamma_correct: []bool = {true, false}

	index: int = 0
	for gamma in gamma_correct {
		for idx in lang_idx {
			lang := lang_map[idx]
			target := lang.first
			gles := lang.second
			code[index] = createStageCode(
				"VERTEX",
				DEFAULTCODE_VERTEX,
				target,
				gles,
				false,
				gamma,
				false
			)
			index = index + 1
			code[index] = createStageCode(
				"PIXEL",
				DEFAULTCODE_PIXEL,
				target,
				gles,
				false,
				gamma,
				false
			)
			index = index + 1
			code[index] = createStageCode(
				"PIXEL",
				DEFAULTCODE_VIDEOPIXEL,
				target,
				gles,
				false,
				gamma,
				true
			)
			index = index + 1
			code[index] = createStageCode(
				"PIXEL",
				DEFAULTCODE_ARRAYPIXEL,
				target,
				gles,
				false,
				gamma,
				true
			)
			index = index + 1
		}
	}

	shader_code: [2*4*4]cstring
	for str, idx in code {
		shader_code[idx] = strings.clone_to_cstring(code[idx])
	}
	love2d_dll.graphics_setDefaultShaderCode(shader_code[:])
}
