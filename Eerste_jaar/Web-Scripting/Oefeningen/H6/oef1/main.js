const tekenLoad = () => {
    let canvas = document.getElementById("canvasje");
    let context = canvas.getContext("2d");

    context.strokeStyle = "Orange";
    context.lineWidth = 6;
    context.strokeRect(0,0,800,500);

    context.strokeStyle = "Black";
    context.lineWidth = 3;
    context.beginPath();
    context.moveTo(50, 50);
    context.lineTo(150, 450);
    context.lineTo(250, 50);
    context.moveTo(300, 50);
    context.lineTo(300, 450);
    context.moveTo(350, 50);
    context.lineTo(350, 450);
    context.moveTo(350,50);
    context.quadraticCurveTo(600,150,350,200);

    context.moveTo(500, 50);
    context.lineTo(500, 450);
    context.moveTo(500,50);
    context.quadraticCurveTo(750,150,500,200);

    context.stroke();
    context.closePath();

};
window.addEventListener("load", tekenLoad);