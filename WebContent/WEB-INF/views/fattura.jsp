<%@page import="it.animalcare.model.OrdineModel"%>
<%@page import="it.animalcare.model.DettaglioOrdineModel"%>
<%@page import="it.animalcare.model.MetodoPagamentoModel"%>
<%@page import="it.animalcare.model.ProdottoModel"%>
<%@page import="it.animalcare.model.UtenteModel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
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
<%
    OrdineModel ordine = (OrdineModel) request.getAttribute("ordine");
    List<DettaglioOrdineModel> dettagli = (List<DettaglioOrdineModel>) request.getAttribute("dettagli");
    MetodoPagamentoModel pagamento = (MetodoPagamentoModel) request.getAttribute("pagamento");
    Map<Integer, ProdottoModel> prodottiPerId = (Map<Integer, ProdottoModel>) request.getAttribute("prodottiPerId");
    UtenteModel cliente = (UtenteModel) request.getAttribute("cliente");
    Float spedizione = (Float) request.getAttribute("spedizione");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fattura</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/fattura.css">
</head>
<body>

<div class="foglio-word">
        <!-- Bottone di stampa rapida del browser -->
        <button class="btn-stampa" onclick="window.print()">Stampa / Salva PDF</button>
        
        <div class="intestazione">
            <div class="logo">
                <h1>AnimalCare</h1>
                <p>Prodotti e Servizi per Animali Domestici<br>Email: info@animalcare.it</p>
            </div>
            <div class="titolo-documento">
                <h2>FATTURA</h2>
                <p>Codice Ordine: #<%= ordine.getCodice() %></p>
            </div>
        </div>
        
        <div class="sezione-dati">
            <div class="blocco-dati">
                <h3>Informazioni Ordine</h3>
                <p>Data Emissione: <%= ordine.getData() %></p>
                <p>Stato Ordine: <%= escapeHtml(ordine.getStato()) %></p>
                <p>Metodo Pagamento: <%= (pagamento != null) ? escapeHtml(pagamento.getNome()) : "N/D" %></p>
            </div>
            
            <div class="blocco-dati">
                <h3>Intestatario e Spedizione</h3>
                <p><strong>Cliente:</strong> <%= escapeHtml(cliente.getNome()) %> <%= escapeHtml(cliente.getCognome()) %></p>
                <p><strong>Indirizzo Spedizione:</strong> <%= escapeHtml(ordine.getIndirizzo()) %></p>
            </div>
        </div>
        
        <table class="tabella-fattura">
            <tr>
                <th>Descrizione Articolo</th>
                <th class="allinea-destra">Prezzo Unitario</th>
                <th class="allinea-destra">Quantità</th>
                <th class="allinea-destra">Importo</th>
            </tr>
            
            <%
                float subtotaleGenerale = 0;
                if (dettagli != null) {
                    for (DettaglioOrdineModel d : dettagli) {
                        ProdottoModel prodotto = prodottiPerId.get(d.getIdProdotto());
                        String nomeProdotto = (prodotto != null) ? prodotto.getNome() : "Prodotto non più disponibile";
                        
                        double prezzoUnitario = d.getPrezzoUnitario();
                        double totaleRiga = prezzoUnitario * d.getQuantità();
                        subtotaleGenerale += totaleRiga;
            %>
            <tr>
                <td><%= escapeHtml(nomeProdotto) %></td>
                <td class="allinea-destra">€ <%= String.format("%.2f", prezzoUnitario) %></td>
                <td class="allinea-destra"><%= d.getQuantità() %></td>
                <td class="allinea-destra">€ <%= String.format("%.2f", totaleRiga) %></td>
            </tr>
            <%
                    }
                }
                double costoSpedizione = (spedizione != null) ? spedizione : 0.00f;
                double totaleComplessivo = subtotaleGenerale + costoSpedizione;
            %>
        </table>
        
        <div class="riepilogo-totale">
            <div class="riga-prezzo">
                <span>Imponibile prodotti:</span>
                <span>€ <%= String.format("%.2f", subtotaleGenerale) %></span>
            </div>
            <div class="riga-prezzo">
                <span>Spedizione:</span>
                <span>€ <%= String.format("%.2f", costoSpedizione) %></span>
            </div>
            <div class="riga-totale-finale">
                <span>TOTALE:</span>
                <span>€ <%= String.format("%.2f", totaleComplessivo) %></span>
            </div>
        </div>
    </div>

</body>
</html>