document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector(".recensioni form");

    if (!form) return;

    const commentoInput = document.getElementById("commento");
    const commentoRegex = /^.{5,500}$/;

    const commentoError = document.createElement("span");
    commentoError.className = "errore-js";
    commentoInput.parentNode.insertBefore(commentoError, commentoInput.nextSibling);

    commentoInput.addEventListener("change", function() {
        validaCommento();
    });

    form.addEventListener("submit", function(event) {
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
});