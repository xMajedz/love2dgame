package shader

import love2d_dll ".."

import "core:strings"
import "core:fmt"
import "core:os"

Tuple :: love2d_dll.Tuple

GLSL_VERSION := make(map[string]string)
GLSL_MAP := make(map[string]string)

GLSL_SYNTAX ,GLSL_UNIFORMS, GLSL_FUNCTIONS :string

DEFAULTCODE_VERTEX: string
DEFAULTCODE_PIXEL: string
DEFAULTCODE_VIDEOPIXEL: string
DEFAULTCODE_ARRAYPIXEL: string

read_file :: proc (file_path: string) -> string {
	data, OK := os.read_entire_file(file_path)

	if !OK { return "" }

	return cast(string)data
}

read_shader :: proc (shader: string) -> string {
	return read_file(strings.join([]string{"love2d/shader/", shader, ".txt"}, ""))
}

init_GLSL :: proc () {
	GLSL_VERSION["glsl1,F"] = "#version 120"
	GLSL_VERSION["glsl1,T"] = "#version 100"
	GLSL_VERSION["glsl3,F"] = "#version 330 core"
	GLSL_VERSION["glsl3,T"] = "#version 300 es"
	
	GLSL_SYNTAX = read_shader("GLSL_SYNTAX")
	GLSL_UNIFORMS = read_shader("GLSL_UNIFORMS")
	GLSL_FUNCTIONS = read_shader("GLSL_FUNCTIONS")

	GLSL_MAP["VERTEX_HEADER"] = read_shader("VERTEX_HEADER")
	GLSL_MAP["VERTEX_FUNCTIONS"] = read_shader("VERTEX_FUNCTIONS")
	GLSL_MAP["VERTEX_MAIN"] = read_shader("VERTEX_MAIN")

	GLSL_MAP["PIXEL_HEADER"] = read_shader("PIXEL_HEADER")
	GLSL_MAP["PIXEL_FUNCTIONS"] = read_shader("PIXEL_FUNCTIONS")
	GLSL_MAP["PIXEL_MAIN"] = read_shader("PIXEL_MAIN")

	GLSL_MAP["PIXEL_MAIN_CUSTOM"] = read_shader("PIXEL_MAIN_CUSTOM")

	DEFAULTCODE_VERTEX = read_shader("DEFAULTCODE_VERTEX")
	DEFAULTCODE_PIXEL = read_shader("DEFAULTCODE_PIXEL")
	DEFAULTCODE_VIDEOPIXEL = read_shader("DEFAULTCODE_VIDEOPIXEL")
	DEFAULTCODE_ARRAYPIXEL = read_shader("DEFAULTCODE_ARRAYPIXEL")
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
			index += 1
			code[index] = createStageCode(
				"PIXEL",
				DEFAULTCODE_PIXEL,
				target,
				gles,
				false,
				gamma,
				false
			)
			index += 1
			code[index] = createStageCode(
				"PIXEL",
				DEFAULTCODE_VIDEOPIXEL,
				target,
				gles,
				false,
				gamma,
				true
			)
			index += 1
			code[index] = createStageCode(
				"PIXEL",
				DEFAULTCODE_ARRAYPIXEL,
				target,
				gles,
				false,
				gamma,
				true
			)
			index += 1
		}
	}

	shader_code: [2*4*4]cstring
	for str, idx in code {
		shader_code[idx] = strings.clone_to_cstring(code[idx])
	}

	love2d_dll.graphics_setDefaultShaderCode(shader_code[:])

	delete(GLSL_VERSION)
	delete(GLSL_MAP)
	delete(lang_map)
}
