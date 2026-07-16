<%@page import="it.animalcare.model.OrdineModel"%>
<%@page import="it.animalcare.model.DettaglioOrdineModel"%>
<%@page import="it.animalcare.model.MetodoPagamentoModel"%>
<%@page import="it.animalcare.model.ProdottoModel"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>I miei ordini</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/ordini.css">
</head>
<body>

<header>
<a href="<%= request.getContextPath() %>/HomeServlet" class="logo">AnimalCare</a>
</header>

<main>
<h1>I miei ordini</h1>

<%
    String confermato = (String) request.getAttribute("confermato");
    if (confermato != null) {
%>
    <p class="conferma">Ordine #<%= confermato %> confermato con successo! Grazie per il tuo acquisto.</p>
<%
    }

    String errore = (String) request.getAttribute("errore");
    if (errore != null) {
%>
    <p class="errore"><%= errore %></p>
<%
    }

    Collection<OrdineModel> ordini = (Collection<OrdineModel>) request.getAttribute("ordini");
    Map<Integer, List<DettaglioOrdineModel>> dettagliPerOrdine = (Map<Integer, List<DettaglioOrdineModel>>) request.getAttribute("dettagliPerOrdine");
    Map<Integer, MetodoPagamentoModel> pagamentoPerOrdine = (Map<Integer, MetodoPagamentoModel>) request.getAttribute("pagamentoPerOrdine");
    Map<Integer, ProdottoModel> prodottiPerId = (Map<Integer, ProdottoModel>) request.getAttribute("prodottiPerId");

    if (ordini == null || ordini.isEmpty()) {
%>
    <p class="nessun-ordine">Non hai ancora effettuato ordini.</p>
    <p><a href="<%= request.getContextPath() %>/HomeServlet">Inizia a fare shopping</a></p>
<%
    } else {
        for (OrdineModel ordine : ordini) {
            List<DettaglioOrdineModel> dettagli = dettagliPerOrdine.get(ordine.getCodice());
            MetodoPagamentoModel pagamento = pagamentoPerOrdine.get(ordine.getCodice());

            float totaleOrdine = 0;
            if (dettagli != null) {
                for (DettaglioOrdineModel d : dettagli) {
                    totaleOrdine += d.getPrezzoUnitario() * d.getQuantità();
                }
            }
%>
    <div class="ordine-box">
        <div class="ordine-header">
            <h2>Ordine #<%= ordine.getCodice() %></h2>
            <span class="ordine-stato"><%= ordine.getStato() %></span>
        </div>
        <p class="ordine-data">Data: <%= ordine.getData() %></p>
        <p class="ordine-indirizzo">Spedizione: <%= ordine.getIndirizzo() %></p>
        <p class="ordine-pagamento">Pagamento: <%= (pagamento != null) ? pagamento.getNome() : "N/D" %></p>

        <ul class="ordine-prodotti">
<%
            if (dettagli != null) {
                for (DettaglioOrdineModel d : dettagli) {
                    ProdottoModel prodotto = prodottiPerId.get(d.getIdProdotto());
                    String nomeProdotto = (prodotto != null) ? prodotto.getNome() : "Prodotto non disponibile";
%>
            <li>
                <span><%= nomeProdotto %> × <%= d.getQuantità() %></span>
                <span>€ <%= String.format("%.2f", d.getPrezzoUnitario() * d.getQuantità()) %></span>
            </li>
<%
                }
            }
%>
        </ul>

        <p class="ordine-totale">Totale: € <%= String.format("%.2f", totaleOrdine) %></p>
    </div>
<%
        }
    }
%>

</main>

</body>
</html>