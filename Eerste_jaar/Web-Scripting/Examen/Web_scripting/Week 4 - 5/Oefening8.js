function handleClick() {
    let inputNumber = document.getElementById("input_number");
    let preOutput = document.getElementById("pre_output");

    let number = parseFloat(inputNumber.value);
    let output = "";

    if (isNaN(number) || number < 2 || number > 10){
        output = "oops";
    } else {
        for (let i = 0; i < number; i++){
            output += "*".repeat(i + 1) + "\n";
        }
    }
    preOutput.textContent = output;
}

function handleLoad () {
    let buttonDraw = document.getElementById("button_draw");
    buttonDraw.addEventListener("click", handleClick);

}

window.addEventListener("load", handleLoad);