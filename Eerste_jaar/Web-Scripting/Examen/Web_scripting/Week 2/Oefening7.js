function berekenAfstand(point1, point2) {
    let afstand = Math.pow((point1.x - point2.x), 2) + Math.pow((point1.y - point2.y), 2);
    afstand = Math.sqrt(afstand);
    return afstand;
}

let punt1 = {x:1, y:1};
let punt2 = {x:2, y:3};

console.log(berekenAfstand(punt1, punt2));