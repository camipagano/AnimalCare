<%@page import="it.animalcare.model.CarrelloModel"%>
<%@page import="it.animalcare.model.UtenteModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%! 
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
<title>Checkout</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/checkout.css">
</head>
<body>

<header>
<a href="<%= request.getContextPath() %>/HomeServlet" class="logo">AnimalCare</a>
</header>

<main>
<h1>Completa il tuo ordine</h1>

<%
    String errore = (String) request.getAttribute("errore");
    if (errore != null) {
%>
    <p class="errore"><%= errore %></p>
<%
    }

    List<CarrelloModel> righeCarrello = (List<CarrelloModel>) request.getAttribute("righeCarrello");
    Float totale = (Float) request.getAttribute("totale");
    UtenteModel utenteLoggato = (UtenteModel) request.getAttribute("utenteLoggato");
%>

<div class="checkout-container">

    <section class="riepilogo">
        <h2>Riepilogo ordine</h2>
        <ul class="lista-riepilogo">
<%
        if (righeCarrello != null) {
            for (CarrelloModel riga : righeCarrello) {
%>
            <li>
                <span class="nome-prod"><%= escapeHtml(riga.getProdotto().getNome()) %> × <%= riga.getQuantita() %></span>
                <span class="subtotale">€ <%= String.format("%.2f", riga.getSubtotale()) %></span>
            </li>
<%
            }
        }
%>
        </ul>
        <p class="totale-ordine">Totale: € <%= (totale != null) ? String.format("%.2f", totale) : "0.00" %></p>
    </section>

    <section class="form-checkout">
        <h2>Dati di spedizione e pagamento</h2>

        <form action="<%= request.getContextPath() %>/CheckoutServlet" method="POST">

            <label for="indirizzo">Indirizzo di spedizione</label>
            <textarea id="indirizzo" name="indirizzo" rows="3" required><%= (utenteLoggato != null && utenteLoggato.getIndirizzo() != null) ? escapeHtml(utenteLoggato.getIndirizzo()) : "" %></textarea>

            <label for="metodoPagamento">Metodo di pagamento</label>
            <select id="metodoPagamento" name="metodoPagamento" required>
                <option value="">-- Seleziona --</option>
                <option value="Carta di credito">Carta di credito</option>
                <option value="PayPal">PayPal</option>
                <option value="Contrassegno">Contrassegno</option>
            </select>

            <button type="submit">Conferma ordine</button>
        </form>
    </section>

</div>

<p><a href="<%= request.getContextPath() %>/CarrelloServlet">Torna al carrello</a></p>

</main>

</body>
</html>