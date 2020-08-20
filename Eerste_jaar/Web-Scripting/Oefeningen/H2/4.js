function telB(n){
    return telChar(n, "B");
}

function telChar(n, char){
    n = n.split("");
    let tel = 0;
    for(let i = 0; i < n.length; i++){
        if (n[i] == char){
            tel = tel + 1;
        }
    }
    return tel;
}
console.log(telChar("VincentisGay", "i"));