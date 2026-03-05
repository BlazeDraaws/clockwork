shader_type canvas_item;
uniform vec3 sample_colour: source_color;
uniform vec3 replacement_colour: source_color;
uniform vec3 sample_line_colour: source_color;
uniform vec3 replacement_line_colour: source_color;

void fragment() {

		if(distance(COLOR.rgb, sample_line_colour) <= 0.19){
		COLOR.rgb = replacement_colour * replacement_line_colour;
	}

	if(distance(COLOR.rgb, sample_colour) <= 0.48){
		COLOR.rgb = replacement_colour;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
