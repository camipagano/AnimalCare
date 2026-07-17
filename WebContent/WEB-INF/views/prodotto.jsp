<%@page import="it.animalcare.model.ProdottoModel"%>
<%@page import="it.animalcare.model.RecensioneModel"%>
<%@page import="it.animalcare.model.UtenteModel"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dettaglio Prodotto</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/prodotto.css">
<script src="<%= request.getContextPath() %>/script/prodotto.js" defer></script>
</head>
<body>

<header>
<a href="<%= request.getContextPath() %>/HomeServlet" class="logo">AnimalCare</a>
</header>

<main>

<%
    String errore = (String) request.getAttribute("errore");
    if (errore != null) {
%>
    <p class="errore"><%= errore %></p>
<%
    }

    ProdottoModel prodotto = (ProdottoModel) request.getAttribute("prodotto");

    if (prodotto != null) {
%>

<div class="dettaglio-prodotto">
    <div class="prod-img">
        <img src="<%= request.getContextPath() %>/<%= prodotto.getImmagine() %>" alt="<%= prodotto.getNome() %>">
    </div>
    <div class="prod-dettagli">
        <h1><%= prodotto.getNome() %></h1>
        <p class="descrizione"><%= prodotto.getDescrizione() %></p>
        <p class="disponibilita">
            <% if (prodotto.getDisponibilità() > 0) { %>
                Disponibilità: <%= prodotto.getDisponibilità() %> pezzi
            <% } else { %>
                <span class="non-disponibile">Non disponibile</span>
            <% } %>
        </p>
        <p class="price">€ <%= String.format("%.2f", prodotto.getPrezzo()) %></p>

        <% if (prodotto.getDisponibilità() > 0) { %>
        <form action="<%= request.getContextPath() %>/CarrelloServlet" method="POST">
            <input type="hidden" name="azione" value="aggiungi">
            <input type="hidden" name="idProdotto" value="<%= prodotto.getId() %>">
            <input type="hidden" name="idCategoria" value="<%= prodotto.getIdCategoria() %>">
            <label for="quantita">Quantità</label>
            <input type="number" id="quantita" name="quantita" value="1" min="1" max="<%= prodotto.getDisponibilità() %>">
            <button type="submit">Aggiungi al carrello</button>
        </form>
        <% } %>
    </div>
</div>

<section class="recensioni">
    <h2>Recensioni</h2>

<%
    @SuppressWarnings("unchecked")
    Collection<RecensioneModel> recensioni = (Collection<RecensioneModel>) request.getAttribute("recensioni");
    @SuppressWarnings("unchecked")
    Map<Integer, String> nomiUtenti = (Map<Integer, String>) request.getAttribute("nomiUtenti");

    if (recensioni == null || recensioni.isEmpty()) {
%>
    <p class="no-recensioni">Nessuna recensione per questo prodotto. Sii il primo a lasciarne una!</p>
<%
    } else {
        for (RecensioneModel r : recensioni) {
            String nomeAutore = (nomiUtenti != null) ? nomiUtenti.get(r.getIdUtente()) : "Utente";
%>
    <div class="recensione">
        <p class="recensione-autore"><strong><%= nomeAutore %></strong> — voto: <%= r.getVoto() %>/5</p>
        <p class="recensione-commento"><%= r.getCommento() %></p>
        <p class="recensione-data"><%= r.getData() %></p>
    </div>
<%
        }
    }

    UtenteModel utenteLoggato = (UtenteModel) session.getAttribute("utenteLoggato");
    if (utenteLoggato != null) {
%>
    <h3>Lascia una recensione</h3>
    <form action="<%= request.getContextPath() %>/ProdottoServlet?id=<%= prodotto.getId() %>&categoria=<%= prodotto.getIdCategoria() %>" method="POST">
        <input type="hidden" name="idProdotto" value="<%= prodotto.getId() %>">
        <label for="voto">Voto</label>
        <select id="voto" name="voto" required>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5" selected>5</option>
        </select>
        <label for="commento">Commento</label>
        <textarea id="commento" name="commento" rows="3" required></textarea>
        <button type="submit">Invia recensione</button>
    </form>
<%
    } else {
%>
    <p><a href="<%= request.getContextPath() %>/LoginServlet">Accedi</a> per lasciare una recensione.</p>
<%
    }
%>
</section>

<p><a href="<%= request.getContextPath() %>/HomeServlet">Torna alla home</a></p>

<%
    }
%>

</main>

</body>
</html>