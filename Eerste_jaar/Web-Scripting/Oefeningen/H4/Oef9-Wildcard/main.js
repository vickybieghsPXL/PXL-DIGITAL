const handleClick = () => {
    let email = document.getElementById("input");
    let naam = document.getElementById("naam");
    let naam2 = document.getElementById("naam2");
    let subdomein = document.getElementById("subdomein");
    let domein = document.getElementById("domein");
    let emailPog = email.value;
    let array = [];
    
    var patt =  /[^a-z0-9]/ig;
    while(patt.test(emailPog) == true){
        array.push(patt.lastIndex)
        console.log(array);
    }
    naam.value = emailPog.substring(0, (array[0] -1));
    naam2.value = emailPog.substring(array[0], (array[1] -1));
    subdomein.value = emailPog.substring(array[1], (array[2] -1));
    domein.value = emailPog.substring(array[2], (array[2] + 7)); 
}
const handleLoad = () => {
    let button = document.getElementById("button");
    button.addEventListener("click", handleClick);
}
window.addEventListener("load", handleLoad);