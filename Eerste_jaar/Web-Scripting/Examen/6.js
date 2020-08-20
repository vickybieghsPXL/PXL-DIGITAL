
class Name {
    constructor(firstName, Lastname){
        this.firstName = firstName;
        this.Lastname = Lastname;
    }
    toString() {
        if(!this.firstName  || !this.Lastname){
            return "fill in all the boxes, retard";
        }
        else{return(`hollaaa ${this.firstName} ${this.Lastname}`);}
    }
}

function handleClick() {
    let firstName = document.getElementById("firstName").value;
    let Lastname = document.getElementById("lastName").value;
    let output = document.getElementById("output");
    let yeet = new Name(firstName, Lastname) ;
    output.value = yeet.Tostring();
}
//window eventlist
const handleLoad = () => {
    let buttonGenereer = document.getElementById("button");
    buttonGenereer.addEventListener("click", handleClick);
}
window.addEventListener("load", handleLoad);