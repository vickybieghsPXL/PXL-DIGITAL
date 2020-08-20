const handleClick = () => {
    let stylesheet = document.getElementById("stylesheet");
    stylesheet.href = 'style/opmaak1.css';

}
const handleClick2 = () => {
    let stylesheet = document.getElementById("stylesheet");
    stylesheet.href = 'style/opmaak2.css';
}

const handleLoad = () => {
    let button = document.getElementById("knopOpmaak1");
    button.addEventListener("click", handleClick);
}
const handleLoad2 = () => {
    let button = document.getElementById("knopOpmaak2");
    button.addEventListener("click", handleClick2);
}
window.addEventListener("load", handleLoad);
window.addEventListener("load", handleLoad2);