let fibonnaci = function (nummer) {
    if (nummer == 0){
        return 1;
    } else if (nummer == 1) {
        return 1;
    } else {
        return fibonnaci(nummer - 2) + fibonnaci(nummer - 1);
    }
}

console.log(fibonnaci(10));