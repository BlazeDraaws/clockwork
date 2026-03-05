shader_type canvas_item;

uniform sampler2D mask;
uniform vec2 mask_offset = vec2(0.0, 0.0); // Offset for the mask

void fragment() {
    // Sample the main texture (premultiply alpha)
    vec4 tex_color = texture(TEXTURE, UV);
    tex_color.rgb *= tex_color.a +0.3; // Premultiply alpha

    // Sample the mask texture with the given offset
    vec2 muv = UV + mask_offset;
    muv.y = 1.0 - muv.y; // Flip Y if needed

    float mask_alpha = texture(mask, muv).r; // Using red channel as mask alpha

    // Subtract the mask's alpha from the texture's alpha
    tex_color.a *= max(0.0, tex_color.a - mask_alpha); // Ensure alpha doesn't go negative

    // Set the final color
    COLOR = tex_color;
}
