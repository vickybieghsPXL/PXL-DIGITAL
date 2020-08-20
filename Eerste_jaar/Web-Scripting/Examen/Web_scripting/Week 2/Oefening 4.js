function telB(woord) {
    return telChar(woord, "b");
}

console.log(telB("Bedrijfsbeheer"));

function telChar(woord, kar) {
    let teller = 0;
    for (let i = 0; i < woord.length; i++){
        if (woord.slice(i, i + 1).toLowerCase() == kar.toLowerCase()){
            teller++;
        }
    }
    return teller;
}

console.log(telChar("ik ben Sven en ik studeer Informatica", "e"));
