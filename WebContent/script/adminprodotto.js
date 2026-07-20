document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector(".form-prodotto");

    if (!form) return;

    const campi = {
        nome: {
            input: document.getElementById("nome"),
            regex: /^.{2,100}$/,
            msg: "Il nome deve contenere almeno 2 caratteri."
        },
        descrizione: {
            input: document.getElementById("descrizione"),
            regex: /^.{5,500}$/,
            msg: "La descrizione deve contenere tra 5 e 500 caratteri."
        },
        categoria: {
            input: document.getElementById("categoria"),
            regex: /^.+$/,
            msg: "Seleziona una categoria."
        },
        prezzo: {
            input: document.getElementById("prezzo"),
            regex: /^\d+(\.\d{1,2})?$/,
            msg: "Inserisci un prezzo valido (es. 12.50)."
        },
        disponibilita: {
            input: document.getElementById("disponibilita"),
            regex: /^\d+$/,
            msg: "Inserisci una disponibilità valida (numero intero positivo)."
        },
        immagine: {
            input: document.getElementById("immagine"),
            regex: /^.{3,200}$/,
            msg: "Inserisci un percorso immagine valido."
        },
        mimeType: {
            input: document.getElementById("mimeType"),
            regex: /^[a-zA-Z]+\/[a-zA-Z0-9.+-]+$/,
            msg: "Inserisci un tipo MIME valido (es. image/png)."
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
        campo.input.addEventListener("input", function() {
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
        if (!campo.regex.test(campo.input.value.trim())) {
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