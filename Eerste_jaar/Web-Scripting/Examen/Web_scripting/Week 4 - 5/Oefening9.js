function handleLoad() {
    let buttonSplits = document.getElementById("buttonSplits");
    buttonSplits.addEventListener("click", handleClick);
}

function handleClick() {
    let email = document.getElementById("email").value;
    let naam = document.getElementById("naam");
    let naam2 = document.getElementById("naam2");
    let subdomein = document.getElementById("subdomein");
    let domein = document.getElementById("domein");

    //maak een array door middel van te splitsen op de '.'
    let fullString = email.split(".");

    //neem de stukken van de array
    let naamString = fullString[0];

    //de 2e naam en subdomein zijn gesplits d.m.v. een '@', dus deze moeten nog eens apart gesplitst worden
    //Voor naam2 neem je het 1e stuk van deze array dmv shift()
    let naam2String = fullString[1].split("@").shift();
    //voor het subdomein het 2e stuk van de array dmv pop()
    // !!!!!!!! Werkt niet als er nog meer punten zitten in de email
    let subdomeinString = fullString[1].split("@").pop();
    let domeinString = fullString[2];

    naam.value = naamString;
    naam2.value = naam2String;
    subdomein.value = subdomeinString;
    domein.value = domeinString;
}

window.addEventListener("load", handleLoad);