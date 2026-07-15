<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registrati</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<header>
<a href="<%= request.getContextPath() %>/HomeServlet" class="logo">AnimalCare</a>
</header>
<main>
<h1>Crea il tuo account</h1>
<%
    String errore = (String) request.getAttribute("errore");
    if (errore != null) {
%>
    <p class="errore"><%= errore %></p>
<%
    }
%>
<form action="<%= request.getContextPath() %>/RegistrazioneServlet" method="POST">
    <label for="nome">Nome</label>
    <input type="text" id="nome" name="nome" required>

    <label for="cognome">Cognome</label>
    <input type="text" id="cognome" name="cognome" required>

    <label for="mail">Email</label>
    <input type="email" id="mail" name="mail" required>

    <label for="password">Password</label>
    <input type="password" id="password" name="password" required>

    <label for="indirizzo">Indirizzo</label>
    <input type="text" id="indirizzo" name="indirizzo" required>

    <button type="submit">Registrati</button>
</form>
<p>Hai già un account? <a href="<%= request.getContextPath() %>/LoginServlet">Accedi</a></p>
<p><a href="<%= request.getContextPath() %>/HomeServlet">Torna alla home</a></p>
</main>
</body>
</html>