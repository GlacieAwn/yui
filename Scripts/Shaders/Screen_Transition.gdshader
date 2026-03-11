shader_type canvas_item;

uniform float fade_progress : hint_range(0, 1) = 0.0;

void fragment() {
	vec4 base_color = COLOR;
	
	float stepped_progress = floor(fade_progress * 4.0 + 0.5) / 4.0;
	stepped_progress = clamp(stepped_progress, 0.0, 1.0);
	
	base_color.a *= (1.0 - stepped_progress);
	
	COLOR = base_color;
}
