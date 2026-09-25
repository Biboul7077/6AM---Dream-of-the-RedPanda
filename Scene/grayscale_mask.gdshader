shader_type canvas_item;

uniform sampler2D screen_tex : hint_screen_texture, repeat_disable, filter_linear;
uniform vec2 player_screen_pos = vec2(0.5, 0.5);
uniform float clear_radius : hint_range(0.0, 1.0) = 0.12;
uniform float feather : hint_range(0.0, 1.0) = 0.08;
uniform float aspect = 1.0;

void fragment() {
    vec2 uv = SCREEN_UV;
    vec3 col = texture(screen_tex, uv).rgb;
    float gray = dot(col, vec3(0.299, 0.587, 0.114));

    vec2 diff = uv - player_screen_pos;
    diff.x *= aspect;
    float dist = length(diff);

    float mask = smoothstep(clear_radius, clear_radius + feather, dist); // 0 = couleur, 1 = gris
    COLOR = vec4(mix(col, vec3(gray), mask), 1.0);
}