const handleClick  = () => {
    console.log("click");
    let inputPhrase = document.getElementById("inputPhrase");
    let inputFilter = document.getElementById("inputFilter");
    let outputDiv=document.getElementById('output');
    let phrase = inputPhrase.value;
    let filter = inputFilter.value;

    let split = phrase.split(" ");
    let splitFiltered=split.filter((value)=>value.toLowerCase().indexOf(filter.toLowerCase())===-1);
    for (let word of splitFiltered){
        let textnode=document.createTextNode(word);
        let element=document.createElement("span");
        element.setAttribute("class","gemarkeerd");
        element.appendChild(textnode);
        outputDiv.appendChild(element);
    }
};

const handleLoad = () => {
    let button = document.getElementById("generateMessageButton");
    button.addEventListener("click", handleClick);
};

window.addEventListener("load", handleLoad);