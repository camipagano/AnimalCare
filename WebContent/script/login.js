document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector("form");
    const mailInput = document.getElementById("mail");
    const passwordInput = document.getElementById("password");

    const mailError = document.createElement("span");
    mailError.className = "errore-js";
    mailInput.parentNode.insertBefore(mailError, mailInput.nextSibling);

    const passwordError = document.createElement("span");
    passwordError.className = "errore-js";
    passwordInput.parentNode.insertBefore(passwordError, passwordInput.nextSibling);

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    mailInput.addEventListener("change", function() {
        validaEmail();
    });
    passwordInput.addEventListener("change", function() {
        validaPassword();
    });

    form.addEventListener("submit", function(event) {
        const isEmailValid = validaEmail();
        const isPasswordValid = validaPassword();

        if (!isEmailValid || !isPasswordValid) {
            event.preventDefault();
        }
    });

    function validaEmail() {
        if (!emailRegex.test(mailInput.value)) {
            mailError.textContent = "Inserisci un indirizzo email valido (es. nome@dominio.it).";
            mailError.classList.add("visibile");
            return false;
        } else {
            mailError.textContent = "";
            mailError.classList.remove("visibile");
            return true;
        }
    }

    function validaPassword() {
        if (passwordInput.value.trim() === "") {
            passwordError.textContent = "La password non può essere vuota.";
            passwordError.classList.add("visibile");
            return false;
        } else {
            passwordError.textContent = "";
            passwordError.classList.remove("visibile");
            return true;
        }
    }
});