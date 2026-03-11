shader_type canvas_item;

uniform float stripe: hint_range(0.0, 1.0, 0.1) = 0.9;
uniform float scan: hint_range(0.0, 1.0, 0.1) = 0.7;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 color = texture(TEXTURE, UV);
	vec4 lcd = vec4(stripe, stripe, stripe, 1.0);
	int rgb_stripe = int(mod(FRAGCOORD.x, 10.5));
	
	if(rgb_stripe == 1){
		lcd.r = 1.0;
	} else if(rgb_stripe == 2){
		lcd.g = 1.0;
	} else{
		lcd.b = 1.0;
	}
	if(int(mod(FRAGCOORD.y, 10.5)) == 0){
		lcd.rgb = vec3(scan);
	}
	
	COLOR = color * lcd;
}