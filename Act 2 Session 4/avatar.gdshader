shader_type canvas_item;
render_mode unshaded;

uniform float desaturate_strength : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	float lumi = (tex_color.r + tex_color.g + tex_color.b) / 3.0;
	vec3 grayscale = vec3(lumi);

	// Interpolate between original color and grayscale
	COLOR.rgb = mix(tex_color.rgb, grayscale, desaturate_strength);
	COLOR.a = tex_color.a;
}
