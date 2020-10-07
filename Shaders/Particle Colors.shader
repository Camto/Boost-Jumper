shader_type canvas_item;

uniform uint level = 0;
uniform sampler2D colors;

void fragment() {
	float idx = COLOR.r;
	COLOR = texture(colors, vec2((idx - 0.0001) * float(level + uint(1)) / 4.0, 0));
}