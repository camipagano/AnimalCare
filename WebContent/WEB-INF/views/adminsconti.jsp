<%@page import="java.util.Map"%>
<%@page import="it.animalcare.model.ProdottoModel"%>
<%@page import="java.util.Collection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestione sconti - Admin</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/admin.css">
<script src="<%= request.getContextPath() %>/script/adminsconti-ajax.js?v=<%= System.currentTimeMillis()%>" defer></script>
</head>
<body class="page-sconti">

<header>
<a href="<%= request.getContextPath() %>/AdminServlet" class="logo">AnimalCare - Admin</a>
<a href="<%= request.getContextPath() %>/LogoutServlet" class="logoutButton">Logout</a>
</header>

<main>
<div class="titolo-pagina">
    <h1>Gestione Sconti</h1>
</div>

<%
    Double scontoAttivo = (Double) application.getAttribute("scontoGenerale");
    if (scontoAttivo == null) scontoAttivo = 0.0;
    boolean haSconto = scontoAttivo > 0;
%>

<div class="sconto-box">
    <form class="form-sconto" action="<%= request.getContextPath() %>/AdminScontiServlet" method="POST">
        <label class="label-sconto" for="percentualeSconto">
            <%= haSconto ? "Sconto in atto (" + String.format("%.0f", scontoAttivo) + "%):" : "Impostare sconto (%):" %>
        </label>

        <input type="number" class="percentualeSconto" name="percentualeSconto" min="0" max="100" step="1"  value="<%= haSconto ? String.format("%.0f", scontoAttivo) : "" %>"
               placeholder="es. 20">

        <button type="submit" class="btn-sconto <%= haSconto ? "btn-rimuovi" : "btn-applica" %>">
            <%= haSconto ? "Rimuovi" : "Applica" %>
        </button>
    </form>
</div>

<%
    Collection<ProdottoModel> prodotti = (Collection<ProdottoModel>) request.getAttribute("prodotti");
    Map<Integer, String> nomiCategorie = (Map<Integer, String>) request.getAttribute("nomiCategorie");

    if (prodotti == null || prodotti.isEmpty()) {
%>
    <p class="nessun-prodotto">Nessun prodotto nel catalogo.</p>
<%
    } else {
%>
    <table id="tabella-prodotti">
        <thead>
            <tr>
                <th>Immagine</th>
                <th>Nome</th>
                <th>Categoria</th>
                <th>Prezzo</th>
                <th>Disponibilità</th>
                <th>Stato</th>
            </tr>
        </thead>
        <tbody>
<%
        for (ProdottoModel prodotto : prodotti) {
            String rigaClasse = prodotto.isAttivo() ? "" : "riga-disattivata";
            String nomeCategoria = (nomiCategorie != null) ? nomiCategorie.get(prodotto.getIdCategoria()) : null;
            if (nomeCategoria == null) nomeCategoria = "N/D";

            float prezzoOriginale = prodotto.getPrezzo();
            double prezzoCalcolato = haSconto ? (prezzoOriginale * (1 - (scontoAttivo / 100.0))) : prezzoOriginale;
%>
            <tr class="<%= rigaClasse %>" data-prezzo-base="<%= prezzoOriginale %>">
                <td data-label="Immagine"><img src="<%= request.getContextPath() %>/<%= prodotto.getImmagine() %>" alt="<%= prodotto.getNome() %>" width="50"></td>
                <td data-label="Nome"><%= prodotto.getNome() %></td>
                <td data-label="Categoria"><%= nomeCategoria %></td>
                <td class="cella-prezzo" data-label="Prezzo">€ <%= String.format("%.2f", prezzoCalcolato) %></td>
                <td data-label="Disponibilità"><%= prodotto.getDisponibilità() %></td>
                <td data-label="Stato">
                    <% if (prodotto.isAttivo()) { %>
                        <span class="stato attivo">Attivo</span>
                    <% } else { %>
                        <span class="stato disattivo">Disattivato</span>
                    <% } %>
                </td>
            </tr>
<%
        }
%>
        </tbody>
    </table>
<%
    }
%>

<p style="margin-top: 25px;"><a href="<%= request.getContextPath() %>/AdminServlet">Torna alla dashboard</a></p>
</main>

</body>
</html>