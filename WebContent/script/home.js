let currentIndex = 0;

function moveSlide(direction) {
	const cat = document.querySelector('.catalogo-layout');
	const totalGrids = document.querySelectorAll('.griglia').length;
	if (!cat || totalGrids === 0) return;

	currentIndex += direction;
	if (currentIndex < 0) {
        currentIndex = 0;
    } else if (currentIndex >= totalGrids) {
        currentIndex = totalGrids - 1;
    }

	const amountToMove = -currentIndex * 100;
	cat.style.transform = `translateX(${amountToMove}%)`;
}

document.addEventListener("DOMContentLoaded", function() {
    const searchForm = document.querySelector(".search form");

    if (!searchForm) return;

    const searchInput = searchForm.querySelector("input[name='cercaProdotti']");
    const searchRegex = /^.{1,100}$/;

    const searchError = document.createElement("span");
    searchError.className = "errore-js";
	
	searchForm.appendChild(searchError);

    searchInput.addEventListener("input", function() {
        validaRicerca();
    });

    searchForm.addEventListener("submit", function(event) {
        const valido = validaRicerca();

        if (!valido) {
            event.preventDefault();
        }
    });

    function validaRicerca() {
        if (!searchRegex.test(searchInput.value.trim())) {
            searchError.textContent = "Inserisci almeno 1 carattere per la ricerca.";
            searchError.classList.add("visibile");
            return false;
        } else {
            searchError.textContent = "";
            searchError.classList.remove("visibile");
            return true;
        }
    }
});