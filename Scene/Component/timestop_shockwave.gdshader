shader_type canvas_item;

uniform sampler2D screen_tex : hint_screen_texture, repeat_disable, filter_linear;
uniform vec2 center = vec2(0.5, 0.5); // position écran normalisée du joueur
uniform float radius : hint_range(0.0, 2.0) = 0.0;
uniform float thickness : hint_range(0.0, 1.0) = 0.08;
uniform float aspect = 1.0;
uniform float distortion_strength : hint_range(0.0, 0.1) = 0.02;

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 diff = uv - center;
    diff.x *= aspect;
    float dist = length(diff);

    float ring = smoothstep(radius - thickness, radius, dist)
               - smoothstep(radius, radius + thickness, dist);

    vec2 dir = dist > 0.0001 ? normalize(diff) : vec2(0.0);
    vec2 distorted_uv = uv + dir * ring * distortion_strength;
    vec3 col = texture(screen_tex, distorted_uv).rgb;

    // dégradé arc-en-ciel qui glisse avec le temps
    float hue = fract(dist * 4.0 - TIME * 0.5);
    vec3 rainbow = clamp(vec3(
        abs(hue * 6.0 - 3.0) - 1.0,
        2.0 - abs(hue * 6.0 - 2.0),
        2.0 - abs(hue * 6.0 - 4.0)
    ), 0.0, 1.0);

    col += rainbow * ring * 1.5;
    COLOR = vec4(col, 1.0);
}