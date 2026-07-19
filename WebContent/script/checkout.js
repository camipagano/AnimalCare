document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector("form");
    const indirizzo = document.getElementById("indirizzo");
    const metodoPagamento = document.getElementById("metodoPagamento");
    
    const sezioneCarta = document.getElementById("sezione-carta");
    const intestatario = document.getElementById("intestatarioCarta");
    const numeroCarta = document.getElementById("numeroCarta");
    const cvv = document.getElementById("cvvCarta");

    const indirizzoError = creaElementoErrore(indirizzo);
    const pagamentoError = creaElementoErrore(metodoPagamento);
    const intestatarioError = creaElementoErrore(intestatario);
    const numeroError = creaElementoErrore(numeroCarta);
    const cvvError = creaElementoErrore(cvv);

    function creaElementoErrore(elemento) {
        const span = document.createElement("span");
        span.className = "errore-js";
        elemento.parentNode.insertBefore(span, elemento.nextSibling);
        return span;
    }

	function gestisciVisibilitaCarta() {
	        if (metodoPagamento.value === "carta") {
	            sezioneCarta.style.display = "block";
	        } else {
	            sezioneCarta.style.display = "none";
	            svuotaCampiEErroriCarta(); // Ripuliamo tutto se cambia metodo
	        }
	    }

	    gestisciVisibilitaCarta();
	    metodoPagamento.addEventListener("change", function() {
	        validaPagamento();
	        gestisciVisibilitaCarta();
	    });

    indirizzo.addEventListener("change", validaIndirizzo);
    intestatario.addEventListener("change", validaIntestatario);
    numeroCarta.addEventListener("change", validaNumeroCarta);
    cvv.addEventListener("change", validaCvv);
	
    form.addEventListener("submit", function(event) {
        const isIndirizzoValid = validaIndirizzo();
        const isPagamentoValid = validaPagamento();
        let isCartaValid = true;

        if (metodoPagamento.value === "carta") {
            const vInt = validaIntestatario();
            const vNum = validaNumeroCarta();
            const vCvv = validaCvv();
            isCartaValid = vInt && vNum && vCvv;
        }

        if (!isIndirizzoValid || !isPagamentoValid || !isCartaValid) {
            event.preventDefault(); // Blocca l'invio alla Servlet
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

    function validaIntestatario() {
        const regexNome = /^[a-zA-Z\s'À-ù]{3,50}$/;
        if (!regexNome.test(intestatario.value.trim())) {
            intestatarioError.textContent = "Inserisci il nome del titolare (min 3 caratteri).";
            intestatarioError.classList.add("visibile");
            return false;
        } else {
            intestatarioError.textContent = "";
            intestatarioError.classList.remove("visibile");
            return true;
        }
    }

    function validaNumeroCarta() {
        const regexNumero = /^\d{16}$/; 
        if (!regexNumero.test(numeroCarta.value.trim())) {
            numeroError.textContent = "Il numero di carta deve essere composto da 16 cifre.";
            numeroError.classList.add("visibile");
            return false;
        } else {
            numeroError.textContent = "";
            numeroError.classList.remove("visibile");
            return true;
        }
    }

    function validaCvv() {
        const regexCvv = /^\d{3}$/; 
        if (!regexCvv.test(cvv.value.trim())) {
            cvvError.textContent = "Il codice CVC/CVV deve essere di 3 cifre.";
            cvvError.classList.add("visibile");
            return false;
        } else {
            cvvError.textContent = "";
            cvvError.classList.remove("visibile");
            return true;
        }
    }

    function svuotaCampiEErroriCarta() {
		intestatarioError.textContent = "";
		        numeroError.textContent = "";
		        cvvError.textContent = "";
		        
		        intestatarioError.classList.remove("visibile");
		        numeroError.classList.remove("visibile");
		        cvvError.classList.remove("visibile");

		        intestatario.value = "";
		        numeroCarta.value = "";
		        cvv.value = "";
    }
});