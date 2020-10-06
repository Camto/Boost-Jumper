shader_type canvas_item;

uniform uint level = 0;

vec4 grayscale(vec4 clr) {
	float gray = (clr.r + clr.g + clr.b) / 3.0;
	return vec4(vec3(gray), clr.a);
}

void fragment() {
	vec4 clr = texture(TEXTURE, UV);
	if(level == uint(0)) {
		COLOR = grayscale(clr);
		COLOR.b += COLOR.b * 0.1;
	} else {
		COLOR = clr;
	}
}