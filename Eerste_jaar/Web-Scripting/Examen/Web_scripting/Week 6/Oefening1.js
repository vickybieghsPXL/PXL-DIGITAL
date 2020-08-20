window.addEventListener("load", loaded);

function loaded() {
    let buttonGetAllPersons = document.getElementById('button_get_all_persons');
    buttonGetAllPersons.addEventListener("click", handleGetAllPersons);
    let buttonGetPerson = document.getElementById('button_get_person');
    buttonGetPerson.addEventListener("click", handleGetPerson);
    let buttonPost = document.getElementById('button_post_person');
    buttonPost.addEventListener("click", handlePostPerson);
    let buttonGetNaam = document.getElementById('button_get_person_name');
    buttonGetNaam.addEventListener("click", handleGetPersonByName);
    let buttonPut = document.getElementById("button_put");
    buttonPut.addEventListener("click", handlePut);
    let buttons = document.querySelectorAll("button");
    for (let button of buttons){
        button.addEventListener("click", event => {
            let inputs = document.querySelectorAll("input");
            for (let input of inputs){
                input.value = "";
            }
        })
    }
}

function handlePut() {
    let url = 'http://localhost:3000/persons/';
    let personName = document.getElementById("txt_put_name").value;
    let personId = document.getElementById("txt_put_id").value;
    let output = document.getElementById("div_output");
    let person = {name: personName};
    makeElementEmpty(output);

    fetch(url + personId, {
        method: "PUT",
        body: JSON.stringify(person),
        headers: {
            //acccept en content-type zijn ALTIJD hetzelfde!
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        }
    })
        .then((response) => {
            if (response.status == 200) {
                return response.json();
            } else {
                throw `error with status ${response.status}`;
            }
        })
        .then((person) => {
            let data = [];
            data.push([person.id, person.name]);
            let table = makeTable(data);
            output.appendChild(table);
        })
        .catch((error) => {
            output.appendChild(document.createTextNode(error));
        });
}


function handleGetPersonByName() {
    let url = 'http://localhost:3000/persons/';
    let personName = document.getElementById("name_txt").value;
    let output = document.getElementById("div_output");
    makeElementEmpty(output);
    fetch(url + `?name=${personName}`)
        .then((response) => {
            if (response.status == 200) {
                return response.json();
            } else {
                throw `error with status ${response.status}`;
            }
        })
        .then((persons) => {
            let data = [];
            for (let person of persons) {
                data.push([person.id, person.name]);
            }
            let table = makeTable(data);
            output.appendChild(table);
        })
        .catch((error) => {
            output.appendChild(document.createTextNode(error));
        });
}


function handleGetAllPersons() {
    let url = 'http://localhost:3000/persons/';
    let output = document.getElementById("div_output");
    makeElementEmpty(output);
    fetch(url)
        .then((response) => {
            if (response.status == 200) {
                return response.json();
            } else {
                throw `error with status ${response.status}`;
            }
        })
        .then((persons) => {
            let data = [];
            for (let person of persons) {
                data.push([person.id, person.name]);
            }
            let table = makeTable(data);
            output.appendChild(table);
        })
        .catch((error) => {
            output.appendChild(document.createTextNode(error));
        });
}


function handleGetPerson() {
    let url = 'http://localhost:3000/persons/';
    let id = document.getElementById("txt_id").value;
    let output = document.getElementById("div_output");
    makeElementEmpty(output);
    if (id.trim() != '') {
        fetch(url + id)
            .then((response) => {
                if (response.status == 200) {
                    return response.json();
                } else {
                    throw `error with status ${response.status}`;
                }
            })
            .then((person) => {
                let data = [];
                data.push([person.id, person.name]);
                let table = makeTable(data);
                output.appendChild(table);
            })
            .catch((error) => {
                output.appendChild(document.createTextNode(error));
            });
    }
}


function handlePostPerson() {
    let url = 'http://localhost:3000/persons/';
    let output = document.getElementById("div_output");
    let name = document.getElementById("txt_name").value;
    let person = {name: name};
    makeElementEmpty(output);
    fetch(url,
        {
            method: "POST",
            body: JSON.stringify(person),
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
        .then((response) => {
            if (response.status == 201) {
                return response.json();
            } else {
                throw `error with status ${response.status}`;
            }
        })
        .then((person) => {
            let data = [];
            data.push([person.id, person.name]);
            let table = makeTable(data);
            output.appendChild(table);
        })
        .catch((error) => {
            output.appendChild(document.createTextNode(error));
        });
}


function makeElementEmpty(element) {
    while (element.hasChildNodes()) {
        element.removeChild(element.firstChild);
    }
}

function makeTable(matrix) {
    let table = document.createElement("table");
    for (let i = 0; i < matrix.length; i++) {
        let tr = document.createElement("tr");
        for (let j = 0; j < matrix[i].length; j++) {
            let td = document.createElement("td");
            td.appendChild(document.createTextNode(matrix[i][j]));
            tr.appendChild(td);
        }
        table.appendChild(tr);
    }
    return table;
}
