<%@page import="it.animalcare.model.ProdottoModel"%>
<%@page import="it.animalcare.model.CategoriaModel"%>
<%@page import="java.util.Collection"%>
<%@page import="it.animalcare.dao.CategoriaDaoImpl"%>
<%@page import="it.animalcare.dao.CategoriaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/home.css">
<script src="<%= request.getContextPath() %>/script/home.js" defer></script>
</head>
<body>
<header>

<h1>AnimalCare</h1>

<div class="search">
    <form action="<%= request.getContextPath() %>/CercaProdottiServlet" method="GET">
        <input type="text" name="cercaProdotti" placeholder="Cerca prodotti..." required>
        <button type="submit">🔍</button>
    </form>
</div>

<div class="header-actions">

<!-- controlliamo se l'utente in sessione è loggato -->
<% if(session.getAttribute("utenteLoggato")==null){ %>
	<a href="<%= request.getContextPath() %>/LoginServlet" class="loginButton" title="Accedi / Registrati">
            <span class="icon">👤</span>
     </a>
   <%}else{ %>

   	<a href="<%= request.getContextPath() %>/OrdiniServlet" class="loginButton" title="Gestisci ordini">
            <span class="icon">👤</span>
     </a>

     <a href="<%= request.getContextPath() %>/LogoutServlet" class="logoutButton">logout</a>
     <% } %>

     <a href="<%= request.getContextPath() %>/CarrelloServlet" class="cartButton" title="Carrello">
            <span class="icon">🛒</span>
     </a>
</div>
</header>

<nav class= "navBar">
<ul>

<%
	Collection<CategoriaModel> categorie= (Collection<CategoriaModel>) request.getAttribute("categorie");

	if(categorie != null && !categorie.isEmpty()){
		for(CategoriaModel cat : categorie){ %>

		<li><a href="<%= request.getContextPath() %>/CategoriaServlet?categoria=<%= cat.getId() %>"><%= cat.getNome() %></a></li>

	<% 	}
	}%>
    <li><a href="<%= request.getContextPath() %>/ContattiServlet">Contatti</a></li>
</ul>
</nav>

<main>
<div class= "catalogo">
	<button class="freccia-sinistra" onclick="moveSlide(-1)"> &#10094; </button>
	<div class="catalogo-container">
		<div class= "catalogo-layout">
<%
Collection<ProdottoModel> prodotti= (Collection<ProdottoModel>) request.getAttribute ("prodotti");
if(prodotti!=null && !prodotti.isEmpty()){
	int count=0;
	for(ProdottoModel prod: prodotti){
	//apriamo una nuova pagina a griglia
	if(count%8==0){ %>
		<div class= "griglia">
	<% } %>
	<div class="prodotto-layout">
	<img alt="<%= prod.getNome() %>" src="<%= request.getContextPath() %>/<%=prod.getImmagine()%>">
		<div class= "prod-info">
			<h3> <a href="<%= request.getContextPath() %>/ProdottoServlet?id=<%= prod.getId() %>&categoria=<%= prod.getIdCategoria() %>"> <%=prod.getNome() %></a></h3>
			<p class= "price">€<%= String.format("%.2f", prod.getPrezzo()) %></p>
		</div>
	</div>
	<%
		count++;
	//se abbiamo raggiunto gli 8 prodotti o sono finiti i prodotti, chiudiamo la griglia
	if(count%8==0 || count==prodotti.size()){ %>
		</div>
	<% }
	}
}else{%>
	<p class= "no-prodotti"> Non ci sono prodotti disponibili </p>
<% }%>
</div>
</div>

<button class= "freccia-destra" onclick="moveSlide(1)"> &#10095; </button>
</div>

<section class="info-section">
    <div class="info-spedizione"></div>
    <a href="<%= request.getContextPath() %>/ContattiServlet" class="info-job-link">
    <div class="info-job"></div>
    </a>
</section>

 </main>
<footer>
    <ul>
        <li><a href="<%= request.getContextPath() %>/ChiSiamoServlet">Chi Siamo</a></li>
        <li><a href="<%= request.getContextPath() %>/ContattiServlet">Contatti</a></li>
    </ul>
</footer>

</body>
</html>