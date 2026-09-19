shader_type canvas_item;

uniform vec4 flash_color : source_color = vec4(1.0,1.0,1.0,1.0);
uniform float flash_amount : hint_range(0.0, 1.0) = 0.0;
uniform bool solid_flash = false;


void fragment() {
	vec4 base = texture(TEXTURE, UV);
	
	if (solid_flash) {
		COLOR = vec4(flash_color.rgb, base.a);
	}
	else if (flash_amount > 0.0) {
		COLOR.rgb = mix(base.rgb, flash_color.rgb, flash_amount);
		COLOR.a = base.a;
	}
	else {
		COLOR = base;
	}
}
