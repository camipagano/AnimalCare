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