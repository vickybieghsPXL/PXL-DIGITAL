class persoon{
    constructor(naam, voornaam, geboortedatum){
        this.naam = naam;
        this.voornaam = voornaam;
        this.geboortedatum = geboortedatum;
    }
    berekenLeeftijd(){
        let date = new Date(this.geboortedatum);
        let today = new Date();
        return today.getFullYear() - date.getFullYear();
    }
    print(){
        console.log(`${this.naam} ${this.voornaam} is ${this.berekenLeeftijd()} jaar oud`);
    }
}
let persoon1 = new persoon('bieghs', 'vicky', '1998-09-01')
persoon1.print();