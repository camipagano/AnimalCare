document.addEventListener("DOMContentLoaded", () => {
    const formSconto = document.querySelector(".form-sconto");
    if (!formSconto) return;

    formSconto.addEventListener("submit", function (e) {
        e.preventDefault();

        const inputSconto = document.querySelector(".percentualeSconto");
        const btnSconto = document.querySelector(".btn-sconto");
        const labelSconto = document.querySelector(".label-sconto");
		
		const isRimuovi = btnSconto.classList.contains("btn-rimuovi");
		let percentuale = 0;
		if (!isRimuovi) {
		            percentuale = parseFloat(inputSconto.value);
		            if (isNaN(percentuale) || percentuale <= 0 || percentuale > 100) {
		                alert("Inserisci una percentuale valida tra 1 e 100.");
		                return;
		            }
		        }

		        const params = new URLSearchParams();
		        params.append("percentualeSconto", percentuale);

		        fetch(formSconto.action, {
		            method: "POST",
		            headers: { "Content-Type": "application/x-www-form-urlencoded" },
		            body: params.toString()
		        })
		        .then(response => response.json())
		        .then(data => {
		            if (data.success) {
		                const nuovoSconto = data.sconto;
						
						if (nuovoSconto > 0) {
		                    labelSconto.textContent = `Sconto in atto (${Math.round(nuovoSconto)}%):`;
		                    btnSconto.textContent = "Rimuovi";
		                    btnSconto.classList.remove("btn-applica");
		                    btnSconto.classList.add("btn-rimuovi");
		                    inputSconto.value = Math.round(nuovoSconto);
			                } else {
			                    labelSconto.textContent = "Impostare sconto (%):";
			                    btnSconto.textContent = "Applica";
			                    btnSconto.classList.remove("btn-rimuovi");
			                    btnSconto.classList.add("btn-applica");
			                    inputSconto.value = "";
			               	 }
							 const righe = document.querySelectorAll("#tabella-prodotti tbody tr");
			                 righe.forEach(riga => {
			                     const prezzoBase = parseFloat(riga.getAttribute("data-prezzo-base"));
			                     const cellaPrezzo = riga.querySelector(".cella-prezzo");

			                     let prezzoFinale = prezzoBase;
			                     if (nuovoSconto > 0) {
			                         prezzoFinale = prezzoBase * (1 - (nuovoSconto / 100.0));
			                     }

			                     cellaPrezzo.textContent = "€ " + prezzoFinale.toFixed(2).replace(".", ",");
				                 });
				             } else {
				                 alert("Errore durante l'aggiornamento dello sconto.");
				             }
				         })
				         .catch(err => console.error("Errore AJAX:", err));
					     });
					 });