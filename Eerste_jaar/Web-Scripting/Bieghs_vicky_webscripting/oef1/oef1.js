//Naam: Bieghs Vicky
class Persoon {
    constructor(id, naam) {
        function checkInput(){}
        try {
            if(id < 0 && !Number.isInteger(id)) {
                throw new Error("id moet groter dan 0 en een integer zijn");}
            if(typeof(naam) !== "string") {
                throw new Error("Naam moet een string zijn")
            }
            else {
                this._id = id
                this._naam = naam};
            }
        catch(error) {
            console.log(error);
        }
    }
    toString(){
        return(`[${this._id}] ${this._naam}` );
    }
    
}
class Loonwerker extends Persoon {
    constructor(id, naam, loonPerUur, aantalUrenGewerkt) {
        try{
            super(id, naam);
            if(loonPerUur < 0 && !Number.isInteger(id)) {
                throw new Error("loonperuur moet groter dan 0 en een integer zijn");
            }
            else if(aantalUrenGewerkt < 0 && !Number.isInteger(aantalUrenGewerkt)){
                throw new Error("aantalurengewerkt moet groter dan 0 en een integer zijn");
            }
            else{
                this._loonPerUur = loonPerUur;
                this._aantalUrenGewerkt = aantalUrenGewerkt;
            }
        }
            catch(error) { 
                console.log(error);
            }
    }
    berekenLoon(){
        return this._aantalUrenGewerkt * this._loonPerUur;
    }
    toString(){
        return super.toString() + `= ${this.berekenLoon()}`;
    }
}
class Manager extends Persoon {
    constructor(id, naam) {
        super(id, naam);
        this._loonWerkers=[];
    }
    voegLoonWerkerToe(loonWerker) {
        try {
            if(loonWerker != undefined) {
                this._loonWerkers.push(loonWerker);}
            else{throw new Error("geef waarde in")}    
        }
        catch(error){
            console.log(error);
        }
    }
    berekenLoon(){
        let totaal = 0
        for(let loon of this._loonWerkers){
            totaal += loon.berekenLoon();  
        }
        return Math.round(totaal * 0.2);
        
    }
    toString(){
        return super.toString() + ` = ${this.berekenLoon()}`;
    }
}

// naam: 

let persoon = new Persoon(1,"mieke");
let manager=new Manager(2,"jan");
let werker1=new Loonwerker(3,"tim",11,13);
let werker2=new Loonwerker(4,"sofie",2,50);
manager.voegLoonWerkerToe(werker1);
manager.voegLoonWerkerToe(werker2);
console.log(persoon.toString());
// [1] mieke 
console.log(werker1.toString());
// [3] tim = 143
console.log(werker2.toString());
// [4] sofie = 100
console.log(manager.toString());
// [2] jan = 49 

