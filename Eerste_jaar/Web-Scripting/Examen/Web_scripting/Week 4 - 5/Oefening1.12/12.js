let handleChangeLayout = (event) => {
    let linkStylesheet = document.getElementById('stylesheet');

    if (event.target.textContent === 'Opmaak 1') {
        linkStylesheet.href = 'opmaak1.css';
    } else {
        linkStylesheet.href = 'opmaak2.css';
    }
};

const handleLoad = () => {
    let btnOpmaak1 = document.getElementById("knopOpmaak1");
    let btnOpmaak2 = document.getElementById("knopOpmaak2");
    btnOpmaak1.addEventListener('click', handleChangeLayout);
    btnOpmaak2.addEventListener('click', handleChangeLayout);
};

window.addEventListener("load", handleLoad);