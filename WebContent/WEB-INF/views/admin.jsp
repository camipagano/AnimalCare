<%@page import="it.animalcare.model.UtenteModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Area Amministratore</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/admin.css">
</head>
<body>

<header>
<a href="<%= request.getContextPath() %>/AdminServlet" class="logo">AnimalCare Admin</a>
<a href="<%= request.getContextPath() %>/LogoutServlet" class="logoutButton">Logout</a>
</header>

<main>
<%
    UtenteModel utenteLoggato = (UtenteModel) session.getAttribute("utenteLoggato");
%>
<h1>Benvenuto, <%= utenteLoggato.getNome() %></h1>

<div class="admin-menu">
    <a href="<%= request.getContextPath() %>/AdminProdottiServlet" class="admin-card">
        <h2>Gestione catalogo</h2>
        <p>Inserisci, modifica, aggiorna prezzi, disponibilità e sconti dei prodotti</p>
    </a>

    <a href="<%= request.getContextPath() %>/AdminOrdiniServlet" class="admin-card">
        <h2>Gestione ordini</h2>
        <p>Visualizza tutti gli ordini, filtrabili per data e cliente</p>
    </a>
</div>

</main>

</body>
</html>