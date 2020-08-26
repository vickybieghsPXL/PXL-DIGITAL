function createRoomRequest(payload) {
    const headers = new Headers({
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": 'Bearer ' + sessionStorage.getItem("userToken")

    });

    return fetch('https://localhost:44317/api/WaitingRooms',
        {
            method: "POST",
            body: JSON.stringify(payload),
            headers

        }
    );
}


async function create() {
    let allowed;
    let mode;
    (document.getElementById("toggle").checked) ? allowed = true : allowed = false;
    (document.getElementById("toggle2").checked) ? mode = 2 : mode = 1;
    const payload = {
        "name": document.getElementById("name").value,
        "gameSettings": {
            "codeLength": document.getElementById("slider4").value,
            "amountOfColors": document.getElementById("slider1").value,
            "duplicateColorsAllowed": allowed,
            "maximumAmountOfGuesses": document.getElementById("slider2").value,
            "amountOfRounds": document.getElementById("slider3").value,
            "mode": mode
        }
    };

    if (!payload.gameSettings.duplicateColorsAllowed) {
        if (payload.gameSettings.codeLength > payload.gameSettings.amountOfColors) {
            alert('The code length cannot be larger than the amount of colors if duplicate colors are not allowed');
            location.reload();
        }
    }

    const promise = await createRoomRequest(payload);
    if (promise.status === 201) {
        const json = await promise.json();

        sessionStorage.setItem('roomId', json.id);
        console.log(json);
        window.location.href = 'waitingroom.html';
    }
    else {
        alert('error');
    }

}


function handleLoad() {
    const button = document.getElementById("create-button");
    button.addEventListener("click", create);
}


window.addEventListener("load", handleLoad);