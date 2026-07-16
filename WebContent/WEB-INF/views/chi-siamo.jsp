<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi siamo</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/chi-siamo.css">
</head>
<body>

<header>

<h1 class= "logo">Chi siamo?</h1>

</header>

<main>
<p>AnimalCare è uno shop nato con l'obiettivo di soddisfare tutte le necessità dei nostri amici a 4 zampe. <br>
Forniamo servizi che variano per tutte le specie di animali domestici con prodotti che possono essere semplice cibo o anche accessori e strumenti di toelettatura.</p>

<p>Rivendiamo solo le marche migliori per garantire la migliore qualità al prezzo più basso.</p>

<p>Ci trovate online sul sito ufficiale: <a href= "<%= request.getContextPath() %>/HomeServlet">AnimalCare</a><br>
E nelle seguenti sedi:</p>
<ul class="lista-sedi">
<li><a href="https://www.google.com/maps/place/Liceo+Scientifico+Statale+Renato+Caccioppoli+-+Scafati/@40.7554322,14.5172136,481m/data=!3m3!1e3!4b1!5s0x133bbc7e17ec36ed:0x9f5f84683c430856!4m6!3m5!1s0x133bbc7e13a15e57:0x1fe437f30e473369!8m2!3d40.7554322!4d14.5197885!16s%2Fg%2F11b6cj0cnq?entry=ttu&g_ep=EgoyMDI2MDYyOS4wIKXMDSoASAFQAw%3D%3D">Via Domenico Velleca, 56, Scafati(SA)</a> </li>  
<li><a href="https://www.google.com/maps/place/Universit%C3%A0+degli+Studi+di+Salerno/@40.7752009,14.7857929,481m/data=!3m2!1e3!4b1!4m6!3m5!1s0x133bc5c7456b88bd:0x80bab96149d2993d!8m2!3d40.7752009!4d14.7883678!16zL20vMDZxdmpf?entry=ttu&g_ep=EgoyMDI2MDYyOS4wIKXMDSoASAFQAw%3D%3D">Via Giovanni Paolo II, 132, Fisciano(SA)</a></li>
<li><a href="https://www.google.com/maps/place/Istituto+d'Istruzione+Superiore+Genovesi+-+da+Vinci/@40.6818651,14.761125,481m/data=!3m2!1e3!4b1!4m6!3m5!1s0x133bc22e0f17aaf9:0x702f92b250c71c78!8m2!3d40.6818651!4d14.7636999!16s%2Fg%2F1ptxtd0s8?entry=ttu&g_ep=EgoyMDI2MDYyOS4wIKXMDSoASAFQAw%3D%3D">Via Principessa Sichelgaita, 12/a, Salerno(Sa)</a></li>
</ul>
<p>Troverete uno staff disponibile e preparato, sempre pronto ad assistervi e consigliarvi in caso di dubbi.<br>
Nel caso in cui non sarà presente in negozio qualche prodotto presente nel catalogo, c'è la possibilità di ordinarlo direttamente sul posto, vi basterà rivolgervi ai nostri dipendenti.</p>

<h2 class="sottotitolo">Informazioni ordini</h2>
<p> Gli ordini online (che siano dal sito o in negozio) arrivano tra i 2 e i 7 giorni lavorativi, a seconda della disponibilità dei prododtti selezionati in magazzino. <br>
Potrete sempre tenere traccia dei vostri ordini (nel caso in cui li abbiate ordinati dal sito) facendo il login e andando nella sezione "Traccia i miei ordini".<br>
Nel caso in cui l'ordine sia stato effettuato in negozio, verrete aggiornati dal nostro staff via email.
</p>
<p class="nota-importante">Non è possibile effettuare resi</p>
<p>Nel caso abbiate bisogno di comunicare con un responsabile, troverete tutti i <a href="contatti.jsp">contatti</a></p>
</main>

<footer>
    <ul>
        <li><a href="<%= request.getContextPath() %>/ContattiServlet">Contatti</a></li>
        <li><a href="<%= request.getContextPath() %>/HomeServlet">Home</a></li>
    </ul>
</footer>

</body>
</html>