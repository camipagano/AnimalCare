<%@page import="it.animalcare.model.ProdottoModel"%>
<%@page import="it.animalcare.model.CategoriaModel"%>
<%@page import="java.util.Collection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Prodotto - Admin</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/admin.css">
<script src="<%= request.getContextPath() %>/script/adminprodotto.js" defer></script>
</head>
<body>

<header>
<a href="<%= request.getContextPath() %>/AdminServlet" class="logo">AnimalCare - Admin</a>
<a href="<%= request.getContextPath() %>/LogoutServlet" class="logoutButton">logout</a>
</header>

<main>

<%
    ProdottoModel prodotto = (ProdottoModel) request.getAttribute("prodotto");
    Collection<CategoriaModel> categorie = (Collection<CategoriaModel>) request.getAttribute("categorie");
    boolean modifica = (prodotto != null);
%>

<h1><%= modifica ? "Modifica prodotto" : "Nuovo prodotto" %></h1>

<%
    String errore = (String) request.getAttribute("errore");
    if (errore != null) {
%>
    <p class="errore"><%= errore %></p>
<%
    }
%>

<form action="<%= request.getContextPath() %>/AdminProdottiServlet" method="POST" class="form-prodotto">
    <input type="hidden" name="azione" value="salva">
    <% if (modifica) { %>
        <input type="hidden" name="id" value="<%= prodotto.getId() %>">
    <% } %>

    <label for="nome">Nome</label>
    <input type="text" id="nome" name="nome" value="<%= modifica ? prodotto.getNome() : "" %>" required>

    <label for="descrizione">Descrizione</label>
    <textarea id="descrizione" name="descrizione" rows="3" required><%= modifica ? prodotto.getDescrizione() : "" %></textarea>

    <label for="categoria">Categoria</label>
    <select id="categoria" name="categoria" required>
        <option value="">-- Seleziona --</option>
<%
        if (categorie != null) {
            for (CategoriaModel cat : categorie) {
                boolean selezionata = modifica && cat.getId() == prodotto.getIdCategoria();
%>
        <option value="<%= cat.getId() %>" <%= selezionata ? "selected" : "" %>><%= cat.getNome() %></option>
<%
            }
        }
%>
    </select>

    <label for="prezzo">Prezzo (€)</label>
    <input type="number" id="prezzo" name="prezzo" step="0.01" min="0" value="<%= modifica ? prodotto.getPrezzo() : "" %>" required>

    <label for="disponibilita">Disponibilità</label>
    <input type="number" id="disponibilita" name="disponibilita" min="0" value="<%= modifica ? prodotto.getDisponibilità() : "" %>" required>

    <label for="immagine">Percorso immagine</label>
    <input type="text" id="immagine" name="immagine" placeholder="es. img/gatti/nome.png" value="<%= modifica ? prodotto.getImmagine() : "" %>" required>

    <label for="mimeType">Tipo immagine (MIME type)</label>
    <input type="text" id="mimeType" name="mimeType" placeholder="es. image/png" value="<%= modifica ? prodotto.getMimeType() : "image/png" %>" required>

    <label class="checkbox-label">
        <input type="checkbox" id="attivo" name="attivo" <%= (!modifica || prodotto.isAttivo()) ? "checked" : "" %>>
        Prodotto attivo (visibile nel catalogo)
    </label>

    <button type="submit"><%= modifica ? "Salva modifiche" : "Crea prodotto" %></button>
</form>

<p><a href="<%= request.getContextPath() %>/AdminProdottiServlet">Torna alla lista</a></p>

</main>

</body>
</html>