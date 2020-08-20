function handleLoad() {
    let pictures = document.querySelectorAll("img");
    for (let picture of (pictures)){
        picture.addEventListener("dblclick", handleClick);
    }
}

function handleClick() {

}

window.addEventListener("load", handleLoad);