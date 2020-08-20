const handleClick = () => {
    let input = document.getElementById("input");
    let output = document.getElementById("output");
    let array = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"];
    if(array.indexOf(input.value) != -1){
    output.value = "dit is de " + (array.indexOf(input.value) + 1) + "de dag van de week";}
    else{output.value = "dit is geen dag he pik"}
}

const handleLoad = () => {
    let button = document.getElementById("button");
    button.addEventListener("click", handleClick);
}
window.addEventListener("load", handleLoad);
