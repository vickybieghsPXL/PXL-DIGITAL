let isEven = function (getal) {
    if (getal == 0){
        return true;
    } else if (getal == 1){
        return false;
    }
    return isEven(getal - 2);
}

console.log(isEven(58));