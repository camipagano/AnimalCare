<%@page import="it.animalcare.model.ProdottoModel"%>
<%@page import="java.util.Collection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Risultati Ricerca</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/ricerca.css">
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

   	<a href="ordini.jsp" class="loginButton" title="Gestisci ordini">
            <span class="icon">👤</span>
     </a>

     <a href="<%= request.getContextPath() %>/LogoutServlet" class="logoutButton">logout</a>
     <% } %>

     <a href="<%= request.getContextPath() %>/CarrelloServlet" class="cartButton" title="Carrello">
            <span class="icon">🛒</span>
     </a>
</div>
</header>

<main>

<div class= "risultati ricerca">
	<%
	String testo= (String) request.getAttribute("testoCercato");
	String categoria= (String) request.getAttribute("nomeCategoria");
	Collection<ProdottoModel> prodottiTrovati= (Collection<ProdottoModel>) request.getAttribute("prodottiRicerca");
	String titoloDaMostrare = "";
	if (categoria != null) {
	    titoloDaMostrare = "Categoria: " + categoria;
	} else if (testo != null) {
	    titoloDaMostrare = "Risultati di ricerca per: " + testo;
	} else {
	    titoloDaMostrare = "Prodotti";
	}
	%>

	<h2><%= titoloDaMostrare %> </h2>

	<div class="griglia-ricerca">

	<%
	if(prodottiTrovati!=null && !prodottiTrovati.isEmpty()){
		for(ProdottoModel prod : prodottiTrovati){ %>

			<div class= "riquadro-prodotto">
				<div class= "prod-img">
				<img alt="<%=prod.getNome() %>" src="<%=request.getContextPath() %>/<%=prod.getImmagine() %>">
				</div>
				<div class="prod-info">
				<h3><a href="<%= request.getContextPath() %>/ProdottoServlet?id=<%= prod.getId() %>&categoria=<%= prod.getIdCategoria() %>"><%= prod.getNome() %></a></h3>
				<p class="price">€<%= String.format("%.2f", prod.getPrezzo()) %></p>
				</div>
			</div>

		<%}
	}else{
	%>
	<p class= "no-prodotti">Nessun prodotto trovato che corrisponde alla ricerca</p>
	<%} %>
	</div>
</div>

</main>
<footer>

<ul>
        <li><a href="<%= request.getContextPath() %>/ChiSiamoServlet">Chi Siamo</a></li>
        <li><a href="<%= request.getContextPath() %>/ContattiServlet">Contatti</a></li>
        <li><a href="<%= request.getContextPath() %>/HomeServlet">Home</a></li>
    </ul>

</footer>

</body>
</html>