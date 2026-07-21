<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Accedi</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/login.css">
<script src="<%= request.getContextPath() %>/script/login.js" defer></script>
</head>
<body>
<header>
<a href="<%= request.getContextPath() %>/HomeServlet" class="logo">AnimalCare</a>
</header>
<main>
<div class="box-login">
<h1>Accedi</h1>
<%
    String errore = (String) request.getAttribute("errore");
    if (errore != null) {
%>
    <p class="errore"><%= errore %></p>
<%
    }
%>
<form action="<%= request.getContextPath() %>/LoginServlet" method="POST">
    <label for="mail">Email</label>
    <input type="email" id="mail" name="mail" required>
    <label for="password">Password</label>
    <input type="password" id="password" name="password" required>
    <button type="submit">Accedi</button>
</form>
</div>
<p>Non hai un account? <a href="<%= request.getContextPath() %>/RegistrazioneServlet">Registrati</a></p>
<p><a href="<%= request.getContextPath() %>/HomeServlet">Torna alla home</a></p>
</main>
</body>
</html>