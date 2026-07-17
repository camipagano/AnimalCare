document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector("form");
    const indirizzo = document.getElementById("indirizzo");
    const metodoPagamento = document.getElementById("metodoPagamento");

    const indirizzoError = document.createElement("span");
    indirizzoError.className = "errore-js";
    indirizzo.parentNode.insertBefore(indirizzoError, indirizzo.nextSibling);

    const pagamentoError = document.createElement("span");
    pagamentoError.className = "errore-js";
    metodoPagamento.parentNode.insertBefore(pagamentoError, metodoPagamento.nextSibling);

    indirizzo.addEventListener("change", validaIndirizzo);
    metodoPagamento.addEventListener("change", validaPagamento);

    form.addEventListener("submit", function(event) {
        const isIndirizzoValid = validaIndirizzo();
        const isPagamentoValid = validaPagamento();

        if (!isIndirizzoValid || !isPagamentoValid) {
            event.preventDefault();
        }
    });

    function validaIndirizzo() {
        const regexIndirizzo = /^[\w\s,'.\-\/À-ù]{8,150}$/;
        if (!regexIndirizzo.test(indirizzo.value.trim())) {
            indirizzoError.textContent = "Inserisci un indirizzo valido (minimo 8 caratteri).";
            indirizzoError.classList.add("visibile");
            return false;
        } else {
            indirizzoError.textContent = "";
            indirizzoError.classList.remove("visibile");
            return true;
        }
    }

    function validaPagamento() {
        if (metodoPagamento.value === "") {
            pagamentoError.textContent = "Seleziona un metodo di pagamento.";
            pagamentoError.classList.add("visibile");
            return false;
        } else {
            pagamentoError.textContent = "";
            pagamentoError.classList.remove("visibile");
            return true;
        }
    }
});