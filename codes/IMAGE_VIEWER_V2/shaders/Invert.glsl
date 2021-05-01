#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

varying vec4 vertTexCoord;
uniform sampler2D texture;

void main(void)
{
  	vec2 p = vertTexCoord.st;
	vec3 color = vec3(1.0) - texture2D(texture, p).rgb;
	gl_FragColor = vec4(color, 1.0);
}