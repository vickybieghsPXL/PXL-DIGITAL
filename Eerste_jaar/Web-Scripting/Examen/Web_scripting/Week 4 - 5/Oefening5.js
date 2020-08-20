const handleLoad = () => {
    let buttonBereken = document.getElementById("button_bereken");
    buttonBereken.addEventListener("click", handleClick);
}

const handleClick = () => {
    let inputGetal1 = document.getElementById("input_getal1");
    let inputGetal2 = document.getElementById("input_getal2");
    let inputUitkomst = document.getElementById("input_uitkomst");

    let getal1 = inputGetal1.value;
    let getal2 = inputGetal2.value;

    if (isNaN(getal1) || isNaN(getal2)){
        inputUitkomst.value = "oops";
    } else {
        inputUitkomst.value = parseFloat(getal1) * parseFloat(getal2);
    }


}

window.addEventListener("load", handleLoad);


