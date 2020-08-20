let persoon = {
    naam : "Wynants",
    voornaam : "Sven",
    geboortedatum : new Date(1997, 10, 15),

    berekenLeeftijd : function () {
        let now = new Date();
        let verjaardagDitJaar = new Date(now.getFullYear(), this.geboortedatum.getMonth(), this.geboortedatum.getDate());
        let verschilInJaren = now.getFullYear() - this.geboortedatum.getFullYear();
        if (now < verjaardagDitJaar){
            verschilInJaren--;
        }
        return verschilInJaren;
    }
}
console.log(persoon.berekenLeeftijd());