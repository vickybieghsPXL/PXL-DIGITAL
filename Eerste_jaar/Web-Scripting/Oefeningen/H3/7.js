"use strict"
class Date { 
    constructor(day, month, year) {
        this._day = day;
        this._month = month;
        this._year = year;
    }
    print(){
        console.log(this._day + "/" + this._month + "/"  + this._year);
    }
    static get stom() {
        console.log(Date.ree);
        return Date.ree;
    }    
    printMonth(){
        console.log(this._day +  "/" + Date.stom[this._month - 1] + "/" + this._year);
    }

}

Date.ree = ["jan", "feb", "mar", "apr"];
let fuckjs = new Date(1, 2, 2019);
fuckjs.print();
fuckjs.printMonth();