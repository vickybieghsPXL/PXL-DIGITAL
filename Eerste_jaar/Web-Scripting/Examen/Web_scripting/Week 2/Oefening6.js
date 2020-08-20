function reverseArray(...getallen) {
    let omnummers = [];
    while(getallen.length != 0){
        omnummers.push(getallen.pop());
    }
    return omnummers;
}

let numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

let omgekeerd = [];
omgekeerd = reverseArray(...numbers);

console.log(numbers);
console.log(omgekeerd);