function logout() {
    localStorage.clear();
    window.location.href = "login.html";
}

function handleLoad() {
    const username = localStorage.getItem('nickName');
    console.log(username);
    const title = document.getElementById("title");
    title.innerText = "Welcome " + username;
    const create = document.getElementById("create-waitingroom");
    const join = document.getElementById("join-waitingroom");
    create.addEventListener("click", createWaitingRoom);
    join.addEventListener("click", joinWaitingroom);
    const logoutButton = document.getElementById("log-out");
    logoutButton.addEventListener("click", logout)
}

function joinWaitingroom(){
    window.location.href = "waitingRoomList.html";
}

function createWaitingRoom() {
    window.location.href = "gamesettings.html";
}


window.addEventListener("load", handleLoad);
