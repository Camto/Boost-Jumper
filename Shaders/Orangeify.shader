shader_type canvas_item;

uniform vec4 bg_color: hint_color = vec4(0.698, 0.333, 0.216, 1.0);
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
	if(COLOR.a != 0.0) {
		COLOR = vec4(blendLighten(COLOR.rgb, bg_color.rgb, opacity), 1.0);
	}
}