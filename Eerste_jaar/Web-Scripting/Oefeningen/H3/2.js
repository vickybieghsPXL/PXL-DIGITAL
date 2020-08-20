'use strict'
class Persoon {
    constructor(naam, voornaam, geboortedatum) {
        this._naam = naam;
        this._voornaam = voornaam;
        this._geboortedatum = geboortedatum;
    }
    set veranderNaam(naam){
        this._naam = naam;
    }
    set veranderVoornaam(voornaam){
        this._voornaam = voornaam;
    }
    set veranderleeftijd(geboortedatum){
        this._geboortedatum = geboortedatum;
    }
    get getnaam(){
        return this.naam;
    }
    get getvoornaam(){
        return this.voornaam;
    }
    get geboortedatum(){
        return this.geboortedatum;
    }
    print: function() {
        console.log
        
    }
    
}