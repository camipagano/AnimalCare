document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector("form");
    const mailInput = document.getElementById("mail");
    const passwordInput = document.getElementById("password");

    // Creiamo dinamicamente i contenitori per i messaggi d'errore nel DOM
    const mailError = document.createElement("span");
    mailError.className = "errore-js";
    mailInput.parentNode.insertBefore(mailError, mailInput.nextSibling);

    const passwordError = document.createElement("span");
    passwordError.className = "errore-js";
    passwordInput.parentNode.insertBefore(passwordError, passwordInput.nextSibling);

    // Regex per validare l'email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    // 1. Validazione all'evento "change" (quando l'utente esce dal campo)
    mailInput.addEventListener("change", function() {
        validaEmail();
    });
    passwordInput.addEventListener("change", function() {
        validaPassword();
    });

    // 2. Validazione all'evento "submit"
    form.addEventListener("submit", function(event) {
        const isEmailValid = validaEmail();
        const isPasswordValid = validaPassword();

        // Se uno dei campi non è valido, blocca l'invio del form al server
        if (!isEmailValid || !isPasswordValid) {
            event.preventDefault();
        }
    });

    function validaEmail() {
        if (!emailRegex.test(mailInput.value)) {
            mailError.textContent = "Inserisci un indirizzo email valido (es. nome@dominio.it).";
            mailError.style.color = "red";
            return false;
        } else {
            mailError.textContent = "";
            return true;
        }
    }

    function validaPassword() {
        if (passwordInput.value.trim() === "") {
            passwordError.textContent = "La password non può essere vuota.";
            passwordError.style.color = "red";
            return false;
        } else {
            passwordError.textContent = "";
            return true;
        }
    }
});