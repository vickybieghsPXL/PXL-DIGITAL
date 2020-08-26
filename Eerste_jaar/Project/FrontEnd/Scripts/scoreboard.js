function initScoreBoard() {
    const status = JSON.parse(sessionStorage.getItem('status'));
    const playerNames = JSON.parse(sessionStorage.getItem('players'));
    const winners = [];

    
    for (let i = 0; i < status.roundWinners.length; i++) {
        console.log(status.roundWinners[i]);
        winners[i] = status.roundWinners[i].nickName;
    }

    winners.sort().reverse();
    let players = {};
    for (let i = 0; i < winners.length; i++) {

        (players[winners[i]]) ? players[winners[i]]++ : players[winners[i]] = 1;
    }

    const table = document.getElementById("table");

    let rank = 1;
    for (let key in players) {
        if (key !== "Nobody") {
            const tr = document.createElement("tr");

            const tdRank = document.createElement("td");
            const tdPlayer = document.createElement("td");
            const tdWins = document.createElement("td");

            tdRank.innerText = rank.toString();
            tdPlayer.innerText = key;
            tdWins.innerText = players[key].toString();

            tr.append(tdRank);
            tr.append(tdPlayer);
            tr.append(tdWins);
            console.log(rank);
            table.append(tr);
            rank++;
        }
    }



}

function handleLoad() {
    initScoreBoard();
}

window.addEventListener("load", handleLoad);