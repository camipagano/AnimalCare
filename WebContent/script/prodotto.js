document.addEventListener("DOMContentLoaded", function() {

    // --- Validazione form recensioni ---
    const formRecensione = document.querySelector(".recensioni form");

    if (formRecensione) {
        const commentoInput = document.getElementById("commento");
        const commentoRegex = /^.{5,500}$/;

        const commentoError = document.createElement("span");
        commentoError.className = "errore-js";
        commentoInput.parentNode.insertBefore(commentoError, commentoInput.nextSibling);

        commentoInput.addEventListener("change", function() {
            validaCommento();
        });

        formRecensione.addEventListener("submit", function(event) {
            const commentoValido = validaCommento();

            if (!commentoValido) {
                event.preventDefault();
            }
        });

        function validaCommento() {
            if (!commentoRegex.test(commentoInput.value.trim())) {
                commentoError.textContent = "Il commento deve contenere tra 5 e 500 caratteri.";
                commentoError.classList.add("visibile");
                return false;
            } else {
                commentoError.textContent = "";
                commentoError.classList.remove("visibile");
                return true;
            }
        }
    }

    // --- Validazione form "Aggiungi al carrello" (quantità) ---
    const formCarrello = document.querySelector(".dettaglio-prodotto form");

    if (formCarrello) {
        const quantitaInput = document.getElementById("quantita");
        const maxDisponibile = parseInt(quantitaInput.getAttribute("max"), 10);

        const quantitaError = document.createElement("span");
        quantitaError.className = "errore-js";
        quantitaInput.parentNode.insertBefore(quantitaError, quantitaInput.nextSibling);

        quantitaInput.addEventListener("change", function() {
            validaQuantita();
        });
        quantitaInput.addEventListener("input", function() {
            validaQuantita();
        });

        formCarrello.addEventListener("submit", function(event) {
            const quantitaValida = validaQuantita();

            if (!quantitaValida) {
                event.preventDefault();
            }
        });

        function validaQuantita() {
            const valore = parseInt(quantitaInput.value, 10);

            if (isNaN(valore) || valore < 1 || valore > maxDisponibile) {
                quantitaError.textContent = "Inserisci una quantità valida (tra 1 e " + maxDisponibile + ").";
                quantitaError.classList.add("visibile");
                return false;
            } else {
                quantitaError.textContent = "";
                quantitaError.classList.remove("visibile");
                return true;
            }
        }
    }

});