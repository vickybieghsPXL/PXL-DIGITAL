const handleClick = () => {
    let voornaam = document.getElementById("voornaam");
    let achternaam = document.getElementById("achternaam");
    let output = document.getElementById("output");
    let melding = "welkom, " + voornaam.value + " " + achternaam.value;
    let foutmelding = "vul alle velden in aub"; 
    if(voornaam.value == ""){
        output.value = foutmelding;
    } else if (achternaam.value == ""){
        output.value = foutmelding;
    } else{
        output.value = melding;
    }

}
const handleLoad = () => {
    let button = document.getElementById("button");
    button.addEventListener("click", handleClick);
}
window.addEventListener("load", handleLoad);