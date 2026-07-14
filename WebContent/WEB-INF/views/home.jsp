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
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/home.css">
</head>
<body>
<header>

<h1>AnimalCare</h1>

<div class="search">
    <form action="CercaProdottiServlet" method="GET">
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
     
     <a href="LogoutServlet" class="logoutButton">logout</a>
     <% } %>
   
     <a href="Carrello.jsp" class="cartButton" title="Carrello">
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
		
		<li><a href="prodotti.jsp?categoria=<%= cat.getId() %>"><%= cat.getNome() %></a></li>
			
	<% 	}
	}%>
    <li><a href="<%= request.getContextPath() %>/ContattiServlet">Contatti</a></li>
</ul>
</nav>

<main>  <!-- qui vanno i prodotti --> </main>
<footer>
    <ul>
        <li><a href="<%= request.getContextPath() %>/ChiSiamoServlet">Chi Siamo</a></li>
        <li><a href="<%= request.getContextPath() %>/ContattiServlet">Contatti</a></li>
    </ul>
</footer>

</body>
</html>