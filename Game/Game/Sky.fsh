void main() {
    const float R1 = 40.0;
    const float G1 = 130.0;
    const float B1 = 210.0;
    
    const float R2 = 130.0;
    const float G2 = 220.0;
    const float B2 = 240.0;
    
    float y = 1.0 - gl_FragCoord.y / u_sprite_size.y;
    float r = (R1 + (R2 - R1) * y) / 255.0;
    float g = (G1 + (G2 - G1) * y) / 255.0;
    float b = (B1 + (B2 - B1) * y) / 255.0;
    gl_FragColor = vec4(r, g, b, 1.0);
}