//let grootte = Number(prompt("Geef de grootte van het schaakbord in"));

let lijn = "";
//for (let i = 0; i <= grootte; i++) {
for (let i = 0; i < 5; i++) {
    lijn = "";
    for (let j = 0; j < 10; j++) {
        if ((i + j) % 2 == 0) {
            lijn += "#";
        } else {
            lijn += " ";
        }
    }
    console.log(lijn);
}