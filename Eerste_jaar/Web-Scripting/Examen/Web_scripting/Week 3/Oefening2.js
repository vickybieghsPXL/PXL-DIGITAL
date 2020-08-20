class persoon {
    constructor(naam, voornaam, geboortedatum){
        this._naam = naam;
        this._voornaam = voornaam;
        this._geboortedatum = geboortedatum;
    }

    get naam() {
        return this._naam;
    }

    set naam(naam) {
        this._naam = naam;
    }

    get voornaam() {
        return this._voornaam;
    }

    set voornaam(voornaam) {
        this._voornaam = voornaam;
    }

    get geboortedatum() {
        return this._geboortedatum;
    }

    set geboortedatum(geboortedatum) {
        this._geboortedatum = geboortedatum;
    }

    berekenLeeftijd(){
        //new date zonder argumenten is automatisch de huidige datum en tijd
        let now = new Date();
        let verjaardagDitJaar = new Date(now.getFullYear(), this.geboortedatum.getMonth(), this.geboortedatum.getDate());
        let verschilInJaren = now.getFullYear() - this.geboortedatum.getFullYear();
        if (now < verjaardagDitJaar){
            verschilInJaren--;
        }
        return verschilInJaren;
    }
}

let persoon1 = new persoon("Wynants", "Sven", new Date(1997, 10, 15));
console.log(persoon1.berekenLeeftijd());