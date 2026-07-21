<%@page import="it.animalcare.model.UtenteModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    UtenteModel utente = (UtenteModel) request.getAttribute("utente");
    if (utente == null) {
        utente = (UtenteModel) session.getAttribute("utenteLoggato");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cambio Dati Personali</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/dati.css">
</head>
<body>

<header>
    <a href="<%= request.getContextPath() %>/HomeServlet" class="logo">AnimalCare</a>
</header>

<main>
    <div class="dati-container">
        <h1>I miei dati personali</h1>

        <% 
            String messaggioSuccesso = (String) request.getAttribute("messaggioSuccesso");
            if (messaggioSuccesso != null) { 
        %>
            <p class="messaggio-successo"><%= messaggioSuccesso %></p>
        <% 
            } 
            String messaggioErrore = (String) request.getAttribute("messaggioErrore");
            if (messaggioErrore != null) { 
        %>
            <p class="messaggio-errore"><%= messaggioErrore %></p>
        <% } %>

        <form action="<%= request.getContextPath() %>/DatiServlet" method="POST" class="dati-form">
            
            <div class="form-group">
                <label for="nome">Nome</label>
                <input type="text" id="nome" name="nome" value="<%= (utente != null && utente.getNome() != null) ? utente.getNome() : "" %>" required>
            </div>

            <div class="form-group">
                <label for="cognome">Cognome</label>
                <input type="text" id="cognome" name="cognome" value="<%= (utente != null && utente.getCognome() != null) ? utente.getCognome() : "" %>" required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%= (utente != null && utente.getMail() != null) ? utente.getMail() : "" %>" required>
            </div>

            <div class="form-group">
                <label for="password">Nuova Password</label>
                <input type="password" id="password" name="password" placeholder="Lascia vuoto per non cambiarla">
            </div>

            <div class="form-actions">
                <button type="submit" class="btn-salva">Salva Modifiche</button>
            </div>
        </form>
    </div>
</main>

</body>
</html>