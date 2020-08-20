const handleClick = () => {
    let ingave = document.getElementById("input");
    let output = document.getElementById("area");
    let piramide = "";
    for(let i = 1; i <= ingave.value; i++ ){
        piramide = piramide + "✈▓".repeat(i);
        piramide = piramide + '\n';
    }
    output.style.color = 'black';
    output.value = piramide;
}

const handleLoad = () => {
    let button = document.getElementById("button");
    button.addEventListener("click", handleClick);
}
window.addEventListener("load", handleLoad);