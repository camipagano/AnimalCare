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
<title>Gestione Ordini - Admin</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/admin.css">
<script src="<%= request.getContextPath() %>/script/adminor-ajax.js" defer></script>
</head>
<body class="ordini-page">

<header>
<a href="<%= request.getContextPath() %>/AdminServlet" class="logo">AnimalCare - Admin</a>
<a href="<%= request.getContextPath() %>/LogoutServlet" class="logoutButton">Logout</a>
</header>

<main>
<div class="titolo-pagina">
    <h1>Gestione Ordini</h1>
</div>

<%
    String errore = (String) request.getAttribute("errore");
    if (errore != null) {
%>
    <p class="errore"><%= errore %></p>
<%
    }

    String dataInizio = (String) request.getAttribute("dataInizio");
    String dataFine = (String) request.getAttribute("dataFine");
    String clienteFiltro = (String) request.getAttribute("cliente");
%>

<form action="<%= request.getContextPath() %>/AdminOrdiniServlet" method="GET" class="form-filtri">
    <label for="dataInizio">Da</label>
    <input type="date" id="dataInizio" name="dataInizio" value="<%= (dataInizio != null) ? dataInizio : "" %>">

    <label for="dataFine">A</label>
    <input type="date" id="dataFine" name="dataFine" value="<%= (dataFine != null) ? dataFine : "" %>">

    <label for="cliente">Cliente (nome o email)</label>
    <input type="text" id="cliente" name="cliente" value="<%= (clienteFiltro != null) ? clienteFiltro : "" %>">

    <button type="submit">Filtra</button>
    <a href="<%= request.getContextPath() %>/AdminOrdiniServlet" class="btn-reset">Reset</a>
</form>

<%
    Collection<OrdineModel> ordini = (Collection<OrdineModel>) request.getAttribute("ordini");
    Map<Integer, List<DettaglioOrdineModel>> dettagliPerOrdine = (Map<Integer, List<DettaglioOrdineModel>>) request.getAttribute("dettagliPerOrdine");
    Map<Integer, MetodoPagamentoModel> pagamentoPerOrdine = (Map<Integer, MetodoPagamentoModel>) request.getAttribute("pagamentoPerOrdine");
    Map<Integer, String> clientePerOrdine = (Map<Integer, String>) request.getAttribute("clientePerOrdine");
    Map<Integer, ProdottoModel> prodottiPerId = (Map<Integer, ProdottoModel>) request.getAttribute("prodottiPerId");

    if (ordini == null || ordini.isEmpty()) {
%>
    <p class="nessun-prodotto">Nessun ordine trovato.</p>
<%
    } else {
        for (OrdineModel ordine : ordini) {
            List<DettaglioOrdineModel> dettagli = dettagliPerOrdine.get(ordine.getCodice());
            MetodoPagamentoModel pagamento = pagamentoPerOrdine.get(ordine.getCodice());
            String nomeCliente = clientePerOrdine.get(ordine.getCodice());
            float totaleOrdine = 0;
            if (dettagli != null) {
                for (DettaglioOrdineModel d : dettagli) {
                    totaleOrdine += d.getPrezzoUnitario() * d.getQuantità();
                }
            }
%>
    <div class="ordine-box" data-codice="<%= ordine.getCodice() %>" data-idutente="<%= ordine.getIdUtente() %>">
        <div class="ordine-header">
            <h2>Ordine #<%= ordine.getCodice() %> - <%= nomeCliente %></h2>
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

        <form action="<%= request.getContextPath() %>/AdminOrdiniServlet" method="GET" class="form-stato">
            <input type="hidden" name="cambiaStato" value="1">
            <input type="hidden" name="codice" value="<%= ordine.getCodice() %>">
            <input type="hidden" name="idUtenteOrdine" value="<%= ordine.getIdUtente() %>">
            <select name="nuovoStato">
                <option value="In lavorazione" <%= "In lavorazione".equals(ordine.getStato()) ? "selected" : "" %>>In lavorazione</option>
                <option value="Spedito" <%= "Spedito".equals(ordine.getStato()) ? "selected" : "" %>>Spedito</option>
                <option value="Consegnato" <%= "Consegnato".equals(ordine.getStato()) ? "selected" : "" %>>Consegnato</option>
                <option value="Annullato" <%= "Annullato".equals(ordine.getStato()) ? "selected" : "" %>>Annullato</option>
            </select>
            <button type="submit">Aggiorna stato</button>
            <span class="stato-msg"></span>
        </form>
    </div>
<%
        }
    }
%>

<p><a href="<%= request.getContextPath() %>/AdminServlet">Torna alla dashboard</a></p>

</main>

</body>
</html>