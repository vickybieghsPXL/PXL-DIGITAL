const pointSize = 2.5;
const waves = new ShaderProgram( document.querySelector( '.particles' ), {
    texture: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAAb1BMVEUAAAD///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////8v0wLRAAAAJHRSTlMAC/goGvDhmwcExrVjWzrm29TRqqSKenRXVklANSIUE8mRkGpv+HOfAAABCElEQVQ4y4VT13LDMAwLrUHteO+R9f/fWMfO6dLaPeKVEECRxOULWsEGpS9nULDwia2Y+ALqUNbAWeg775zv+sA4/FFRMxt8U2FZFCVWjR/YrH4/H9sarclSKdPMWKzb8VsEeHB3m0shkhVCyNzeXeAQ9Xl4opEieX2QCGnwGbj6GMyjw9t1K0fK9YZunPXeAGsfJtYjwzxaBnozGGorYz0ypK2HzQSYx1y8DgSRo2ewOiyh2QWOEk1Y9OrQV0a8TiBM1a8eMHWYnRMy7CZ4t1CmyRkhSUvP3gRXyHOCLBxNoC3IJv//ZrJ/kxxUHPUB+6jJZZHrpg6GOjnqaOmzp4NDR48OLxn/H27SRQ08S0ZJAAAAAElFTkSuQmCC',
    uniforms: {
        size: { type: 'float', value: pointSize },
        field: { type: 'vec3', value: [ 0, 0, 0 ] },
        speed: { type: 'float', value: 5 },
    },
    vertex: `
        #define M_PI 3.1415926535897932384626433832795
        precision highp float;
        attribute vec4 a_position;
        attribute vec4 a_color;
        uniform float u_time;
        uniform float u_size;
        uniform float u_speed;
        uniform vec3 u_field;
        uniform mat4 u_projection;
        varying vec4 v_color;
        void main() {
          vec3 pos = a_position.xyz;
          pos.y += (
            cos(pos.x / u_field.x * M_PI * 8.0 + u_time * u_speed) +
            sin(pos.z / u_field.z * M_PI * 8.0 + u_time * u_speed)
          ) * u_field.y;
          gl_Position = u_projection * vec4( pos.xyz, a_position.w );
          gl_PointSize = ( u_size / gl_Position.w ) * 100.0;
          v_color = a_color;
        }`,
    fragment: `
        precision highp float;
        uniform sampler2D u_texture;
        varying vec4 v_color;
        void main() {
          gl_FragColor = v_color * texture2D(u_texture, gl_PointCoord);
        }`,
    onResize( w, h, dpi ) {
        const position = [], color = []
        const width = 400 * ( w / h )
        const depth = 400
        const height = 3
        const distance = 5
        for ( let x = 0; x < width; x += distance ) {
            for ( let z = 0; z < depth; z+= distance ) {
                position.push( - width / 2 + x, -30, -depth / 2 + z )
                color.push( 0, 1 - ( x / width ) * 1, 0.5 + x / width * 0.5, z / depth )
            }
        }
        this.uniforms.field = [ width, height, depth ]
        this.buffers.position = position
        this.buffers.color = color
        this.uniforms.size = ( h / 400) * pointSize * dpi
    },
} )