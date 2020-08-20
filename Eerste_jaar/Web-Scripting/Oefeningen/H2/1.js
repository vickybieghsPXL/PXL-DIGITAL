function minimum(){
    let getal = +Infinity;
    for(let i =0; i < arguments.length; i++){
        if (arguments[i] < getal){
            getal = arguments[i];
        }    
    }
    return getal;   
}

console.log(minimum(1,8,15))
