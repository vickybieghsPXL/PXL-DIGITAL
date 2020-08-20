class Date {
    constructor(day, month, year){
        this._day = day;
        this._month = month;
        this._year = year;
    }

    static make(day, month, year) {
        return new Date(day, month, year);
    }

    print(){
        return this._day + "/" + this._month + "/" + this._year;
    }

    printMonth(){
        let MONTHS = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "okt", "nov", "dec"];

        return this._day + "/" + MONTHS[this._month - 1] + "/" + this._year;
    }

    get day() {
        return this._day;
    }

    set day(value) {
        this._day = value;
    }

    get month() {
        return this._month;
    }

    set month(value) {
        this._month = value;
    }

    get year() {
        return this._year;
    }

    set year(value) {
        this._year = value;
    }
}

let date1 = Date.make(15, 10, 1997);

console.log(date1.print());