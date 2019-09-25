ion mediump float;
uniform vec2  resolution;     // resolution (width, height)
uniform vec2  mouse;          // mouse      (0.0 ~ 1.0)
uniform float time;           // time       (1second == 1.0)
uniform sampler2D backbuffer; // previous scene

const float PI = 3.1415926;

mat2 spin( float theta ){
	return mat2 (cos(theta), -sin(theta), sin(theta), cos(theta));
}



vec3 hsv(float h, float s, float v){
    vec4 t = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(vec3(h) + t.xyz) * 6.0 - vec3(t.w));
    return v * mix(vec3(t.x), clamp(p - vec3(t.x), 0.0, 1.0), s);
}


vec3 toppage(vec2 p){
    vec3 line = vec3(0.0);
    for(float fi = 0.0; fi < 50.0; ++fi){
        float offset = fi * PI / 100.0;
        float value = 1.0 + sin(time * fi * 0.15 + 0.1) * 0.5;
        float timer = time * fi * 0.01;
        vec3  color = hsv((fi + time) * 0.0175, 1.0, value);
        line += 0.0025 / abs(p.y + sin(p.x * 1.0 + timer + offset) * 0.75) * color;
    }
    return line;
}

void main(){
    vec2 p = (gl_FragCoord.xy * 2.0 - resolution) / resolution;
    vec3 col = vec3(0.0);

    vec2 earth = spin(time)*vec2(0.8,0.0);
    if(length(earth - p)<0.05) col.z=1.0;
    
    vec2 sun = vec2(0.0,0.0);
    if(length(sun - p)<0.1) col.x=1.0;
    
    vec2 moon = earth + spin(time*(-2.0))*vec2(0.2,0.0);
    if(length(moon - p)<0.01){
        col = vec3(1.0);
    }


    gl_FragColor = vec4(col, 1.0);
}
