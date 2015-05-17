void main() {
    float yPos = gl_FragCoord.y;
    float gradient = 1.0 - yPos / u_sprite_size.y;
    
    //vec4 color = SKDefaultShading(); // the current label color
  /*  vec4 color = topColor;
    color = vec4(gradient + color.r, gradient + color.g, gradient + color.b, color.a);
    color.rgb *= color.a; // set background to alpha 0
    gl_FragColor = color;
 *
    /*
    float gradient = 1 - gl_FragCoord.y / u_sprite_size.y;
    vec4 color = vec4(topColor.r + (bottomColor.r - topColor.r) * gradient,
                      topColor.g + (bottomColor.g - topColor.g) * gradient,
                      topColor.b + (bottomColor.b - topColor.b) * gradient,
                      topColor.a + (bottomColor.a - topColor.a) * gradient);*/
    //gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    
    gl_FragColor = vec4((10.0 + 120.0 * gradient) / 255.0, (125.0 + 105.0 * gradient) / 255.0, (125.0 + 125.0 * gradient) / 255.0, 1.0);
}