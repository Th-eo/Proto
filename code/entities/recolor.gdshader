shader_type canvas_item;
uniform sampler2D palette; // Colors to use
uniform bool ison; // Shader parameter to turn on and off when necessary
const float precision = 0.3; // .3 seems to be the sweepspot for me
uniform vec4 dodge: source_color; // A color that won't be recolored

void fragment() {
	if (ison == true) {
		vec4 color = texture(TEXTURE, UV);
		vec4 result_color = texture(palette, vec2(color.r, 0.5));
		if (distance(color, dodge) >= precision){
			result_color.a = color.a;
			COLOR.rgb = result_color.rgb;
		}
	}
}