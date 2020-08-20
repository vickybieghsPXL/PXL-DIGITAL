//1.a
let grootte = 15;
for (let i = "#"; i.length <= grootte; i += "#") {
    console.log(i);
}
//alternatief a
for (let i = 1; i <= grootte; i++) {
    console.log("#".repeat(i))
}

//1.b
for (let j = "#"; j.length <= grootte; j += "#") {
    let spatie = "";
    for (let s = 0; s < grootte - j.length; s++) {
        spatie = spatie + " ";
    }
    console.log(spatie + j);
}
//alternatief b
for (let i = 1; i <= grootte; i++) {
    console.log(" ".repeat(grootte - i) + "#".repeat(i));
}

//1.c
for (let i = "#"; i.length <= grootte * 2; i += "##") {
    let spatie = "";
    for (let s = 0; s < grootte * 2 - i.length; s += 2) {
        spatie = spatie + " ";
    }
    console.log(spatie + i);
}
//alternatief c
for (let i = 1; i <= grootte; i++) {
    console.log(" ".repeat(grootte - i) + "#".repeat(1 + 2 * (i - 1)));
}

//1.d
teller = 0;
for (let i = 0; i < grootte; i++) {
    let lijn = "";
    let spatie = "";
    for (let j = 0; j <= i * 2; j++) {
        if (teller % 5 == 0) {
            lijn += "@";
        } else {
            lijn += "#";
        }
        //alternatief if, else
        // lijn += teller % 5 == 0 ? "@" : "#";
        teller += 1;
    }
    for (let s = 0; s < grootte * 2 - lijn.length; s += 2) {
        spatie = spatie + " ";
    }
    console.log(spatie + lijn)
}
//alternatief d
let count = 0;
for (let i = 1; i <= grootte; i++) {
    let output = "";
    for (j = 0; j < 1 + 2 * (i - 1); j++) {
        output += count % 5 == 0 ? "@" : "#";
        count++;
    }
    console.log(" ".repeat(grootte - i) + output);
}