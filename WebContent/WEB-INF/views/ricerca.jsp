<%@page import="it.animalcare.model.ProdottoModel"%>
<%@page import="java.util.Collection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
    // Metodo di utilità interno alla JSP per evitare attacchi XSS
    private String escapeHtml(String input) {
        if (input == null) return "";
        return input.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#x27;");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Risultati Ricerca</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/ricerca.css?v=1">
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
   	<div class="utente-dropdown">
        <button class="loginButton dropdown-toggle" title="Profilo">
            <span class="icon">👤</span>
        </button>
        <ul class="dropdown-menu">
            <li><a href="<%= request.getContextPath() %>/OrdiniServlet">Gestisci ordini</a></li>
            <li><a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a></li>
        </ul>
    </div>
     <% } %>

     <a href="<%= request.getContextPath() %>/CarrelloServlet" class="cartButton" title="Carrello">
            <span class="icon">🛒</span>
     </a>
</div>
</header>

<main>

<%
    String immagineSfondo = (String) request.getAttribute("immagineSfondo");
    String stileSfondo = (immagineSfondo != null)
        ? "background-image: url('" + request.getContextPath() + "/img/" + immagineSfondo + "');"
        : "";
%>

<div class="risultati ricerca" style="<%= stileSfondo %>">
	<%
	String testo= (String) request.getAttribute("testoCercato");
	String categoria= (String) request.getAttribute("nomeCategoria");
	Collection<ProdottoModel> prodottiTrovati= (Collection<ProdottoModel>) request.getAttribute("prodottiRicerca");
	String titoloDaMostrare = "";
	if (categoria != null) {
	    titoloDaMostrare = "Categoria: " + escapeHtml(categoria);
	} else if (testo != null) {
	    titoloDaMostrare = "Risultati di ricerca per: " + escapeHtml(testo);
	} else {
	    titoloDaMostrare = "Prodotti";
	}
	Double scontoAttivo = (Double) application.getAttribute("scontoGenerale");
	if (scontoAttivo == null) {
	    scontoAttivo = 0.0;
	}
	boolean haSconto = scontoAttivo > 0;
	%>

	<h2><%= titoloDaMostrare %> </h2>

	<div class="griglia-ricerca">

	<%
	if(prodottiTrovati!=null && !prodottiTrovati.isEmpty()){
		for(ProdottoModel prod : prodottiTrovati){ 
			float prezzoOriginale = prod.getPrezzo();
			double prezzoFinale = haSconto ? (prezzoOriginale * (1 - (scontoAttivo / 100.0))) : prezzoOriginale;
		%>

			<div class= "riquadro-prodotto">
				<div class= "prod-img">
				<img alt="<%= escapeHtml(prod.getNome()) %>" src="<%=request.getContextPath() %>/<%=prod.getImmagine() %>">
				</div>
				<div class="prod-info">
				<h3><a href="<%= request.getContextPath() %>/ProdottoServlet?id=<%= prod.getId() %>&categoria=<%= prod.getIdCategoria() %>"><%= escapeHtml(prod.getNome()) %></a></h3>
				<p class="price"><% if (haSconto) { %>
							<span class="prezzo-vecchio" >
								€ <%= String.format("%.2f", prezzoOriginale) %>
							</span>
						<% } %>
						<strong class="<%= haSconto ? "prezzo-scontato" : "" %>" >
							€ <%= String.format("%.2f", prezzoFinale) %>
						</strong></p>
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