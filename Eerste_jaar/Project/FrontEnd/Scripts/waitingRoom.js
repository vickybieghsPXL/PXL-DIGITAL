function getWaitingRoomByIdRequest(roomId) {
    const url = 'https://localhost:44317/api/WaitingRooms/' + roomId;
    const headers = new Headers({
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + sessionStorage.getItem("userToken")
    });

    return fetch(url, {
        method: 'GET',
        headers
    });
}

function leaveWaitingRoomRequest(roomId) {
    const url = 'https://localhost:44317/api/WaitingRooms/' + roomId + '/leave';
    const headers = new Headers({
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + sessionStorage.getItem("userToken")
    });

    return fetch(url, {
        method: 'POST',
        headers
    });
}

function createGameRequest(roomId) {
    const url = 'https://localhost:44317/api/Games?waitingRoomId=' + roomId;
    const headers = new Headers({
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + sessionStorage.getItem("userToken"),
    });

    return fetch(url, {
        method: 'POST',
        headers
    });
}

async function initPage() {
    const roomId = sessionStorage.getItem('roomId');
    const response = await getWaitingRoomByIdRequest(roomId);

    if (response.status === 200) {
        const json = await response.json();
        //console.log(json);
        //console.log(json.gameHasStarted);
        console.log(json.gameHasStarted);
        if (json.gameHasStarted) {
            sessionStorage.setItem('gameId', json.gameId);
            console.log(json.gameId);
            window.location.href = 'game.html';
        }
        else {
            for (let i = 0; i < 5; i++) {
                document.getElementById((i + 1).toString()).style.backgroundImage = 'linear-gradient(rgba(114,0,154,1),rgba(203,61,223,0.4), rgba(0,0,0,0.1))';
                document.getElementById("nickName"+ (i + 1).toString()).innerText = "";
                document.getElementById('player' + (i + 1).toString()).innerText = "";
            }

            document.getElementById("title").innerText = json.name;
            document.getElementById("room-id").innerText = json.id;
            document.getElementById("user-amount").innerText = json.users.length + ' / ' + json.maximumAmountOfUsers;
            for (let i = 0; i < json.users.length; i++) {
                document.getElementById((i + 1).toString()).style.backgroundImage = 'linear-gradient(rgba(114,0,154,1),rgba(203,61,223,0.4), rgba(0,0,0,0.1))';
                document.getElementById("nickName"+ (i + 1).toString()).innerText = json.users[i].nickName;


                if (i === 0 ){
                    document.getElementById('player' + (i + 1).toString()).innerText = 'OWNER' + '\n';
                } else{
                    document.getElementById('player' + (i + 1).toString()).innerText = 'PLAYER ' + (i) + '\n';
                }

            }
        }

    }

    else {
        window.location.href = 'waitingroomlist.html';
    }
}


async function leave() {
    const roomId = sessionStorage.getItem('roomId');
    const response = await leaveWaitingRoomRequest(roomId);
    if (response.status) {
        sessionStorage.removeItem('roomId');
        window.location.href = 'waitingRoomList.html';
    }
}

async function start() {
    const roomId = sessionStorage.getItem('roomId');
    const response = await createGameRequest(roomId);

    if (response.status === 201) {
        const json = await response.json();
        sessionStorage.setItem('gameId', json.id);
        console.log(json);
        window.location.href = 'game.html';
        console.log(json);
    }
    else {
        console.log(response);
    }


}


function handleLoad() {
    const leaveButton = document.getElementById("leave-button");
    leaveButton.addEventListener("click", leave);
    const startButton = document.getElementById('start-button');
    startButton.addEventListener('click', start);

    initPage();
    setInterval(() => {
        initPage();
    }, 2000);

}

window.addEventListener("load", handleLoad);
