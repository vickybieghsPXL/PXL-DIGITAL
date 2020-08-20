function reverseArray(array){
    let list = [];
    for(let i = 0; i < array.length; i++){
        list.push(array[(array.length)-i-1]);
    }
    return list;
}

console.log(reverseArray([5,8,6,2]));