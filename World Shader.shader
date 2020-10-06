shader_type canvas_item;

vec4 grayscale(vec4 clr) {
	float gray = (clr.r + clr.g + clr.b) / 3.0;
	return vec4(vec3(gray), clr.a);
}

void fragment() {
	vec4 clr = texture(TEXTURE, UV);
	COLOR = grayscale(clr);
	COLOR.b += COLOR.b * 0.1;
}