const handleLoad = () => {
    console.log("load");
    let buttonGenereer = document.getElementById("button_genereer");
    buttonGenereer.addEventListener("click", handleClick);
}

const handleClick = () => {
    console.log("ok")
    let inputVoornaam = document.getElementById("voornaam");
    let inputAchternaam = document.getElementById("achternaam");
    let Result = document.getElementById("melding");

    let voornaam = inputVoornaam.value;
    let achternaam = inputAchternaam.value;
    let welkomString;
    if (voornaam.length > 0 && achternaam.length > 0){
        welkomString = "Welkom, " + voornaam + " " + achternaam;
    } else {
        welkomString = "Alle velden invullen";
    }

    Result.value = welkomString;
}

window.addEventListener("load", handleLoad);