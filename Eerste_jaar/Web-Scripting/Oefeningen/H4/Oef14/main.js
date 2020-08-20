const handleClick = () => {

}

const handleWipe = () => {

}
const handleHoover = () => {
    let voornaam = document.getElementById("voornaam");
    voornaam.style.color = 'red';
    
}

const handleLoad = () => {
    let button = document.getElementById("send");
    button.addEventListener("click", handleClick);
    let buttonWipe = document.getElementById("wipe");
    buttonWipe.addEventListener("click", handleWipe);
    let voornaam = document.getElementById("voornaam");
    voornaam.addEventListener("mouseover", handleHoover);
    let achternaam = document.getElementById("achternaam");
    achternaam.addEventListener("mouseover", handleHoover);
    let adres = document.getElementById("adres");
    adres.addEventListener("mouseover", handleHoover);


}
window.addEventListener("load", handleLoad);

