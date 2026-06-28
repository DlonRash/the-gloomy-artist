shader_type canvas_item;

// This uniform receives the live drawing texture from our SubViewport
uniform sampler2D mask_texture : hint_default_black;

void fragment() {
    // 1. Get the sprite's original color
    vec4 tex_color = texture(TEXTURE, UV);
    
    // 2. Get the mask value (White = Monochrome, Black/Transparent = Normal Color)
    float mask_value = texture(mask_texture, UV).r;
    
    // 3. Calculate the monochrome version of the pixel
    float gray = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114));
    vec4 mono_color = vec4(vec3(gray), tex_color.a);
    
    // 4. Smoothly mix between original color and monochrome based on the mask
    COLOR = mix(tex_color, mono_color, mask_value);
	}