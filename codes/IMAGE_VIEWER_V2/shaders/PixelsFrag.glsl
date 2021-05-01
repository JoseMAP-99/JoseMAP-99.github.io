#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 pixels;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  vec2 p = vertTexCoord.st;

	p.x -= mod(p.x, 1.0 / pixels.x);
	p.y -= mod(p.y, 1.0 / pixels.y);
  gl_FragColor = texture2D(texture, p) * vertColor;
}