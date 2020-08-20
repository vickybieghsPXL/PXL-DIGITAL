let persoon = {
    voornaam: 'vippy',
    naam: 'reee',
    geboortedatum : new Date('January 1, 1997'),
    berekenleeftijd: function (){
        let vandaag = new Date();
        let dd = vandaag.getDate();
        let mm = vandaag.getMonth() + 1; //January is 0!
        let yyyy = vandaag.getFullYear();
        return (vandaag - this._geboortedatum) * 0.000000000031688;
    },
    print: function() {
        console.log(this.voornaam);
        console.log(this.berekenleeftijd());
    }
}

persoon.print();