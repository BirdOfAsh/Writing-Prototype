shader_type canvas_item;

//uniform vec2 targetPixelUV;
uniform float pixelSize;
uniform sampler2D drawTexture : filter_nearest;


void fragment() {
	// Called for every pixel the material is visible on.
	vec4 previousColor = texture(drawTexture, UV);
	COLOR = previousColor;
	//if (distance(UV, targetPixelUV) < pixelSize){
		//COLOR = vec4(1.0, 1.0, 1.0, 1.0);
	//}
	//else{
		//COLOR = previousColor;
	//}
}