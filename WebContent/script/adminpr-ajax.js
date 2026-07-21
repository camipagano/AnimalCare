document.addEventListener("DOMContentLoaded", function() {
    const tabella = document.querySelector("table tbody");

    if (!tabella) return;

    tabella.addEventListener("click", function(event) {
        const bottone = event.target.closest(".btn-toggle-stato");
        if (!bottone) return;

        const riga = bottone.closest("tr");
        const id = riga.getAttribute("data-id");
        const categoria = riga.getAttribute("data-categoria");
        const azione = bottone.getAttribute("data-azione");

        const params = new URLSearchParams();
        params.append("azione", azione);
        params.append("id", id);
        params.append("categoria", categoria);

        const contextPath = document.querySelector("header .logo").getAttribute("href").replace("/AdminServlet", "");

        fetch(contextPath + "/AdminProdottiServlet", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "X-Requested-With": "XMLHttpRequest"
            },
            body: params.toString()
        })
        .then(function(resp) {
            if (!resp.ok) throw new Error("Errore nella richiesta");
            return resp.text();
        })
        .then(function(risultato) {
            const cellaStato = riga.querySelector(".cella-stato");

            if (risultato === "disattivato") {
                riga.classList.add("riga-disattivata");
                cellaStato.innerHTML = '<span class="stato disattivo">Disattivato</span>';
                bottone.textContent = "Riattiva";
                bottone.classList.remove("btn-elimina");
                bottone.classList.add("btn-riattiva");
                bottone.setAttribute("data-azione", "riattiva");
            } else if (risultato === "riattivato") {
                riga.classList.remove("riga-disattivata");
                cellaStato.innerHTML = '<span class="stato attivo">Attivo</span>';
                bottone.textContent = "Elimina";
                bottone.classList.remove("btn-riattiva");
                bottone.classList.add("btn-elimina");
                bottone.setAttribute("data-azione", "elimina");
            }
        })
        .catch(function(err) {
            console.error(err);
            alert("Si è verificato un errore. Riprova.");
        });
    });
});