const handleClick = () => {
let x = document.getElementById("x");
let y = document.getElementById("y");
let output = document.getElementById("fuckwillekens");
let getal2 = x.value;
let getal1 = y.value;

if(isNaN(getal1) || isNaN(getal2)){
    output.value = "fuckyou";
} else {
    output.value = parseFloat(getal1) * parseFloat(getal2);
}
}

const handleLoad = () => {
    let button = document.getElementById("berekening");
    button.addEventListener("click", handleClick);
}
window.addEventListener("load", handleLoad);
