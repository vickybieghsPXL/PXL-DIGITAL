window.requestAnimFrame = (function() {
    return window.requestAnimationFrame ||
        window.webkitRequestAnimationFrame ||
        window.mozRequestAnimationFrame ||
        function(callback) {
            window.setTimeout(callback, 1000 / 60);
        };
})();

window.onload = function() {
    var C = document.getElementById("C");
    var ctx = C.getContext("2d");
    var R = [];

    function Rect(x, y, w, h, color, angle, radius, angularSpeed) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.color = color;
        this.angle = angle;
        this.radius = radius;
        this.angularSpeed = angularSpeed;
    }

    function setSize() {
        C.width = window.innerWidth
        C.height = window.innerHeight
    }

    function setBg() {
        ctx.fillStyle = "rgb(0,0,0)"
        ctx.fillRect(0, 0, C.width, C.height)
    }

    function drawRect() {
        setBg()

        for(var i = 0; i < R.length; i++) {
            ctx.fillStyle = R[i].color;
            ctx.fillRect(R[i].x, R[i].y, R[i].w, R[i].h)
            R[i].x = C.width / 2 + Math.sin(R[i].angle) * R[i].radius;
            R[i].y = C.height / 2 + Math.cos(R[i].angle) * R[i].radius;
            R[i].angle += R[i].angularSpeed;
        }

        requestAnimFrame(drawRect)
    }

    setSize();
    setBg();

    for(var i = 0; i < 2000; i++) {
        let x = C.width / 2;
        let y = C.height / 2;
        let w = Math.random() * 3;
        let h = w;

        let r = Math.random() * 255;
        let g = Math.random() * 255;
        let b = 255;

        let color = `rgba(${~~r},${~~g},${~~b},0.5)`;
        let angle = Math.random() * 2 * Math.PI;
        let radius = Math.random() * (C.width + C.height) / 3 + 20;
        let angularSpeed = 0.2 * Math.random() *  Math.PI / radius;

        R.push(
            new Rect(x, y, w, h, color, angle, radius, angularSpeed)
        );
    }

    drawRect();
};