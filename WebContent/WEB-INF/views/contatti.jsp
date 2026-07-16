<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contatti</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/contatti.css">
</head>
<body>
<header>

<h1 class="logo">Contatti</h1>

</header>

<main>
<div class="contatti-testo">
	<section class="sezione-contatti">
		<h2>Problemi con ordini</h2>
		<ul class= "lista-contatti">
			<li>(+39)333 456 1010</li>
			<li>(+39)348 123 6767</li>
			<li> animalcareinfo@gmail.com</li>
		</ul>
	</section>
	<section class="sezione-contatti">
		<h2>Informazioni aggiuntive</h2>
		<ul class= "lista-contatti">
			<li>(+39)339 000 9088</li>
			<li> animalcareinfo@gmail.com</li>
		</ul>
	</section>
	<section class="sezione-contatti">
		<h2>Lavora con noi</h2>
		<ul class= "lista-contatti">
			<li>(+39)348 936 9954</li>
			<li> animalcarestaff@gmail.com </li>
		</ul>
	</section>
</div>
<div class="contatti-foto">
	<img src="<%= request.getContextPath() %>/img/noi.jpg" alt="Contatti AnimalCare">
</div>

</main>

<footer>
    <ul>
        <li><a href="<%= request.getContextPath() %>/ChiSiamoServlet">Chi siamo</a></li>
        <li><a href="<%= request.getContextPath() %>/HomeServlet">Home</a></li>
    </ul>
</footer>
</body>
</html>