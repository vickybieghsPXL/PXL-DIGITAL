let player = {
    "guesses": 0,
    "currentRoundNumber": 1,
    "payload": []
};

function getGameRequest(id){
    const url = "https://localhost:44317/api/Games/" + id;
    const headers = new Headers({
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + sessionStorage.getItem("userToken")
    });
    return fetch(url, {
        method: 'GET',
        headers
    })
}

function canGuessRequest(id, roundNumber){
    const url = "https://localhost:44317/api/Games/" + id + "/canguess/forround/" + roundNumber;
    const headers = new Headers({
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + sessionStorage.getItem("userToken")
    });
    return fetch(url, {
        method: 'GET',
        headers
    });
}

function guessRequest(id, payload){
    const url = "https://localhost:44317/api/Games/" + id + "/guess";
    const headers = new Headers({
        "Content-Type": "application/json",
        "Authorization": 'Bearer ' + sessionStorage.getItem("userToken")
    });
    return fetch(url, {
        method: 'POST',
        headers,
        body: JSON.stringify(payload)
    });

}

function getStatusRequest(id) {
    const url = "https://localhost:44317/api/Games/" + id + "/status";
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

async function fillSquare(color) {
    const classId = "guess " + (player.guesses + 1).toString();
    const div = document.getElementById(classId);
    const span = div.children[player.payload.length];
    player.payload.push(color);
    span.classList.remove("grey");
    console.log(color);
    span.className += " " + color;
}

async function addColor(color, codeLength) {
    if (player.payload.length < codeLength) {
        fillSquare(color);
    }
}

function createGameBoard(maxOfGuesses, amountOfColors, possibleColors, codeLength){
    const board = document.getElementById("game-board");
    console.log(maxOfGuesses);
    console.log(amountOfColors);

    // creates the board with the guesses rows with their right id's
    for (let i = maxOfGuesses; i > 0; i--){
        const div = document.createElement("div");
        div.id = "guess " + i.toString();

        // creates grey color to put in guesses
        for (let j = 0; j < codeLength; j++){
            const span = document.createElement("span");
            span.className = "circle grey guess";
            div.append(span);
        }

        // creates the dots which answers if a guess is right color and or place
        for (let j = 0; j < codeLength; j++){
            const span = document.createElement("span");
            span.className = "dot grey";
            div.append(span);
        }

        const br = document.createElement("br");
        div.append(br);
        board.append(div);
    }

    // creates the user input bar with the amount of colors and the right color
    const div = document.createElement("div");
    const div2 = document.createElement("div");
    div.id = "center";
    div2.id = "user-input";
    document.getElementById("game-board").append(div);
    document.getElementById("center").append(div2);
    let sound = new Audio("Sound/zapsplat_multimedia_click_003_19369.mp3");
    for (let i = 0; i < amountOfColors; i++ ){
        const button = document.createElement("button");
        button.id = possibleColors[i];
        button.className = "circle " + possibleColors[i] + " input" + " btn";
        button.onclick = () => {
            sound.play();
        };
        document.getElementById("user-input").append(button);
    }
    div.append(document.createElement("br"));

    // creates the guess button
    const guessButton = document.createElement("button");
    guessButton.id = "guess-button";
    guessButton.className = "guess-button";
    guessButton.innerText = "Guess";
    document.getElementById("game").append(guessButton);

    const resetButton = document.createElement("button");
    resetButton.className = "reset-button";
    resetButton.id = "reset-button";
    resetButton.innerText = "Reset";
    resetButton.onclick = reset;
    document.getElementById("game").append(resetButton);
    board.append(div);
}

function fillPins(json) {
    console.log(json);
    const correctColorAndPosition = json.correctColorAndPositionAmount;
    const correctColorAmount = json.correctColorAmount;

    const dots = document.getElementById("guess " + player.guesses).getElementsByClassName("dot");
    console.log(dots);
    for (let i = 0; i < correctColorAndPosition; i++) {
        dots[i].classList.remove("grey");
        dots[i].className += " red";
    }
    for (let i = correctColorAndPosition; i < correctColorAmount + correctColorAndPosition; i++) {
        dots[i].classList.remove("grey");
        dots[i].className += " white";
    }

    console.log(dots);
}

function reset() {
    const guess = player.guesses;
    for (let i = 0; i < player.payload.length; i++) {
        const div = document.getElementById("guess " + ((guess + 1).toString()));
        div.children[i].className = "circle grey guess";
    }
    player.payload = [];
}

function resetGameBoard() {
    const buttons = document.getElementsByClassName("guess");
    const dots = document.getElementsByClassName("dot");
    console.log(buttons);
    console.log(dots);
    for (let i = 0; i < buttons.length; i++) {
        buttons[i].className = "circle grey guess";
        dots[i].className = "dot grey";
    }
}

async function guess(codeLength) {
    const game = await getGame();
    const status = await canGuess(game.id, game.currentRound);

    if (status === 1) {
        console.log(codeLength);
        if (player.payload.length === codeLength) {
            const payload = {
                "colors": player.payload
            };
            const id = sessionStorage.getItem("gameId");
            const response = await guessRequest(id, payload);
            if (response.status === 200){
                player.guesses++;
                player.payload = [];

                const json = await response.json();
                console.log(json);

                fillPins(json);
            }

        }
    }
    else if (status === 500) {
        alert('not your turn');
    }
}

async function getStatus(id) {
    const response = await getStatusRequest(id);
    if (response.status === 200) {
        return await response.json();
    }
}

async function canGuess(id, roundNumber){
    const response = await canGuessRequest(id, roundNumber);
    return response.json();

}

async function getGame(){
    const id = sessionStorage.getItem('gameId');
    const response = await getGameRequest(id);
    if (response.status === 200){
        return await response.json();
    }
}

async function updateGame(gameId, maximumAmountOfGuesses, amountOfRounds) {
    const status = await getStatus(gameId);

    if (player.currentRoundNumber < status.currentRoundNumber) {
        resetGameBoard();
        updateScoreBoard(status);
        player.guesses = 0;
        player.currentRoundNumber++;
        if (status.roundWinners[status.currentRoundNumber - 2].id === sessionStorage.getItem('userId')) {
            console.log(status.currentRoundNumber + " in if");
            let sound = new Audio("Sound/GuessCorrect.mp3");
            await sound.play();
            alert('You have guessed the code');
        }
        else {
            console.log(status.currentRoundNumber + " in else");
            alert(status.roundWinners[status.currentRoundNumber - 2].nickName + ' has guessed the code')
        }
    }
    if (player.currentRoundNumber > amountOfRounds) {
        sessionStorage.setItem('status', JSON.stringify(status));
        const waitingroomId = sessionStorage.getItem('roomId');
        const response = await leaveWaitingRoomRequest(waitingroomId);
        if (response.status) {
            window.location.href = 'scoreboard.html';
        }
    }
}

function updateScoreBoard(status) {
    console.log(status.currentRoundNumber + " in update scoreboard");
    const table = document.getElementById('table-score-board');
    const tr = document.createElement('tr');
    const winner = status.roundWinners[status.currentRoundNumber - 2].nickName;
    const round = status.currentRoundNumber - 1;

    const tdWinner = document.createElement('td');
    tdWinner.innerText = winner;
    const tdRound = document.createElement('td');
    tdRound.innerText = round;
    table.append(tr);
    tr.append(tdRound);
    tr.append(tdWinner);
}

async function loadGame(gameId, maximumAmountOfGuesses, amountOfColors,
                        possibleColors, codeLength) {
    console.log(game);
    createGameBoard(maximumAmountOfGuesses, amountOfColors, possibleColors,
        codeLength);
}

async function handleLoad() {
    const gameId = sessionStorage.getItem('gameId');
    const game = await getGame();

    sessionStorage.setItem('players', JSON.stringify(game.players));

    await loadGame(gameId, game.settings.maximumAmountOfGuesses, game.settings.amountOfColors,
        game.possibleColors, game.settings.codeLength);

    //add event listeners
    const buttons = document.getElementsByClassName("input");
    for (let i = 0; i < buttons.length; i++) {
        buttons[i].addEventListener("click", () => {
            console.log(buttons[i]);
            addColor(buttons[i].id, game.settings.codeLength);
        })
    }
    const guessButton = document.getElementById("guess-button");
    console.log(guessButton);
    guessButton.addEventListener("click", () => {
        guess(game.settings.codeLength);
    });

    let sound = new Audio("Sound/begin.mp3");
    await sound.play();

    setInterval(()=> {
        updateGame(game.id, game.settings.maximumAmountOfGuesses, game.settings.amountOfRounds);
    }, 1000);
}

window.addEventListener("load", handleLoad);
