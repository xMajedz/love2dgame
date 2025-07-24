package love2d

import "core:c"

//Float4 :: union { Color, Vector4 }
Float4 :: struct #raw_union { Color, Vector4 }

bool4 :: i32

pchar :: ^u8

Int2 :: struct
{
        x, y: c.int
}

Int4 :: struct
{
        union {
            struct { x, y, z, w: c.int },
            struct { r, g, b, a: c.int },
        }
}

Float2 :: struct
{
        union {
            struct { x, y: c.float }
        }
}

Float3 :: struct
{
        union {
            struct { x, y, z: c.float }
        }
}

Pixel :: union
{
	//rgba8: [4]c.uint8_t,
	[4]c.uint8_t,
	//rgba16: [4]c.uint16_t,
	[4]c.uint16_t,
	//rgba16f: [4]c.float16,
	//[4]c.float16,
	[4]f16,
	//rgba32f: [4]c.float,
	[4]c.float,
	//packed16: c.uint16,
	c.uint16_t,
	//packed32: c.uint32,
	c.uint32_t,
}

WrapString :: struct
{
	data: ^cstring,
}

WrapSequenceString :: struct
{
	sequence: ^cstring,
	length: i32,
}

ColoredString :: struct
{
	text: cstring,
	color: Color,
}

ColoredStringArray :: struct
{
	text: []cstring,
	color: []Color,
	length: i32,
}

Point :: struct
{
	x, y: f32,
}

Tuple :: struct($First, $Second: typeid)
{
	first: First,
	second: Second,
}

Color :: struct #packed
{
	r, g, b, a: f32,
}

Vector4 :: struct
{
	x, y, z, w: f32,
}

Node :: struct
{
	data: EventData,
	next: ^Node,
}

LinkedList :: struct
{
	head: ^Node,
	tail: ^Node,
	count: int,
}

list_insert :: proc (list: ^LinkedList, node: ^Node) -> ^Node
{
	if 0 < list.count {
		list.tail.next = node
		list.tail= list.tail.next
	} else {
		list.head = node
		list.tail = node
		list.tail.next = list.tail
	}
	list.count = list.count + 1
	return list.tail
}

list_pop_head :: proc (list: ^LinkedList) -> ^Node
{
	list.head = list.head.next
	if list.count > 0 {
		list.count = list.count - 1
	}
	return list.head
}

list_pop_tail :: proc (list: ^LinkedList) -> ^Node
{
	counter := 0
	node := list.head
	if 0 < list.count {
		for counter < list.count - 1 {
			node = node.next
			counter = counter + 1
		}
		list.tail = node
		list.count = list.count - 1
	}
	return list.tail
}

newColoredString_default :: proc (text: cstring) -> ColoredString
{
	return ColoredString{text = text, color = {1.00, 1.00, 1.00, 1.00}}
}

newColoredString_color :: proc (text: cstring, color: Color) -> ColoredString
{
	return ColoredString{text = text, color = color}
}

newColoredString_rgba :: proc (text: cstring, r, g, b, a: c.float) -> ColoredString
{
	return ColoredString{text = text, color = {r, g, b, a}}
}

newColoredString :: proc {newColoredString_default, newColoredString_color, newColoredString_rgba}

newColoredStringArray_default :: proc (text: cstring) -> ColoredStringArray
{
	return ColoredStringArray{text = {text}, color = {{1.00, 1.00, 1.00, 1.00}}}
}

newColoredStringArray_array :: proc (text: []cstring, color: []Color) -> ColoredStringArray
{
	return ColoredStringArray{text = text, color = color}
}

newColoredStringArray :: proc {newColoredStringArray_default, newColoredStringArray_array}
