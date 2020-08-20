function handleChangeFontsize() {
    let pVoorbeeld = document.getElementById("p_voorbeeld");
    let selectFontsize = document.getElementById("select_fontsize");
    pVoorbeeld.style.fontSize = selectFontsize.value;
}

function handleChangeFont() {
    let pVoorbeeld = document.getElementById("p_voorbeeld");
    let selectLettertype = document.getElementById("select_lettertype");
    pVoorbeeld.style.fontFamily = selectLettertype.value;
}

function handleLoad(){
    let selectLettertype = document.getElementById("select_lettertype");
    selectLettertype.addEventListener("change", handleChangeFont);
    let selectFontsize = document.getElementById("select_fontsize");
    selectFontsize.addEventListener("change", handleChangeFontsize);
}

window.addEventListener("load", handleLoad);