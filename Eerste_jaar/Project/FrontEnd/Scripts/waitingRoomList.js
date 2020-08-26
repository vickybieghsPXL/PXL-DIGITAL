function getWaitingRoomsRequest() {
    const url = 'https://localhost:44317/api/WaitingRooms';
    const headers = new Headers({
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + sessionStorage.getItem("userToken")
    });

    return fetch(url, {
        method: 'GET',
        headers
    });
}

function joinWaitingRoomRequest(roomId) {
    const url = 'https://localhost:44317/api/WaitingRooms/' + roomId + '/join';
    const headers = new Headers({
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + sessionStorage.getItem("userToken")
    });

    return fetch(url, {
        method: 'POST',
        headers
    });
}

async function join() {
    const roomId = document.getElementsByClassName('button').namedItem(this.id).id;
    const response = await joinWaitingRoomRequest(roomId);
    if (response.status === 200) {
        sessionStorage.setItem('roomId', roomId);
        window.location.href = 'waitingroom.html';
    }
}

async function initList() {
    const response = await getWaitingRoomsRequest();
    if (response.status === 200) {
        const json = await response.json();

        const rooms = document.getElementById("rooms");

        for (let i = 0; i < json.length; i++) {
            if (document.getElementById(json[i].id)) {
                const tdPlayers = document.getElementsByTagName('td')[2];
                tdPlayers.innerText = json[i].users.length + '/' + json[i].maximumAmountOfUsers;
            }
            else {
                const tr = document.createElement("tr");

                const tdNumber = document.createElement("td");
                tdNumber.innerText = i + 1;

                const tdName = document.createElement("td");
                tdName.innerText = json[i].name;

                const tdPlayers = document.createElement("td");
                tdPlayers.innerText = json[i].users.length + '/' + json[i].maximumAmountOfUsers;

                const td = document.createElement("td");

                const divButton = document.createElement("div");
                divButton.className = "button";
                const a = document.createElement("a");
                a.href = "#";
                a.innerText = "Join";
                const span = document.createElement("span");
                const divMask = document.createElement("div");
                divMask.className = "mask";

                divButton.id = json[i].id;
                divButton.onclick = join;

                rooms.append(tr);
                tr.append(tdNumber);
                tr.append(tdName);
                tr.append(tdPlayers);
                tr.append(td);
                td.append(divButton);
                divButton.append(a);
                a.append(span);
                divButton.append(divMask);
            }
        }
    }
}
function handleLoad() {
    initList();
    setInterval(() => {
        initList();
    }, 2000);
}
window.addEventListener("load", handleLoad);