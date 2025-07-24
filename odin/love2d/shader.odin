package love2d

import "core:strings"
import "core:fmt"
import "core:os"

GLSL_VERSION := make(map[string]string)
GLSL_MAP := make(map[string]string)

GLSL_SYNTAX ,GLSL_UNIFORMS, GLSL_FUNCTIONS :string

DEFAULTCODE_VERTEX: string
DEFAULTCODE_PIXEL: string
DEFAULTCODE_VIDEOPIXEL: string
DEFAULTCODE_ARRAYPIXEL: string

read_file :: proc (file_path: string) -> (string, bool)
{
	data, OK := os.read_entire_file(file_path)

	if !OK { return "", OK}

	return cast(string)data, OK
}

read_cache :: proc () -> (string, bool)
{
	return read_file("love2d/resources/shader/shadercache.txt")
}

read_shader :: proc (shader: string) -> (string, bool)
{
	return read_file(strings.join([]string{"love2d/resources/shader/", shader, ".txt"}, ""))
}

write_cache :: proc (content: cstring) -> bool
{
	//return os.write_entire_file("love2d/resources/shader/shadercache.txt", content)
	return false
}

ShaderInitGLSL :: proc ()
{
	GLSL_VERSION["glsl1,F"] = "#version 120"
	GLSL_VERSION["glsl1,T"] = "#version 100"
	GLSL_VERSION["glsl3,F"] = "#version 330 core"
	GLSL_VERSION["glsl3,T"] = "#version 300 es"
	
	GLSL_SYNTAX, _ = read_shader("GLSL_SYNTAX")
	GLSL_UNIFORMS, _ = read_shader("GLSL_UNIFORMS")
	GLSL_FUNCTIONS, _ = read_shader("GLSL_FUNCTIONS")

	GLSL_MAP["VERTEX_HEADER"], _ = read_shader("VERTEX_HEADER")
	GLSL_MAP["VERTEX_FUNCTIONS"], _ = read_shader("VERTEX_FUNCTIONS")
	GLSL_MAP["VERTEX_MAIN"], _ = read_shader("VERTEX_MAIN")

	GLSL_MAP["PIXEL_HEADER"], _ = read_shader("PIXEL_HEADER")
	GLSL_MAP["PIXEL_FUNCTIONS"], _ = read_shader("PIXEL_FUNCTIONS")
	GLSL_MAP["PIXEL_MAIN"], _ = read_shader("PIXEL_MAIN")

	GLSL_MAP["PIXEL_MAIN_CUSTOM"], _ = read_shader("PIXEL_MAIN_CUSTOM")

	DEFAULTCODE_VERTEX, _ = read_shader("DEFAULTCODE_VERTEX")
	DEFAULTCODE_PIXEL, _ = read_shader("DEFAULTCODE_PIXEL")
	DEFAULTCODE_VIDEOPIXEL, _ = read_shader("DEFAULTCODE_VIDEOPIXEL")
	DEFAULTCODE_ARRAYPIXEL, _ = read_shader("DEFAULTCODE_ARRAYPIXEL")
}

ShaderCreateStageCode :: proc (stage, code, lang: string, gles, glsl1on3, gamma_correct, custom: bool) -> string
{
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

ShaderInit :: proc ()
{
	shadercode, OK := read_cache()

	code: [2*4*4]string

	shader_code: [2*4*4]cstring

	//if !OK {
		ShaderInitGLSL()

		lang_idx: []string = {"glsl1", "essl1", "glsl3", "essl3"}
		lang_map := make(map[string]Tuple(string, bool))
		lang_map["glsl1"] = {"glsl1", false}
		lang_map["essl1"] = {"glsl1", true}
		lang_map["glsl3"] = {"glsl3", false}
		lang_map["essl3"] = {"glsl3", true}
		
		gamma_correct: []bool = {true, false}
	
		index: int = 0
		for gamma in gamma_correct {
			for idx in lang_idx {
				target, gles := tuple_unpack(lang_map[idx])

				code[index] = ShaderCreateStageCode(
					"VERTEX",
					DEFAULTCODE_VERTEX,
					target,
					gles,
					false,
					gamma,
					false
				)
				index += 1
				code[index] = ShaderCreateStageCode(
					"PIXEL",
					DEFAULTCODE_PIXEL,
					target,
					gles,
					false,
					gamma,
					false
				)
				index += 1
				code[index] = ShaderCreateStageCode(
					"PIXEL",
					DEFAULTCODE_VIDEOPIXEL,
					target,
					gles,
					false,
					gamma,
					true
				)
				index += 1
				code[index] = ShaderCreateStageCode(
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
	//}

	for str, idx in code {
		shader_code[idx] = strings.clone_to_cstring(code[idx])
	}

	graphics_setDefaultShaderCode(shader_code[:])
		
	//write_cache(shader_code)

	//delete(GLSL_VERSION)
	//delete(GLSL_MAP)
	//delete(lang_map)
}
