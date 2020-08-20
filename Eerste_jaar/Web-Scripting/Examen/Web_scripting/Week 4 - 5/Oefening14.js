const handleLoad = () => {
    let wisButton = document.getElementById("wis_button");
    let verzendButton = document.getElementById("verzend_button");
    let wijzigButton = document.getElementById("wijzig_button");

    wisButton.addEventListener("click", handleWis);
    verzendButton.addEventListener("click", handleVerzend);

    let inputs = document.querySelectorAll("input");
    for (let input of (inputs)) {
        input.addEventListener("focus", event => {
            input.value = "";
            input.style.backgroundColor = "white";
            input.style.color = "red";
        });

        input.addEventListener("focusout", event => {
            input.style.color = "black";
            if (!(input.value == "")){
                input.style.backgroundColor = "lightgray";
            }
        });

        input.addEventListener("keydown", event => {
            wijzigButton.style.backgroundColor = "brown";
            wijzigButton.style.color = "white"
        });
        input.addEventListener("keyup", event => {
            wijzigButton.style.color = "black";
            wijzigButton.style.backgroundColor = "lightgray";
        })
    }

}

const handleWis = () => {
    let voornaamInput = document.getElementById("voornaam_input");
    let achternaamInput = document.getElementById("achternaam_input");
    let adresInput = document.getElementById("adres_input");

    voornaamInput.value = "";
    achternaamInput.value = "";
    adresInput.value = "";
    confirm("Alle gegevens werden gewist");
}

const handleVerzend = () => {
    confirm("Bedankt om het formulier te verzenden");
}

window.addEventListener("load", handleLoad);