//1.a
let minimum = function (getal1, getal2) {
    if (getal1 < getal2){
        return getal1;
    } else if (getal2 < getal1) {
        return getal2;
    } else {
        console.log("De getallen zijn beide even groot");
    }
}

console.log(minimum(15, 11));

//1.b
let minMeerdere = function (...getallen) {
    if (getallen.length == 0){
        return undefined;
    }
    let kleinste = getallen[0];
    for (let number of getallen){
        if (number < kleinste){
            kleinste = number;
        }
    }
    return kleinste;
}

let nummers = [99, 56, 45, 33, 12, 1, 59, 101];
console.log(minMeerdere(...nummers));