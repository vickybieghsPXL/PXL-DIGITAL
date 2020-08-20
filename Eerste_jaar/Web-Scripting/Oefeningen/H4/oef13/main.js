const handleClick = () => {
    let filtered = document.getElementById("filter");
    let inputdoc = document.getElementById("input1");
    let filterr = document.getElementById("input2");
    let array1 = [];
    let input = inputdoc.value;
    let filter = filterr.value;
    let array2 = [];
    array1 = input.split(" ");
    let shplit = array1.reverse();
    console.log(shplit);
    
    for(let i = 0; i < array1.length; i++ ){
        if(!array1[i].includes(filter)){
            array2.push(array1[i]);     
        }

    }

    document.getElementById("text").innerHTML = array2;
    document.getElementById("filter").innerHTML = array1.length - array2.length + " words filtered";

}

const handleLoad = () => {
    let button = document.getElementById("button");
    button.addEventListener("click", handleClick);
}
window.addEventListener("load", handleLoad);
