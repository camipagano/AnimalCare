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
<script src="<%= request.getContextPath() %>/script/checkout.js" defer></script>
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
    Float spedizione = (Float) request.getAttribute("spedizione");
    Float totaleComplessivo = (Float) request.getAttribute("totaleComplessivo");
    UtenteModel utenteLoggato = (UtenteModel) request.getAttribute("utenteLoggato");
    
    Double scontoAttivo = (Double) application.getAttribute("scontoGenerale");
    if (scontoAttivo == null) {
        scontoAttivo = 0.0;
    }
    boolean haSconto = scontoAttivo > 0;
    double subtotaleProdottiCalcolato = 0.0;
%>

<div class="checkout-container">

    <section class="riepilogo">
        <h2>Riepilogo ordine</h2>
        <ul class="lista-riepilogo">
<%
        if (righeCarrello != null) {
            for (CarrelloModel riga : righeCarrello) {
            	float prezzoOriginale = riga.getProdotto().getPrezzo();
                double prezzoUnitario = haSconto ? (prezzoOriginale * (1 - (scontoAttivo / 100.0))) : prezzoOriginale;
                double subtotaleRiga = prezzoUnitario * riga.getQuantita();
                
                subtotaleProdottiCalcolato += subtotaleRiga;
%>
            <li>
                <span class="nome-prod"><%= escapeHtml(riga.getProdotto().getNome()) %> × <%= riga.getQuantita() %></span>
                <span class="subtotale">€ <%= String.format("%.2f", subtotaleRiga) %></span>
            </li>
<%
            }
        }
		float costoSpedizione = (spedizione != null) ? spedizione : 0.0f;
		double totaleComplessivoCalcolato = subtotaleProdottiCalcolato + costoSpedizione;
%>
        </ul>
        <div class="dettaglio-costi">
            <p>Subtotale prodotti: <span>€ <%= (totale != null) ? String.format("%.2f", subtotaleProdottiCalcolato) : "0.00" %></span></p>
            <p>Spedizione: <span>
                <% if (costoSpedizione==0) { %>
                    <strong>Gratis</strong>
                <% } else  { %>
                    € <%= String.format("%.2f", costoSpedizione) %>
                <% } %>
            </span></p>
            <hr>
            </div>
        <p class="totale-ordine">Totale: € <%= String.format("%.2f", totaleComplessivoCalcolato)%></p>
    </section>

    <section class="form-checkout">
        <h2>Dati di spedizione e pagamento</h2>

        <form action="<%= request.getContextPath() %>/CheckoutServlet" method="POST">

    <label for="indirizzo">Indirizzo di spedizione</label>
    <textarea id="indirizzo" name="indirizzo" rows="3" required><%= (utenteLoggato != null && utenteLoggato.getIndirizzo() != null) ? escapeHtml(utenteLoggato.getIndirizzo()) : "" %></textarea>

    <label for="metodoPagamento">Metodo di pagamento</label>
    <select id="metodoPagamento" name="metodoPagamento" required>
        <option value="">-- Seleziona --</option>
        <option value="carta">Carta di credito</option>
        <option value="paypal">PayPal</option>
        <option value="contrassegno">Contrassegno</option>
    </select>
    
    <div id="sezione-carta">
        <label for="intestatarioCarta">Titolare della carta</label>
        <input type="text" id="intestatarioCarta" name="intestatarioCarta" placeholder="Mario Rossi">

        <div class="carta-dettagli-container">
            <div class="campo-numero">
                <label for="numeroCarta">Numero Carta</label>
                <input type="text" id="numeroCarta" name="numeroCarta" placeholder="1234567812345678" maxlength="16">
            </div>
            <div class="campo-cvv">
                <label for="cvvCarta">CVC/CVV</label>
                <input type="text" id="cvvCarta" name="cvvCarta" placeholder="123" maxlength="3">
            </div>
        </div>
    </div>
    
    <button type="submit">Conferma ordine</button>
</form>
    </section>

</div>

<p><a href="<%= request.getContextPath() %>/CarrelloServlet">Torna al carrello</a></p>

</main>

</body>
</html>