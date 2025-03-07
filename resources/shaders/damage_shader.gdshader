shader_type canvas_item;

uniform vec4 damage_color : hint_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float intensity : hint_range(0, 1) = 0.0;

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    COLOR = mix(original_color, damage_color, intensity);
}