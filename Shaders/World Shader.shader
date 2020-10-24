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

uniform vec4 red_replace: hint_color = vec4(0.541, 0.0, 0.0, 1.0);
uniform float opacity: hint_range(0.0, 1.0, 0.05) = 0.5;

float blendLightenC(float base, float blend) {
	return max(blend,base);
}

vec3 blendLightenO(vec3 base, vec3 blend) {
	return vec3(blendLightenC(base.r,blend.r),blendLightenC(base.g,blend.g),blendLightenC(base.b,blend.b));
}

vec3 blendLighten(vec3 base, vec3 blend, float op) {
	return (blendLightenO(base, blend) * op + base * (1.0 - op));
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
		if(COLOR.g > COLOR.r) {
			float alpha = COLOR.a;
			COLOR = desaturate(COLOR.rgb, 0.55);
			COLOR *= 0.5;
			COLOR = vec4(blendLighten(COLOR.rgb, red_replace.rgb, 0.8), alpha);
		}
	}
}