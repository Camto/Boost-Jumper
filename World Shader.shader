shader_type canvas_item;

uniform uint level = 0;

vec4 grayscale(vec4 clr) {
	float gray = (clr.r + clr.g + clr.b) / 3.0;
	return vec4(vec3(gray), clr.a);
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	
	if(COLOR.r == COLOR.g && COLOR.g == COLOR.b) {
		COLOR.b += COLOR.b * 0.1;
	} else if(level == uint(0)) {
		COLOR = grayscale(COLOR);
		COLOR.b += COLOR.b * 0.1;
	} else {
		// Does nothing yet.
	}
}