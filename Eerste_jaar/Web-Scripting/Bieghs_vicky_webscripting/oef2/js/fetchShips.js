// naam: Bieghs Vicky

function handleWindowload() {
    let url = 'http://localhost:3000/country/';
    fetch(url)
    .then((response) => {
        if(response.status === 200 ){
            return response.json();
        }
        else {
            throw `error: ${response.status}`;
        }
    })
    .then((result) =>{
        let countries = [];
        for (let country of result) {
            countries.push(country);
        }
        let select = document.createElement("select");
        select.id = "select_country";
        document.getElementById("div_select").append(select);
        for(let i = 0; i < countries.length; i++){
            let options = document.createElement("option");
            options.value = result[i].id;
            options.innerText = result[i].name;
            select.append(options);
        }
    })
    .catch((error)=>{
        console.log(error);
    });
}

function handleGetShips() {
    let url = 'http://localhost:3000/ship/';
    fetch(url)
    .then((responseShips) => {
        if(responseShips.status === 200 ){
            return responseShips.json();
        }
        else {
            throw `error: ${responseShips.status}`;
        }
    })
    .then((resultShips)=> {
        let ships = [];
        for (let ship of resultShips) {
            ships.push(ship);
        }
        let selected = document.getElementById("select_country").value;
        let ul = document.createElement("ul");
        document.getElementById("div_output").append(ul);
        let max = 0;
        for(let i = 0; i < ships.length; i++){
            if(ships[i].country_id == selected){
                let li = document.createElement("li");
                    if(ships[i].speed >= max){
                        max = ships[i].speed;
                        speed = ships[i].speed;
                        li.style.color = "red";
                        }
                    li.innerText = ships[i].id + ", " + ships[i].name;
                    ul.append(li);
                    }
                }

    })
}
const handleLoad = () => {
    handleWindowload();
    let button = document.getElementById("get_ships");
    button.addEventListener("click", handleGetShips);
}
window.addEventListener("load", handleLoad);

