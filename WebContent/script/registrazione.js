document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector("form");

    const campi = {
        nome: {
            input: document.getElementById("nome"),
            regex: /^[A-Za-zÀ-ù\s]{2,30}$/,
            msg: "Il nome deve contenere solo lettere (minimo 2)."
        },
        cognome: {
            input: document.getElementById("cognome"),
            regex: /^[A-Za-zÀ-ù\s]{2,30}$/,
            msg: "Il cognome deve contenere solo lettere (minimo 2)."
        },
        mail: {
            input: document.getElementById("mail"),
            regex: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
            msg: "Inserisci un indirizzo email valido."
        },
        password: {
            input: document.getElementById("password"),
            regex: /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/,
            msg: "La password deve contenere almeno 6 caratteri, di cui almeno una lettera e un numero."
        },
        indirizzo: {
            input: document.getElementById("indirizzo"),
            regex: /^.{5,100}$/,
            msg: "Inserisci un indirizzo valido (minimo 5 caratteri)."
        }
    };

    Object.keys(campi).forEach(chiave => {
        const campo = campi[chiave];
        campo.errorSpan = document.createElement("span");
        campo.errorSpan.className = "errore-js";
        campo.input.parentNode.insertBefore(campo.errorSpan, campo.input.nextSibling);

        campo.input.addEventListener("change", function() {
            validaCampo(campo);
        });
    });

    form.addEventListener("submit", function(event) {
        let formValido = true;

        Object.keys(campi).forEach(chiave => {
            const valido = validaCampo(campi[chiave]);
            if (!valido) formValido = false;
        });

        if (!formValido) {
            event.preventDefault();
        }
    });

    function validaCampo(campo) {
        if (!campo.regex.test(campo.input.value)) {
            campo.errorSpan.textContent = campo.msg;
            campo.errorSpan.classList.add("visibile");
            return false;
        } else {
            campo.errorSpan.textContent = "";
            campo.errorSpan.classList.remove("visibile");
            return true;
        }
    }
});