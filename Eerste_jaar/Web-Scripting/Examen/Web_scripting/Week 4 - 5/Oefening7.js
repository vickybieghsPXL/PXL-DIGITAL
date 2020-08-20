const handleLoad = () => {
    let buttonGenereer = document.getElementById("button_genereer");
    buttonGenereer.addEventListener("click", handleClick);
}

const handleClick = () => {
    let inputGetal = document.getElementById("input_getal");
    let result = document.getElementById("input_result");
    let getal;
    let numberString;
    if (inputGetal.value.length > 0 && !isNaN(inputGetal.value)) {
        getal = parseFloat(inputGetal.value);
    }

    if (getal > 0 && getal < 51){
        let teller = 0;
        while (teller < getal){
            if (teller % 2 == 1){
                numberString += teller + " ";
            }
        }

        result.value = numberString;
    }
}

window.addEventListener("load", handleLoad);