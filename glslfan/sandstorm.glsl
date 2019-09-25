// - glslfan.com --------------------------------------------------------------
// Ctrl + s or Command + s: compile shader
// Ctrl + m or Command + m: toggle visibility for codepane
// ----------------------------------------------------------------------------
precision mediump float;
uniform vec2  resolution;     // resolution (width, height)
uniform vec2  mouse;          // mouse      (0.0 ~ 1.0)
uniform float time;           // time       (1second == 1.0)

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float sandstorm(vec2 p, float density, float seed) {
    float x = rand(vec2(p.x * seed, p.y));
    float y = rand(vec2(p.y * seed, p.x));
    float tmp = 0.;
    if (y < density) {
        tmp += .5;
    }
    if (x < density) {
        tmp += .5;
    }
    return tmp;
}

void main() {
    vec2 p = (gl_FragCoord.xy * 2.0 - resolution) / resolution;
    vec3 col = vec3(0.0);
    col.rgb += vec3(sandstorm(p, 0.5,time) * 1.);
    gl_FragColor = vec4(col, 1.0);
}

