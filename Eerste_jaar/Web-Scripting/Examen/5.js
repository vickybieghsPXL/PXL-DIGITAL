
const MOUNTAINS = [
    {name: "Kilimanjaro", height: 5895, place: "Tanzania"},
    {name: "Everest", height: 8848, place: "Nepal"},
    {name: "Mount Fuji", height: 3776, place: "Japan"},
    {name: "Vaalserberg", height: 323, place: "Netherlands"},
    {name: "Denali", height: 6168, place: "United States"},
    {name: "Popocatepetl", height: 5465, place: "Mexico"},
    {name: "Mont Blanc", height: 4808, place: "Italy/France"}];

function yeet(){
    const table = document.createElement("table");
    document.body.appendChild(table);

    for(let i = 0; i < MOUNTAINS.length; i++){
        let tr = document.createElement("tr");
        table.append(tr);
        for(let j = 0; j < Object.values(MOUNTAINS[i]).length; j++){
            let th = document.createElement("th");
            let span = document.createElement("span");
            tr.append(th),
            span.innerText = Object.values(MOUNTAINS[i])[j] ;

            if(Object.values(MOUNTAINS[i])[j] === MOUNTAINS[i].height){
                th.style.textAlign = "right";
                th.style.color = "hotpink";
            } 
            else{th.style.textAlign = "left";}
            th.append(span);

        }
    }
}

function handleLoad() {
    yeet();
}

window.addEventListener("load", handleLoad);




