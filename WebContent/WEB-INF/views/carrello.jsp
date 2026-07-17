<%@page import="it.animalcare.model.CarrelloModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Il tuo carrello</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/carrello.css">
</head>
<body>

<header>
<a href="<%= request.getContextPath() %>/HomeServlet" class="logo">AnimalCare</a>
</header>

<main>
<h1>Il tuo carrello</h1>

<%
    String errore = (String) request.getAttribute("errore");
    if (errore != null) {
%>
    <p class="errore"><%= errore %></p>
<%
    }

    String messaggioCarrello = (String) request.getAttribute("messaggioCarrello");
    if (messaggioCarrello != null) {
%>
    <p class="avviso"><%= messaggioCarrello %></p>
<%
    }

    List<CarrelloModel> righeCarrello = (List<CarrelloModel>) request.getAttribute("righeCarrello");
    Float totale = (Float) request.getAttribute("totale");

    if (righeCarrello == null || righeCarrello.isEmpty()) {
%>
    <p>Il carrello è vuoto.</p>
    <p><a href="<%= request.getContextPath() %>/HomeServlet">Continua lo shopping</a></p>
<%
    } else {
%>
    <table>
        <thead>
            <tr>
                <th>Prodotto</th>
                <th>Prezzo</th>
                <th>Quantità</th>
                <th>Subtotale</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
<%
        for (CarrelloModel riga : righeCarrello) {
%>
            <tr>
                <td>
                    <img src="<%= request.getContextPath() %>/<%= riga.getProdotto().getImmagine() %>" alt="<%= riga.getProdotto().getNome() %>" width="60">
                    <%= riga.getProdotto().getNome() %>
                </td>
                <td>€ <%= String.format("%.2f", riga.getProdotto().getPrezzo()) %></td>
                <td>
                    <div class="quantita-controlli">
                        <form action="<%= request.getContextPath() %>/CarrelloServlet" method="POST" class="form-inline">
                            <input type="hidden" name="azione" value="diminuisci">
                            <input type="hidden" name="idProdotto" value="<%= riga.getProdotto().getId() %>">
                            <button type="submit">-</button>
                        </form>
                        <%= riga.getQuantita() %>
                        <form action="<%= request.getContextPath() %>/CarrelloServlet" method="POST" class="form-inline">
                            <input type="hidden" name="azione" value="aumenta">
                            <input type="hidden" name="idProdotto" value="<%= riga.getProdotto().getId() %>">
                            <button type="submit">+</button>
                        </form>
                    </div>
                </td>
                <td>€ <%= String.format("%.2f", riga.getSubtotale()) %></td>
                <td>
                    <form action="<%= request.getContextPath() %>/CarrelloServlet" method="POST">
                        <input type="hidden" name="azione" value="rimuovi">
                        <input type="hidden" name="idProdotto" value="<%= riga.getProdotto().getId() %>">
                        <button type="submit">Rimuovi</button>
                    </form>
                </td>
            </tr>
<%
        }
%>
        </tbody>
    </table>

    <h2>Totale: € <%= String.format("%.2f", totale) %></h2>

    <a href="<%= request.getContextPath() %>/CheckoutServlet" class="btn-checkout">Vai al checkout</a>

    <form action="<%= request.getContextPath() %>/CarrelloServlet" method="POST">
        <input type="hidden" name="azione" value="svuota">
        <button type="submit">Svuota carrello</button>
    </form>

    <p><a href="<%= request.getContextPath() %>/HomeServlet">Continua lo shopping</a></p>
<%
    }
%>

</main>

</body>
</html>