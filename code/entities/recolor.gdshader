shader_type canvas_item;
uniform sampler2D palette;
uniform bool ison;
const float precision = 0.3;
uniform vec4 dodge: source_color;

void fragment() {
	if (ison == true) {
		vec4 color = texture(TEXTURE, UV);
		vec4 result_color = texture(palette, color.rg);
		if (distance(color, dodge) >= precision){
			//return result_color;
			result_color.a = color.a;
			COLOR = result_color;
		}
		
	}
}