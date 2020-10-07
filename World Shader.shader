shader_type canvas_item;

uniform uint level = 0;

vec4 grayscale(vec4 clr) {
	float gray = (clr.r + clr.g + clr.b) / 3.0;
	return vec4(vec3(gray), clr.a);
}

vec4 desaturate(vec3 color, float desaturation) {
	vec3 grayXfer = vec3(0.3, 0.59, 0.11);
	vec3 gray = vec3(dot(grayXfer, color));
	return vec4(mix(color, gray, desaturation), 1.0);
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	
	if(COLOR.r == COLOR.g && COLOR.g == COLOR.b) {
		COLOR.b += COLOR.b * 0.1;
	} else if(level == uint(0)) {
		if(COLOR.a != 0.0) {
			COLOR = desaturate(COLOR.rgb, 1.0);
			COLOR.b += COLOR.b * 0.1;
		}
	} else {
		// Does nothing yet.
	}
}