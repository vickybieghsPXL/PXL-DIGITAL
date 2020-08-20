const MOUNTAINS = [
    {name: "Kilimanjaro", height: 5895, place: "Tanzania"},
    {name: "Everest", height: 8848, place: "Nepal"},
    {name: "Mount Fuji", height: 3776, place: "Japan"},
    {name: "Vaalserberg", height: 323, place: "Netherlands"},
    {name: "Denali", height: 6168, place: "United States"},
    {name: "Popocatepetl", height: 5465, place: "Mexico"},
    {name: "Mont Blanc", height: 4808, place: "Italy/France"}
];

function buildTable(data) {
    let table = document.createElement("table");

    let fields = Object.keys(data[0]);
    let headRow = document.createElement("tr");
    fields.forEach(function(field) {
        let headCell = document.createElement("th");
        headCell.textContent = field;
        headRow.appendChild(headCell);
    });
    table.appendChild(headRow);

    data.forEach(function(object) {
        let row = document.createElement("tr");
        fields.forEach(function(field) {
            let cell = document.createElement("td");
            cell.textContent = object[field];
            if (typeof object[field] == "number") {
                cell.style.textAlign = "right";
            }
            row.appendChild(cell);
        });
        table.appendChild(row);
    });

    return table;
}

document.querySelector("#mountains").appendChild(buildTable(MOUNTAINS));

window.addEventListener("load", handleLoad);

function handleLoad() {
    let ctx = document.getElementById("canvas").getContext("2d");

    for (let i = 0; i <= MOUNTAINS.length; i++){
        ctx.fillStyle = "black";
        let yAs = i * 40 + 50;
        let height = MOUNTAINS[i].height / 10;
        ctx.fillRect(200, yAs, height, 20);
        ctx.fillStyle = "white";
        ctx.strokeStyle = "green";
        ctx.lineWidth = 1;
        ctx.font = "20px Consolas";
        ctx.strokeText(MOUNTAINS[i].name, 0, yAs + 15);
        ctx.strokeStyle = "yellow";
        ctx.strokeText(MOUNTAINS[i].height, 250, yAs + 15);
    }
}