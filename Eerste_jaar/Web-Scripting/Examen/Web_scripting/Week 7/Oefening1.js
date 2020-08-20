window.addEventListener("load", handleLoad);

function handleLoad() {
    let canvas = document.getElementById("canvas");
    let context = canvas.getContext("2d");
    context.strokeStyle = "orange";
    context.strokeRect(10, 10, 370, 230);
    context.lineWidth = 5;

    context.strokeStyle = "purple";
    context.lineWidth = 3;
    context.beginPath();

    context.moveTo(150, 40);
    context.bezierCurveTo(20, 30, 40, 120, 95, 120);
    context.bezierCurveTo(170, 130, 170, 220, 40, 200);

    context.moveTo(200, 40);
    context.lineTo(240, 200);
    context.lineTo(270, 120);
    context.lineTo(300, 200);
    context.lineTo(340, 40);
    context.stroke();
}