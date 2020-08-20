window.addEventListener("load", loaded);

function loaded() {
    let buttonPost = document.getElementById('button_post_person');
    buttonPost.addEventListener("click", handlePostPerson);
    let divOutput = document.getElementById("div_output");
    let divSelect = document.getElementById("div_select");
    let urlPersons = 'http://localhost:3000/persons/';
    makeElementEmpty(divSelect);    //als dit niet gedaan wordt, wordt na het toevoegen van een
    //nieuwe persoon een nieuwe select aangemaakt
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
            let buttonGetFriends = document.getElementById('get_friends');
            buttonGetFriends.addEventListener("click", handleGetFriends);
        })
        .catch((error) => {
            divOutput.appendChild(document.createTextNode(error));
        });
}

function handleGetFriends() {
    let url = 'http://localhost:3000/persons/';
    let select = document.getElementById("select_id");
    let id = select.value;
    let name = '';
    let output = document.getElementById("div_output");
    makeElementEmpty(output);
    fetch(url + id)
        .then((response) => {
            if (response.status == 200) {
                return response.json();
            } else {
                throw `error with status ${response.status}`;
            }
        })
        .then((person) => {
            name = person.name;
            let friends = person.friends;
            return friends;
        })
        .then((friends) => {
            let ids = friends.join("&id=");    // [1,2,3] --> 1&id=2&id=3
            makeElementEmpty(output);
            return fetch(url + `?id=${ids}`);  // .../?id=1&id=2&id=3
        })
        .then((response) => {
            if (response.status == 200) {
                return response.json();
            } else {
                throw `error with status ${response.status}`;
            }
        })
        .then((persons) => {
            let names = [];
            for (let person of persons) {
                names.push(person.name);
            }

            let textNode = document.createTextNode(name +
                ' heeft vrienden ' + names.join(", "));
            output.appendChild(textNode);
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
            //om de select aan te passen
            loaded();
        })
        .catch((error) => {
            output.appendChild(document.createTextNode(error));
        });
}