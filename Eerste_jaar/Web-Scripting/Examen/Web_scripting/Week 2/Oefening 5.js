function maakRij(min, max, stap) {
    let nummers = [];
    if (stap > 0) {
        for (let i = min; i <= max; i += stap) {
            nummers.push(i);
        }
        return nummers;
    } else {
        for (let i = max; i >= min; i += stap){
            nummers.push(i);
        }
        return nummers;
    }
}

let getallen = [];
getallen.push(maakRij(-10, 10, -2));
for (let number of getallen) {
    console.log(number);
}
