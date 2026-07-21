<%@page import="it.animalcare.model.ProdottoModel"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestione Prodotti - Admin</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/admin.css">
<script src="<%= request.getContextPath() %>/script/adminpr-ajax.js" defer></script>
</head>
<body>

<header>
<a href="<%= request.getContextPath() %>/AdminServlet" class="logo">AnimalCare - Admin</a>
<a href="<%= request.getContextPath() %>/LogoutServlet" class="logoutButton">logout</a>
</header>

<main>
<h1>Gestione Catalogo</h1>

<%
    String errore = (String) request.getAttribute("errore");
    if (errore != null) {
%>
    <p class="errore"><%= errore %></p>
<%
    }
%>

<a href="<%= request.getContextPath() %>/AdminProdottiServlet?azione=nuovo" class="btn-nuovo">+ Nuovo prodotto</a>

<%
    Collection<ProdottoModel> prodotti = (Collection<ProdottoModel>) request.getAttribute("prodotti");
    Map<Integer, String> nomiCategorie = (Map<Integer, String>) request.getAttribute("nomiCategorie");

    if (prodotti == null || prodotti.isEmpty()) {
%>
    <p class="nessun-prodotto">Nessun prodotto nel catalogo.</p>
<%
    } else {
%>
    <table>
        <thead>
            <tr>
                <th>Immagine</th>
                <th>Nome</th>
                <th>Categoria</th>
                <th>Prezzo</th>
                <th>Disponibilità</th>
                <th>Stato</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
<%
        for (ProdottoModel prodotto : prodotti) {
            String rigaClasse = prodotto.isAttivo() ? "" : "riga-disattivata";
            String nomeCategoria = (nomiCategorie != null) ? nomiCategorie.get(prodotto.getIdCategoria()) : null;
            if (nomeCategoria == null) nomeCategoria = "N/D";
%>
            <tr class="<%= rigaClasse %>" data-id="<%= prodotto.getId() %>" data-categoria="<%= prodotto.getIdCategoria() %>">
                <td><img src="<%= request.getContextPath() %>/<%= prodotto.getImmagine() %>" alt="<%= prodotto.getNome() %>" width="50"></td>
                <td><%= prodotto.getNome() %></td>
                <td><%= nomeCategoria %></td>
                <td>€ <%= String.format("%.2f", prodotto.getPrezzo()) %></td>
                <td><%= prodotto.getDisponibilità() %></td>
                <td class="cella-stato">
                    <% if (prodotto.isAttivo()) { %>
                        <span class="stato attivo">Attivo</span>
                    <% } else { %>
                        <span class="stato disattivo">Disattivato</span>
                    <% } %>
                </td>
                <td class="azioni">
                    <a href="<%= request.getContextPath() %>/AdminProdottiServlet?azione=modifica&id=<%= prodotto.getId() %>&categoria=<%= prodotto.getIdCategoria() %>" class="btn-modifica">Modifica</a>

                    <% if (prodotto.isAttivo()) { %>
                        <button type="button" class="btn-elimina btn-toggle-stato" data-azione="elimina">Elimina</button>
                    <% } else { %>
                        <button type="button" class="btn-riattiva btn-toggle-stato" data-azione="riattiva">Riattiva</button>
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

<p><a href="<%= request.getContextPath() %>/AdminServlet">Torna alla dashboard</a></p>

</main>

</body>
</html>