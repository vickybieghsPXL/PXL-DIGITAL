window.addEventListener("load", loaded);

function loaded() {
    let divOutput = document.getElementById("div_output");
    let divSelect = document.getElementById("div_select");
    let urlPersons = 'http://localhost:3000/persons/';
    fetch(urlPersons)
        .then((response) => {
            if (response.status == 200) {
                return response.json();
            } else {
                throw `error with status ${response.status}`;
            }
        })
        .then((persons) => {
            let select = makeSelect(persons);
            divSelect.appendChild(select);
            //let buttonGetFriends =
            //    document.getElementById('get_friends');
            //buttonGetFriends.addEventListener("click",
            //    handleGetFriends);
        })
        .catch((error) => {
            divOutput.appendChild(document.createTextNode(error));
        });
}


function makeSelect(persons) {
    let select = document.createElement('select');
    select.setAttribute('id', 'select_id');
    for (let person of persons) {
        let option = document.createElement("option");
        option.appendChild(document.createTextNode(person.name));
        option.setAttribute('value', person.id);
        select.appendChild(option);
    }
    return select;
}

