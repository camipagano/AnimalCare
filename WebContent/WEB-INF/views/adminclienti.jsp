<%@page import="it.animalcare.model.UtenteModel"%>
<%@page import="java.util.Collection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestione Clienti - Admin</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/admin.css">
</head>
<body class="prodotti-page">

<header>
<a href="<%= request.getContextPath() %>/AdminServlet" class="logo">AnimalCare - Admin</a>
<a href="<%= request.getContextPath() %>/LogoutServlet" class="logoutButton">Logout</a>
</header>

<main>

<div class="titolo-pagina">
    <h1>Gestione Clienti</h1>
</div>

<%
    String errore = (String) request.getAttribute("errore");
    if (errore != null) {
%>
    <p class="errore"><%= errore %></p>
<%
    }

    Collection<UtenteModel> clienti = (Collection<UtenteModel>) request.getAttribute("clienti");

    if (clienti == null || clienti.isEmpty()) {
%>
    <p class="nessun-prodotto">Nessun cliente registrato.</p>
<%
    } else {
%>
    <table>
        <thead>
            <tr>
                <th>Nome</th>
                <th>Cognome</th>
                <th>Email</th>
                <th>Indirizzo</th>
            </tr>
        </thead>
        <tbody>
<%
        for (UtenteModel cliente : clienti) {
%>
            <tr>
                <td data-label="Nome"><%= cliente.getNome() %></td>
                <td data-label="Cognome"><%= cliente.getCognome() %></td>
                <td data-label="Email"><%= cliente.getMail() %></td>
                <td data-label="Indirizzo"><%= (cliente.getIndirizzo() != null) ? cliente.getIndirizzo() : "-" %></td>
            </tr>
<%
        }
%>
        </tbody>
    </table>
<%
    }
%>

<p style="margin-top:20px;"><a href="<%= request.getContextPath() %>/AdminServlet" class="link-dashboard">Torna alla dashboard</a></p>

</main>

</body>
</html>