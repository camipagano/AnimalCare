document.addEventListener("DOMContentLoaded", function() {
    const forms = document.querySelectorAll(".form-stato");

    forms.forEach(function(form) {
        form.addEventListener("submit", function(event) {
            event.preventDefault();

            const box = form.closest(".ordine-box");
            const codice = box.getAttribute("data-codice");
            const idUtente = box.getAttribute("data-idutente");
            const nuovoStato = form.querySelector("select[name='nuovoStato']").value;
            const statoMsg = form.querySelector(".stato-msg");

            const params = new URLSearchParams();
            params.append("cambiaStato", "1");
            params.append("codice", codice);
            params.append("idUtenteOrdine", idUtente);
            params.append("nuovoStato", nuovoStato);

            const contextPath = document.querySelector("header .logo").getAttribute("href").replace("/AdminServlet", "");

            fetch(contextPath + "/AdminOrdiniServlet?" + params.toString(), {
                method: "GET",
                headers: {
                    "X-Requested-With": "XMLHttpRequest"
                }
            })
            .then(function(resp) {
                if (!resp.ok) throw new Error("Errore nella richiesta");
                return resp.text();
            })
            .then(function(statoAggiornato) {
                const badgeStato = box.querySelector(".ordine-stato");
                badgeStato.textContent = statoAggiornato;

                statoMsg.textContent = "Aggiornato!";
                statoMsg.classList.add("visibile");

                setTimeout(function() {
                    statoMsg.textContent = "";
                    statoMsg.classList.remove("visibile");
                }, 2000);
            })
            .catch(function(err) {
                console.error(err);
                statoMsg.textContent = "Errore nell'aggiornamento.";
                statoMsg.classList.add("visibile", "errore-msg");
            });
        });
    });
});