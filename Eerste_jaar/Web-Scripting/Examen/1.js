function minimum(numbers){
    let smallest = Number.POSITIVE_INFINITY;
    for(let i = 0; i < numbers.length; i++){
        if(numbers[i] < smallest){
            smallest = numbers[i];
        }
    }
    return smallest;
}

let array = [5, 3, 2, 8, 12, 1];
console.log(minimum(array));