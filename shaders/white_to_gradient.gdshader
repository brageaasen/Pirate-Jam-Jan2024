shader_type canvas_item;

uniform sampler2D gradient_texture;

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    vec4 gradient_color = texture(gradient_texture, UV);

    // Blend original color and gradient color
    COLOR = mix(original_color, gradient_color, gradient_color.a);
}
