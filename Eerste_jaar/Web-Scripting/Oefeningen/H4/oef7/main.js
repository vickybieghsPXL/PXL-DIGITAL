const handleClick = () => {
    let getal = document.getElementById("getal");
    let output1 = document.getElementById("output");
    let foutmelding = "Getal moet groter dan 0 en kleiner dan 50 zijn";
    let getal2 = getal.value;
    var array = []
    if(getal.value > 50 || getal.value < 0){
        console.log("fy");
        output1.value = foutmelding;
        
    } else{ 
        while(getal2 > 1){
            array.unshift(getal2 - 2);
            getal2 = getal2 -2;
            console.log(array);
        }
        console.log(array);
        output1.value = array;
    }

   
    
}

const handleLoad = () => {
    let button = document.getElementById("button");
    button.addEventListener("click", handleClick);
}
window.addEventListener("load", handleLoad);
