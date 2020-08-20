const handleLoad = () => {
    let canvas = document.getElementById("kanker");
    let context = canvas.getContext("2d");
    context.fillStyle = "Lightblue";
    context.fillRect(0,0,800,800);
    let img = document.createElement("img");
    img.src = "sprite.png";
    img.addEventListener("load", function(){
        for(let i = 0; i < 20; i++){
        context.drawImage(img, 0, 0, 117, 67, 100, 100, 117, 67);
        setTimeout(context.drawImage(img, 118, 0, 117, 67, 100, 100, 117, 67), 1000);
        }      
    });

}
window.addEventListener("load", handleLoad);
