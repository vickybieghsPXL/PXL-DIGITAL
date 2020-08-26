function loginRequest(payload) {
    const headers = new Headers({
        'Content-type': 'application/json',
        'Accept': 'application/json'
    });
    return fetch('https://localhost:44317/api/Authentication/token',
        {
            method: 'POST',
            body: JSON.stringify(payload),
            headers
        })
}

function showWrongCredentials() {
    const div = document.getElementById("content");
    if (!document.getElementById('error')) {
        const error = document.createElement("p");
        error.id = 'error';
        error.innerText = 'Login failed wrong user credentials';
        error.style.color = 'red';
        div.append(error);
    }
}

async function login() {
    const payload = {
        "email": document.getElementById("inputEmail").value,
        "password": document.getElementById("inputPassword").value,
    };
    const response = await loginRequest(payload);
    if (response.status === 200) {
        const json = await response.json();

        sessionStorage.setItem('userToken', json.token);
        sessionStorage.setItem('userId', json.player.id);
        window.location.href = 'waitingroomlist.html';
    }
    else {
        showWrongCredentials();
    }
}

const handleLoad = () => {
    const loginButton = document.getElementById("submit-button");
    loginButton.addEventListener("click", login);
};

window.addEventListener("load", handleLoad);