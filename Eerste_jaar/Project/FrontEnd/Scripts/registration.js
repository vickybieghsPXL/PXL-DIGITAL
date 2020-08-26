function registerRequest(payload) {
    return fetch('https://localhost:44317/api/Authentication/register',
        {
            method: 'POST',
            body: JSON.stringify(payload),
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        });
}

function showErrors(reason) {
    if (reason.InvalidUsername) {
        console.log(reason.InvalidUsername[0]);
        document.getElementById('email-error').innerText = reason.InvalidUsername[0];
        document.getElementById('email-error').style.color = 'red';
    }
    if (reason.DuplicateUserName) {
        console.log(reason.DuplicateUserName[0]);
        document.getElementById('email-error').innerText = reason.DuplicateUserName[0];
        document.getElementById('email-error').style.color = 'red';
    }
    if (reason.errors) {
        if (reason.errors.Email) {
            document.getElementById('email-error').innerText = reason.errors.Email[0];
            document.getElementById('email-error').style.color = 'red';
        }
        if (reason.errors.Password) {
            document.getElementById('password-error').innerText = reason.errors.Password[0];
            document.getElementById('password-error').style.color = 'red';
        }

    }
}


async function register() {
    const payload = {
        "email": document.getElementById("inputEmail").value,
        "password": document.getElementById("inputPassword").value,
        "nickName": document.getElementById("inputNickname").value
    };


    const response = await registerRequest(payload);
    if (response.status === 200) {
        window.location.href = 'login.html';
    }
    else {
        const json = await response.json();
        showErrors(json);
    }
}

function giveMissingChars() {
    let password = document.getElementById("inputPassword").value;
    document.getElementById('password-error').style.visibility = 'visible';
    document.getElementById('password-error').style.display = 'block';

    (/[A-Z]/.test(password)) ? document.getElementById('uppercase').style.display = 'none' : document.getElementById('uppercase').style.display = 'block';
    (/[A-Z]/.test(password)) ? document.getElementById('lowercase').style.display = 'none' : document.getElementById('uppercase').style.display = 'block';
    (/[0-9]/.test(password)) ? document.getElementById('number').style.display = 'none' : document.getElementById('number').style.display = 'block';
    (/[$%#]/.test(password)) ? document.getElementById('special').style.display = 'none' : document.getElementById('special').style.display = 'block';
    (password.length >= 6) ? document.getElementById('length').style.display = 'none' : document.getElementById('length').style.display = 'block';
}

function doPasswordsMatch() {
    document.getElementById('confirm-password-error').style.visibility = 'visible';
    document.getElementById('confirm-password-error').style.display = 'block';


    (document.getElementById('inputPassword').value === document.getElementById('inputConfirmPassword').value) ? document.getElementById('is-correct').style.display = 'none'  :
        document.getElementById('is-correct').style.display = 'block';
}


function handleLoad() {
    let registerButton = document.getElementById("submit-button");
    registerButton.addEventListener("click", register);
}


window.addEventListener("load", handleLoad);
