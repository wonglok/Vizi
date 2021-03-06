precision highp float;
varying vec3 v_normal;
uniform vec3 u_light0Color;
varying vec3 v_light0Direction;
uniform vec3 u_light1Color;
varying vec3 v_light1Direction;
uniform vec3 u_light2Color;
varying vec3 v_light2Direction;
uniform vec3 u_light3Color;
uniform vec4 u_ambient;
varying vec2 v_texcoord0;
uniform sampler2D u_diffuse;
uniform vec4 u_emission;
void main(void) {
vec3 normal = normalize(v_normal);
if (gl_FrontFacing == false) normal = -normal;
vec4 color = vec4(0., 0., 0., 0.);
vec4 diffuse = vec4(0., 0., 0., 1.);
vec3 diffuseLight = vec3(0., 0., 0.);
vec4 emission;
vec4 ambient;
{
float diffuseIntensity;
float specularIntensity;
diffuseIntensity = max(dot(normal,normalize(v_light0Direction)), 0.);
diffuseLight += u_light0Color * diffuseIntensity;
}
{
float diffuseIntensity;
float specularIntensity;
diffuseIntensity = max(dot(normal,normalize(v_light1Direction)), 0.);
diffuseLight += u_light1Color * diffuseIntensity;
}
{
float diffuseIntensity;
float specularIntensity;
diffuseIntensity = max(dot(normal,normalize(v_light2Direction)), 0.);
diffuseLight += u_light2Color * diffuseIntensity;
}
vec3 ambientLight = vec3(0., 0., 0.);
{
ambientLight += u_light3Color;
}
ambient = u_ambient;
diffuse = texture2D(u_diffuse, v_texcoord0);
emission = u_emission;
ambient.xyz *= ambientLight;
color.xyz += ambient.xyz;
diffuse.xyz *= diffuseLight;
color.xyz += diffuse.xyz;
color.xyz += emission.xyz;
color = vec4(color.rgb * diffuse.a, diffuse.a);
gl_FragColor = color;
}
