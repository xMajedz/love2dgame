package love2d

import "core:c"

bool4 :: i32

Color :: struct ($T: typeid)
{
	r, g, b, a: T,
}

Colorf :: Color(f32)
Colori :: Color(i32)

Vector4 :: struct ($T: typeid)
{
	x, y, z, w: T,
}

Vector4f :: Vector4(f32)
Vector4i :: Vector4(i32)

Float4 :: union #no_nil { Vector4f, Colorf }
Int4 :: union #no_nil { Vector4i, Colori }

Vector2 :: struct ($T: typeid)
{
	x, y: T,
}

Vector2f :: Vector2(f32)
Vector2i :: Vector2(i32)

Float2 :: Vector2f
Int2 :: Vector2i

Point :: Vector2f

Pixel :: struct #raw_union
{
	rgba8: [4]u8,
	rgba16: [4]u16,
	rgba16f: [4]f16,
	rgba32f: [4]f32,
	packed16: u16,
	packed32: u32,
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
	color: Colorf,
}

ColoredStringArray :: struct
{
	text: []cstring,
	color: []Colorf,
	length: i32,
}

Tuple :: struct($First, $Second: typeid)
{
	first: First,
	second: Second,
}

tuple_unpack :: proc (tuple: Tuple($First, $Second)) -> (First, Second)
{
	return tuple.first, tuple.second
}

Node :: struct ($T: typeid)
{
	data: T,
	next: ^Node(T),
}

LinkedList :: struct ($T: typeid)
{
	head: ^Node(T),
	tail: ^Node(T),
	count: uint,
}

list_insert :: proc (list: ^LinkedList($T), data: T) -> ^Node(T)
{
	node := new(Node(T))
	node.data = data
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

list_pop_head :: proc (list: ^LinkedList($T)) -> ^Node(T)
{
	list.head = list.head.next
	if list.count > 0 {
		list.count = list.count - 1
	}
	return list.head
}

list_pop_tail :: proc (list: ^LinkedList($T)) -> ^Node(T)
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

newColoredString_color :: proc (text: cstring, color: Colorf) -> ColoredString
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

newColoredStringArray_array :: proc (text: []cstring, color: []Colorf) -> ColoredStringArray
{
	return ColoredStringArray{text = text, color = color}
}

newColoredStringArray :: proc {newColoredStringArray_default, newColoredStringArray_array}
