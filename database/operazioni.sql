INSERT INTO categoria (Nome) VALUES
('Cani'),
('Gatti'),
('Cavalli'),
('Conigli'),
('Uccelli'),
('Pesci e Tartarughe');

INSERT INTO prodotto (Nome, Descrizione, Disponibilita, Prezzo, ID_Categoria, immagine, mime_type, attivo) VALUES
('Ciotola Gatto Food', 'Ciotola celeste in acciaio inox da 240 ml, con base antiscivolo e simpatica decorazione', 20, 8.90, 2, 'ciotola1.png', 'image/png', 1),
('Ciotola Gatto Doppia', 'Set ciotole in acciaio inox rimovibili e lavabili in lavastoviglie, con supporto a forma di gatto e piedini antiscivolo', 20, 11.50, 2, 'ciotola2.png', 'image/png', 1),
('Ciotola Gatto Ceramica', 'Ciotola rosa in ceramica da 250 ml, robusta e facile da pulire anche in lavastoviglie', 20, 11.90, 2, 'ciotola3.png', 'image/png', 1),
('Collare Gatto con Fiore', 'Collare modello Bloom regolabile in nylon e fibbia di sicurezza per prevenire rischi di strangolamento, lavabile anche in lavatrice a 30°C massimo con programmi brevi e senza centrifuga', 20, 7.50, 2, 'collare1.png', 'image/png', 1),
('Collare Gatto con Fragola', 'Collare modello Berry Love regolabile in nylon e fibbia di sicurezza per prevenire rischi di strangolamento, lavabile anche in lavatrice a 30°C massimo con programmi brevi e senza centrifuga', 20, 7.50, 2, 'collare2.png', 'image/png', 1),
('Collare Gatto con Avocado', 'Collare modello Avocado regolabile in nylon e fibbia di sicurezza per prevenire rischi di strangolamento, lavabile anche in lavatrice a 30°C massimo con programmi brevi e senza centrifuga', 20, 7.50, 2, 'collare3.png', 'image/png', 1),
('Collare Gatto con Caramella', 'Collare modello Gummy Bears regolabile in nylon e fibbia di sicurezza per prevenire rischi di strangolamento, lavabile anche in lavatrice a 30°C massimo con programmi brevi e senza centrifuga', 20, 7.50, 2, 'collare4.png', 'image/png', 1),
('Collare Gatto Antiparassitario', 'Collare Seresto antizecche e antipulci con protezione continua fino a 7-8 mesi, inodore e resistente a contatti occasionali con l’acqua', 20, 22.90, 2, 'collare5.png', 'image/png', 1),
('Dentalife Snack Dentale Salmone', 'Snack dentale Purina Dentalife da 40g al gusto salmone, aiuta a ridurre la formazione di tartaro nei gatti adulti grazie alla sua consistenza porosa e croccante', 20, 3.50, 2, 'dentalife1.png', 'image/png', 1),
('Dentalife Snack Dentale Pollo', 'Snack dentale Purina Dentalife da 40g al gusto pollo, aiuta a ridurre la formazione di tartaro nei gatti adulti grazie alla sua consistenza porosa e croccante', 20, 3.50, 2, 'dentalife2.png', 'image/png', 1),
('Felix Le Ghiottonerie Junior', '10 bustine Purina Felix da 85g con teneri bocconcini di manzo e pollo in gelatina, adatto a gattini dai 2 ai 12 mesi per sostenere lo sviluppo di muscoli, ossa e denti sani', 20, 5.90, 2, 'felix1.png', 'image/png', 1),
('Felix Le Ghiottonerie Preferite', '10 bustine Purina Felix da 85g con teneri bocconcini in gelatina di manzo e pollo oppure salmone e tonno, ricchi di vitamine e minerali senza coloranti', 20, 5.90, 2, 'felix2.png', 'image/png', 1),
('Felix Le Ghiottonerie Varietà', '10 bustine Purina Felix da 85g con teneri bocconcini in gelatina di platessa e tonno oppure coniglio e pollo, ricchi di vitamine e minerali senza coloranti', 20, 5.90, 2, 'felix3.png', 'image/png', 1),
('Felix Le Ghiottonerie Verdure', '10 bustine Purina Felix da 85g con teneri bocconcini in gelatina di manzo e carote oppure pollo e pomodoro, ricchi di vitamine e minerali senza coloranti', 20, 5.90, 2, 'felix4.png', 'image/png', 1),
('Gioco Gatto Piume', 'Giocattolo Zolux Ethi’Cat realizzato con materiale riciclato e naturale, ideale per stimolare l’istinto predatorio e favorire l’esercizio fisico del proprio gatto', 20, 2.50, 2, 'gioco1.png', 'image/png', 1),
('Gioco Gatto Laser', 'Giocattolo interattivo Zolux Enjoy Laser per gatti, con un fascio di luce rossa per stimolare l’attività felina e dotato di un pratico portachiavi', 20, 4.90, 2, 'gioco2.png', 'image/png', 1),
('Gioco Gatto Topolino', 'Morbido topolino giocattolo in peluche, dotato di una lunga coda con un pon pon per attirare l’attenzione del proprio gatto grazie anche alla presenza di erba gatta al suo interno', 20, 2.50, 2, 'gioco3.png', 'image/png', 1),
('Guanto Leva Pelo Lovedì', 'Set composto da due guanti con cinturino regolabile e piccoli puntini in silicone che catturano peli, sporco e polvere non solo dal proprio animale ma anche da divani, letti e tappeti', 20, 6.50, 2, 'pulizia1.png', 'image/png', 1),
('Spazzola Lovedì', 'Morbida spazzola per gatti con setole in nylon per lucidare e lisciare tutti i tipi di pelo, dotata di un’impugnatura ergonomica e antiscivolo per una presa confortevole durante la toelettatura', 20, 7.50, 2, 'pulizia2.png', 'image/png', 1),
('Taglia Unghie Lovedì', 'Forbicine per gatti di taglia S con lame in acciaio inossidabile per garantire un taglio netto e preciso, facilitato da una comoda tacca di sicurezza in modo da non accorciare troppo l’unghia', 20, 5.90, 2, 'pulizia3.png', 'image/png', 1),
('Cardatore Lovedì', 'Cardatore per gatti di taglia S con setole in acciaio per districare il sottopelo, rimuovendo i peli morti e prevenendo la formazione di nodi', 20, 7.90, 2, 'pulizia4.png', 'image/png', 1),
('Tiragraffi Torre Multipiano', 'Tiragraffi beige in sisal di misure 103x71x49 cm che comprende una comoda cuccia, una piccola amaca e una pallina in peluche appesa', 20, 39.90, 2, 'tiragraffi1.png', 'image/png', 1),
('Tiragraffi Palo con Labirinto', 'Colonna tiragraffi in robusto sisal di misure 43,5x30 cm, dotata di una base con binari per far scorrere le palline e un pendente in legno appeso con una piuma', 20, 9.90, 2, 'tiragraffi2.png', 'image/png', 1),
('Trasportino Rigido Grigio', 'Trasportino per gatti fino a 8kg in plastica resistente con porta di metallo, conforme agli standard IATA per il trasporto aereo e dotato di una comoda lettiera perfetta per affrontare lunghi viaggi', 20, 32.90, 2, 'trasportino1.png', 'image/png', 1),
('Trasportino Nero con Borsa Imbottita', 'Trasportino in poliestere di dimensioni 29x31x49 cm adatto sia in casa che in viaggio, dotato di cuccia interna estraibile in peluche e varie aperture frontali, laterali e superiori', 20, 35.90, 2, 'trasportino2.png', 'image/png', 1),
('Whiskas Adult Pollo', 'Confezione da 1,4 kg di crocchette Whiskas al pollo per gatti adulti con vitamina E, taurina e minerali per supportare il sistema immunitario e favorire il benessere del cuore e del tratto urinario', 20, 6.70, 2, 'whiskas1.png', 'image/png', 1),
('Whiskas Junior Pollo', 'Confezione da 1,4 kg di crocchette Whiskas al pollo per gattini in crescita di età compresa tra 2 e 12 mesi, facili da digerire e con nutrienti essenziali per lo sviluppo', 20, 6.60, 2, 'whiskas2.png', 'image/png', 1),
('Whiskas Adult Tonno', 'Confezione da 1,4 kg di crocchette Whiskas al tonno per gatti adulti con vitamina E, taurina e minerali per supportare il sistema immunitario e favorire il benessere del cuore e del tratto urinario', 20, 6.70, 2, 'whiskas3.png', 'image/png', 1),
('Whiskas Adult Manzo', 'Confezione da 1,4 kg di crocchette Whiskas al manzo per gatti adulti con vitamina E, taurina e minerali per supportare il sistema immunitario e favorire il benessere del cuore e del tratto urinario', 20, 6.70, 2, 'whiskas4.png', 'image/png', 1);

INSERT INTO prodotto (Nome, Descrizione, Disponibilita, Prezzo, ID_Categoria, immagine, mime_type, attivo) VALUES
('Ciotola Cane Doppia', 'Set ciotole in acciaio inox rimovibili e lavabili in lavastoviglie, con supporto in legno e decorazioni con motivo a zampetta di cane', 20, 15.90, 1, 'img/cani/ciotola1.jpg', 'image/jpg', 1),
('Ciotola Cane Food', 'Ciotola in acciaio inox lavabile in lavastoviglie con base antiscivolo e decoro monocolore con frase simpatica', 20,  10.50, 1, 'img/cani/ciotola2.jpg', 'image/jpg', 1),
('Ciotola Cani Anti-Voracità', 'Ciotola in plastica dura lavabile in lavastoviglie con base antiscivolo e irregolarità al suo interno per rallentare l''assunzione di cibo', 20, 10.90, 1, 'img/cani/ciotola3.jpg', 'image/jpg',1),
('Collare Cane in Tessuto', 'Collare blu, in tessuto, regolabile, con gancio e medaglietta in metallo', 20, 20.00, 1, 'img/cani/collare1.jpg', 'image/jpg', 1),
('Collare Cane in Tessuto', 'Collare lilla, in tessuto, regolabile, con gancio e medaglietta in metallo', 20, 20.00, 1, 'img/cani/collare2.jpg', 'image/jpg', 1),
('Collare Cane in Tessuto', 'Collare rosso, in tessuto, regolabile, con gancio e medaglietta in metallo', 20, 20.00, 1, 'img/cani/collare3.jpg', 'image/jpg', 1),
('Collare Cane in Tessuto', 'Collare verde, in tessuto, regolabile, con gancio e medaglietta in metallo', 20, 20.00, 1, 'img/cani/collare4.jpg', 'image/jpg', 1),
('Cravatta Cane Elegante', 'Collare con cravatta nera classica e colletti di camicia bianchi, regolabile', 20, 18.90, 1, 'img/cani/cravatta.jpg', 'image/jpg', 1),
('Fiocco Cane Elegante', 'Collare con fiocco rosa in velluto, regolabile, con gancio e medaglietta in metallo', 20, 20.00, 1, 'img/cani/fiocco.jpg', 'image/jpg', 1),
('Papillon Cane Elegante', 'Collare con papillon classico nero, regolabile e con fibia in metallo', 20, 18.90, 1, 'img/cani/papillon.jpg', 'image/jpg', 1),
('Collare Seresto Antipulci Cani', 'Collare Seresto antipulci per cani di taglia grande di peso superiore agli 8kg. Fino a 7-8 mesi di protezione', 20, 28.99, 1, 'img/cani/seresto1.jpg', 'image/jpg', 1),
('Collare Seresto Antipulci Cani', 'Collare Seresto antipulci per cani di taglia medio-piccola di peso non superiore ai 8kg. Fino a 7-8 mesi di protezione ', 20, 28.99, 1, 'img/cani/seresto2.jpg', 'image/jpg', 1),
('Gocce Antipulci Advantix Cani', 'Gocce antipulci advantix per cani di taglia grande di peso superiore ai 25kg', 20, 24.99, 1, 'img/cani/advantix.jpg', 'image/jpg', 1),
('Spazzola Cani Rimozione Facile', 'Spazzola per cani con presa in gomma, dentini in ferro e pulsante per facilitare la rimozione dei peli raccolti', 20, 7.99, 1, 'img/cani/spazzola1.jpg', 'image/jpg', 1),
('Spazzola Cani', 'Spazzola per cani con presa in plastica e sezione antiscivolo, dentini in ferro. In dotazione con pettine', 20, 7.50, 1, 'img/cani/spazzola2.jpg', 'image/jpg', 1),
('Spazzola Cani Pro', 'Spazzola per cani con presa in gomma, denti in ferro. Da utilizzare preferibilmente su cani di taglia grande a pelo medio-lungo', 20, 9.90, 1, 'img/cani/spazzola3.jpg', 'image/jpg', 1),
('Crocchette Cani Monge gusto Agnello', 'Pacco di crocchette Monge da 2,5 kg, gusto agnello e riso, adatto a tutti i tipi di cane. Per cuccioli e junior', 20, 40.99, 1, 'img/cani/monge1.jpg', 'image/jpg', 1),
('Crocchette Cani Monge gusto Trota', 'Pacco di crocchette Monge da 2,5 kg, gusto trota con riso e patate, adatto a tutti i tipi di cane adulti', 20, 40.99, 1, 'img/cani/monge2.jpg', 'image/jpg', 1),
('Crocchette Cani Monge gusto Maiale', 'Pacco di crocchette Monge da 12 kg, gusto maiale con riso e patate, adatto a tutti i tipi di cane adulti', 20, 40.99, 1, 'img/cani/monge3.jpg', 'image/jpg', 1),
('Cibo Cani Monge gusto Maiale', 'Scatoletta di cibo per cani Monge gusto maiale. Adatto a tutti i tipi di cane adulti', 20, 15.90, 1,  'img/cani/monge4.jpg', 'image/jpg', 1),
('Cibo Cani Monge gusto Anatra', 'Scatoletta di cibo per cani Monge gusto anatra. Adatto a tutti i tipi di cane adulti', 20, 15.90, 1,  'img/cani/monge5.jpg', 'image/jpg', 1),
('Cibo Cani Monge gusto Agnello', 'Scatoletta di cibo per cani Monge gusto agnello. Adatto a tutti i tipi di cane adulti', 20, 15.90, 1,  'img/cani/monge6.jpg', 'image/jpg', 1),
('Cibo Cani Monge gusto Pollo', 'Scatoletta di cibo per cani Monge gusto pollo. Adatto a tutti i tipi di cane adulti', 20, 15.90, 1,  'img/cani/monge7.jpg', 'image/jpg', 1),
('Cibo Cani Purina Pro Plan Gastrointestinal', 'Scatoletta di cibo per cani in mousse Purina Pro Plan per cani che soffrono di problemi gastrointestinali', 20, 3.45, 1, 'img/cani/purina1.jpg', 'image/jpg', 1),
('Cibo Cani Purina Pro Plan Hypoallergenic', 'Scatoletta di cibo per cani in mousse Purina Pro Plan ipoallergenica', 20, 3.45, 1, 'img/cani/purina2.jpg', 'image/jpg', 1),
('Cibo Cani Purina Pro Plan Renal Function', 'Scatoletta di cibo per cani in mousse Purina Pro Plan per cani che soffrono di problemi renali', 20, 3.45, 1, 'img/cani/purina3.jpg', 'image/jpg', 1),
('Crocchette Cani Royal Canin XL', 'Pacco di crocchette per cani Royal Canin per cani adulti di peso superiore ai 45 kg. Confezione da 15kg' , 20, 75.00, 1, 'img/cani/royal1.jpg', 'image/jpg', 1),
('Crocchette Cani Royal Canin M', 'Pacco di crocchette per cani Royal Canin per cani adulti di peso tra gli 11 e i 25 kg. Confezione da 15kg' , 20, 75.00, 1, 'img/cani/royal2.jpg', 'image/jpg', 1),
('Crocchette Cani Royal Canin S', 'Pacco di crocchette per cani Royal Canin per cani adulti di peso non superiore ai 10 kg. Confezione da 15kg' , 20, 75.00, 1, 'img/cani/royal3.jpg', 'image/jpg', 1),
('Crocchette Cani Royal Canin L', 'Pacco di crocchette per cani Royal Canin per cani adulti di peso tra i 26 e i 44kg. Confezione da 15kg' , 20, 75.00, 1, 'img/cani/royal4.jpg', 'image/jpg', 1),
('Pupazzo Procione Cani', 'Gioco per cani. Pupazzo di procione con squicker integrato. Adatto anche a giochi di forza' , 20, 15.30, 1, 'img/cani/gioco1.jpg', 'image/jpg', 1),
('Set Palline Cani', 'Set di 4 palline da gioco per cani. Palline di diverse forme con facce disegnate, in gomma, con squicker integrato' , 20, 17.00, 1, 'img/cani/gioco2.jpg', 'image/jpg', 1),
('Osso Rumoroso Cani', 'Gioco per cani. Osso di gomma bianco antistress, con scquicker integrato. Adatto ai cuccioli che stanno sviluppando i primi denti', 20, 17.00, 1, 'img/cani/gioco3.jpg', 'image/jpg', 1),
('Corda Resistente Cani', 'Gioco per cani. Corda con nodo alle estremità per giochi di forza ', 20, 12.99, 1, 'img/cani/gioco4.jpg', 'image/jpg', 1);

UPDATE prodotto  
SET mime_type = 'image/jpeg'  
WHERE mime_type = 'image/jpg' AND ID > 0;

INSERT INTO prodotto (Nome, Descrizione, Disponibilita, Prezzo, ID_Categoria, immagine, mime_type, attivo) VALUES
('Biscotti Cavalli Arcafarm Mela', 'Confezione di biscotti per cavalli Arcafarm gusto mela. Confezione da 2,5 kg', 20, 20.99, 3, 'img/cavalli/biscotti1.jpg', 'image/jpeg', 1),
('Biscotti Cavalli Arcafarm Carota', 'Confezione di biscotti per cavalli Arcafarm gusto carota. Confezione da 2,5 kg', 20, 20.99, 3, 'img/cavalli/biscotti2.jpg', 'image/jpeg', 1),
('Mangime Cavalli Morando Fioccato', 'Confezione fioccati Morando Plurifioc-35. Confezione da 30 kg', 20, 20.00, 3, 'img/cavalli/morando1.jpg', 'image/jpeg', 1),
('Mangime Cavalli Morando Mantenimento', 'Confezione mantenimento Morando Nutrovit-270. Confezione da 25 kg', 20, 20.00, 3, 'img/cavalli/morando2.jpg', 'image/jpeg', 1),
('Mangime Cavalli Purina Fuel', 'Confezione mangime per cavalli Purina. Focalizzato per cavalli da performance con energia lenta garantendo alta digeribilità .Confezione da 25 kg', 20, 23.75, 3, 'img/cavalli/purina1.jpg', 'image/jpeg', 1),
('Mangime Cavalli Purina Integri-T', 'Confezione mangime per cavalli Purina. Focalizzato per cavalli sensibili: senza cereali, zuccheri aggiunti e altamente digeribile. Confezione da 25 kg', 20, 28.75, 3, 'img/cavalli/purina2.jpg', 'image/jpeg', 1),
('Mangime Cavalli Purina XPro', 'Confezione mangime per cavalli Purina. Formulato per ottimizzare il sistema immunitario, l''efficienza digestiva e sostenere le funzioni cognitive e comportamentali. Confezione da 20 kg', 20, 49.75, 3, 'img/cavalli/purina3.jpg', 'image/jpeg', 1),
('Blocco Sale Rosa Himalayano', 'Blocco di sale rosa dell''Himalaya con corda da leccare per integrare naturalmente minerali', 20, 5.99, 3, 'img/cavalli/sale.jpg', 'image/jpeg', 1),
('Grasso Zoccoli Veredus', 'Confezione Veredus Golden Hoof di grasso per gli zoccoli da 1 kg', 20, 25.90, 3, 'img/cavalli/veredus.jpg', 'image/jpeg', 1),
('Brusca Cavalli', 'Brusca per cavalli con presa in legno, lunghezza di 25 cm', 20, 3.99, 3, 'img/cavalli/brusca.jpg', 'image/jpeg', 1),
('Fasce Zoccoli Cavalli', 'Set da 4 fasce da riposo per zoccoli in lana. Adatte a tutte le stagioni. Colore: blu notte', 20, 28.99, 3, 'img/cavalli/fasce.jpg', 'image/jpeg', 1),
('Nettapiedi Cavalli', 'Nettapiedi per zoccoli con presa in gomma, punta in metallo e spazzola incorporata per la rifinitura', 20, 15.75, 3, 'img/cavalli/nettapiedi.jpg', 'image/jpeg', 1),
('Maschera Antimosche Cavalli', 'Maschera antimosche per cavalli in tessuto traspirante, elastico, con retina in prossimità degli occhi', 20, 20.50, 3, 'img/cavalli/paramosche.jpg', 'image/jpeg', 1),
('Stecca Asciugatura Cavalli', 'Stecca in acciaio per l''asciugatura del cavallo da sudore e acqua. Flessibile e con prese in plastica', 20, 7.99, 3, 'img/cavalli/stecca.jpg', 'image/jpeg', 1),
('Striglia Cavalli', 'Striglia per la cura del pelo del cavallo, in metallo con denti arrotondati. Lunghezza: 25cm', 20,  5.99, 3, 'img/cavalli/striglia.jpg', 'image/jpeg', 1),
('Capezza e Lunghina Cavalli', 'Set capezza e lunghina per cavalli colore: blu', 20, 25.70, 3, 'img/cavalli/capezza1.jpg', 'image/jpeg', 1),
('Capezza e Lunghina Cavalli', 'Set capezza e lunghina per cavalli colore: bordeaux', 20, 25.70, 3, 'img/cavalli/capezza2.jpg', 'image/jpeg', 1),
('Capezza e Lunghina Cavalli', 'Set capezza e lunghina per cavalli colore: verde', 20, 25.70, 3, 'img/cavalli/capezza3.jpg', 'image/jpeg', 1),
('Sottosella Cavalli', 'Sottosella per cavalli con motivo a quadrifogli, in tessuto. Colore: verde con rifinitura bianca', 20, 27.99, 3, 'img/cavalli/sottosella1.jpg', 'image/jpeg', 1),
('Sottosella Cavalli', 'Sottosella per cavalli con motivo a quadrifogli, in tessuto. Colore: bordeaux con rifinitura bianca', 20, 27.99, 3, 'img/cavalli/sottosella2.jpg', 'image/jpeg', 1),
('Sottosella Cavalli', 'Sottosella per cavalli con motivo a quadrifogli, in tessuto. Colore: blu con rifinitura bianca', 20, 27.99, 3, 'img/cavalli/sottosella3.jpg', 'image/jpeg', 1),
('Palla Fieno Cavalli', 'Gioco per cavalli. Palla con fori per contenere il fieno e permettere al cavallo di intrattenersi', 20, 50.65, 3, 'img/cavalli/gioco.jpg', 'image/jpeg', 1);

INSERT INTO prodotto (Nome, Descrizione, Disponibilita, Prezzo, ID_Categoria, immagine, mime_type, attivo) VALUES
('Ciotola Conigli Food', 'Ciotola in acciaio inox lavabile in lavastoviglie, antiscivolo, con decoro esterno', 20, 10.50, 4, 'img/conigli/ciotola1.jpg', 'image/jpeg', 1),
('Ciotola Conigli Ceramica', 'Ciotola in ceramica lavabile in lavastoviglie, antiscivolo, con decoro esterno', 20, 18.50, 4, 'img/conigli/ciotola2.jpg', 'image/jpeg', 1),
('Abbeveratoio Gabbia Conigli', 'Set da 2 abbeveratoi per conigli e altri roditori, in plastica e acciaio inox lavabile in lavastoviglie.  In dotazione escono anche i supporti', 20, 19.99, 4, 'img/conigli/abbeveratoio.jpg', 'image/jpeg', 1),
('Gabbia Cilindrica Conigli', 'Gabbia cilindrica per conigli con due aperture. Max 3 conigli grandi o 5 conigli nani. La parte superiore è rimovibile per semplificare la pulizia', 20, 88.75, 4, 'img/conigli/gabbia1.jpg', 'image/jpeg', 1),
('Gabbia Casetta Conigli', 'Casetta per conigli in legno, con ruote per facilitare lo spostamento. Max 5 conigli grandi o 7 conigli nani. All''interno è presente una salita per permettere lo spostamento autonomo tra i due piani', 20, 130.99, 4, 'img/conigli/gabbia2.jpg', 'image/jpeg', 1),
('Gabbia Classica Conigli', 'Gabbia per conigli. Max 1 coniglio grande o 3 conigli nani. La parte superiore è rimovibile per semplificare la pulizia. Non esce con ciotola e segatura in dotazione', 20, 53.50, 4, 'img/conigli/gabbia3.jpg', 'image/jpeg', 1),
('Segatura Gabbia Conigli Vitakraft', 'Confezione di segatura per gabbie Vitakraft da 15 l', 20, 4.00,  4, 'img/conigli/segatura.jpg', 'image/jpeg', 1),
('Mangime Conigli Misto Ortaggi Vitakraft', 'Confezione di mangime per conigli Vitakraft misto ortaggi. Per conigli adulti', 20, 15.50,  4, 'img/conigli/vitakraft1.jpg', 'image/jpeg', 1),
('Mangime Conigli Pellet Vitakraft', 'Confezione di pellet per conigli Vitakraft per la cura dei denti. Confezione da 1kg', 20, 18.50,  4, 'img/conigli/vitakraft2.jpg', 'image/jpeg', 1),
('Mangime Conigli Misto Frutta Vitakraft', 'Confezione di mangime per conigli Vitakraft misto mela, pera e bacche', 20, 15.50,  4, 'img/conigli/vitakraft3.jpg', 'image/jpeg', 1),
('Mangime Conigli e Roditori Vitakraft', 'Confezione di mangime per conigli e altri roditori Vitakraft. Per integrare vitamine', 20, 14.50,  4, 'img/conigli/vitakraft4.jpg', 'image/jpeg', 1),
('Mangime Conigli Completo Vitakraft', 'Confezione di mangime per conigli Vitakraft menu completo misto ortaggi e frutta', 20, 18.50,  4, 'img/conigli/vitakraft5.jpg', 'image/jpeg', 1),
('Bastoncini Dneti Conigli', 'Set da 2 bastoncini da rosicchiare per la cura dei denti di conigli e altri roditori', 20, 3.99, 4, 'img/conigli/bastoncini.jpg', 'image/jpeg', 1),
('Spazzola Conigli', 'Spazzola per conigli con denti in gomma e presa in plastica ruvida', 20, 6.75, 4, 'img/conigli/spazzola1.jpg', 'image/jpeg', 1),
('Spazzola Conigli Pro', 'Spazzola per conigli con presa in plastica e sezione antiscivolo che segue la forma della mano, e denti in metallo', 20, 15.60, 4, 'img/conigli/spazzola2.jpg', 'image/jpeg', 1),
('Pettorina Traspirante Conigli', 'Pettorina in materiale traspirante per conigli grandi, con guinzaglio in dotazione. Colore: Arancione', 20, 17.80, 4, 'img/conigli/pettorina1.jpg', 'image/jpeg', 1),
('Pettorina Traspirante Conigli', 'Pettorina in materiale traspirante per conigli grandi, con guinzaglio in dotazione. Colore: Rosa', 20, 17.80, 4, 'img/conigli/pettorina2.jpg', 'image/jpeg', 1),
('Pettorina Traspirante Conigli', 'Pettorina in materiale traspirante per conigli grandi, con guinzaglio in dotazione. Colore: Celeste', 20, 17.80, 4, 'img/conigli/pettorina3.jpg', 'image/jpeg', 1),
('Pettorina Fiocco Conigli', 'Pettorina in tessuto con fiocco elegante per conigli grandi, con guinzaglio in dotazione. Motivo a scacchi rosa', 20, 18.80, 4, 'img/conigli/fiocco1.jpg', 'image/jpeg', 1),
('Pettorina Gucci Conigli', 'Pettorina in tessuto con fiocco per conigli grandi, con guinzaglio in dotazione. Motivo Gucci', 20, 21.80, 4, 'img/conigli/fiocco2.jpg', 'image/jpeg', 1),
('Cono Gioco Conigli', 'Cono con cerchi colorati in plastica da impilare per conigli', 20, 12.25,  4, 'img/conigli/gioco1.jpg', 'image/jpeg', 1),
('Tunnel Gioco Conigli', 'Tunnel colorato in tessuto per conigli. Lunghezza di 2 m', 20, 23.25,  4, 'img/conigli/gioco2.jpg', 'image/jpeg', 1),
('Palle Masticabili Gioco Conigli', 'Set da 2. Serie di palle in fieno per conigli e altri roditori, masticabili, per facilitare la cura e usura dei denti', 20, 12.25,  4, 'img/conigli/gioco3.jpg', 'image/jpeg', 1);

SET SQL_SAFE_UPDATES = 0;
UPDATE prodotto
SET immagine = CONCAT('img/gatti/', immagine)
WHERE ID_Categoria = 2 AND immagine NOT LIKE 'img/%';
SET SQL_SAFE_UPDATES = 1;

INSERT INTO prodotto (Nome, Descrizione, Disponibilita, Prezzo, ID_Categoria, immagine, mime_type, attivo) VALUES
('Dispenser Cibo e Acqua', 'Distributore in plastica di capacità 200 cc circa, utilizzabile anche come beverino oltre che come mangiatoia per pappagalli di piccola e media taglia ed altri uccelli domestici', 20, 2.90, 5, 'img/uccelli/decorazione1.png', 'image/png', 1),
('Beverino per Gabbia', 'Abbeveratoio a colonna in plastica di capacità 110 cc circa, con gancio integrato per fissarlo facilmente alle sbarre della gabbia', 20, 2.50, 5, 'img/uccelli/decorazione2.png', 'image/png', 1),
('Gabbia Blu', 'Gabbia per uccelli di dimensioni 39x25x41 cm dotata di mangiatoie girevoli, posatoi, beverino, altalena e un vassoio raccogli sporco estraibile sul fondo per facilitare la pulizia', 20, 32.90, 5, 'img/uccelli/gabbia1.png', 'image/png', 1),
('Gabbia Tonda Nera', 'Gabbia per uccelli modello Bali di dimensioni 43x43x68,5 cm dotata di mangiatoie girevoli, posatoi, altalena e un cappuccio superiore per un facile aggancio', 20, 46.00, 5, 'img/uccelli/gabbia2.png', 'image/png', 1),
('Gabbia Tonda Celeste', 'Gabbia per uccelli di dimensioni 32,5x49 cm dotata di mangiatoie girevoli, posatoi, altalena e uno specchio', 20, 42.50, 5, 'img/uccelli/gabbia3.png', 'image/png', 1),
('Gabbia Cupola Nera', 'Gabbia per uccelli a forma di cupola di dimensioni 44,5x25x45,5 cm dotata di mangiatoie girevoli, altalena e un vassoio estraibile sul fondo nero per facilitare la pulizia', 20, 49.90, 5, 'img/uccelli/gabbia4.png', 'image/png', 1),
('Scaletta Giocattolo', 'Scaletta Zolux in legno da gabbia e da voliera con gradini decorati', 20, 4.90, 5, 'img/uccelli/gioco1.png', 'image/png', 1),
('Altalena Giocattolo', 'Altalena per uccelli ad arco in legno naturale con telaio in metallo e gancio per appenderla facilmente all''interno di gabbie o voliere, progettata per il divertimento e l''esercizio fisico di piccoli uccelli', 20, 4.60, 5, 'img/uccelli/gioco2.png', 'image/png', 1),
('Altalena in Corda', 'Altalena giocattolo di dimensione 19,5x19x5x27 cm realizzata con materiali naturali e privi di colle tossiche per garantire la sicurezza del proprio animaletto', 20, 5.50, 5, 'img/uccelli/gioco3.png', 'image/png', 1),
('Sunmix Canarini Padovan', 'Confezione da 850 g di mangime completo e naturale per canarini, arricchito con vitamine essenziali per il benessere dell''animale durante tutto l''anno', 20, 4.20, 5, 'img/uccelli/padovan1.png', 'image/png', 1),
('Sunmix Esotici Padovan', 'Confezione da 850 g di mangime completo e naturale per uccelli esotici, arricchito con vitamine essenziali per il benessere dell''animale durante tutto l''anno', 20, 4.20, 5, 'img/uccelli/padovan2.png', 'image/png', 1),
('Sunmix Cocorite Padovan', 'Confezione da 850 g di mangime completo e naturale per cocorite, arricchito con vitamine essenziali per il benessere dell''animale durante tutto l''anno', 20, 4.20, 5, 'img/uccelli/padovan3.png', 'image/png', 1),
('Sunmix Parrocchetti Padovan', 'Confezione da 750 g di mangime completo e naturale per parrocchetti, arricchito con vitamine essenziali per il benessere dell''animale durante tutto l''anno', 20, 4.20, 5, 'img/uccelli/padovan4.png', 'image/png', 1),
('Sabbia Pappagalli MultiFit', 'Confezione da 5 kg di sabbia per pappagalli composta da quarzo di alta qualità e arricchita con olio di anice stellato, adatta per garantire un ambiente igienico e facile da pulire', 20, 5.50, 5, 'img/uccelli/sabbia1.png', 'image/png', 1),
('Sabbia Uccelli MultiFit', 'Confezione da 5 kg di sabbia per uccelli composta da quarzo di alta qualità e arricchita con olio di anice stellato, adatta per garantire un ambiente igienico e facile da pulire', 20, 5.50, 5, 'img/uccelli/sabbia2.png', 'image/png', 1),
('Vitakraft Amazonian', 'Mangime completo da 750g per pappagalli sudamericani con erbe e frutti tropicali come mango, papaya e banana per un pieno di sana energia', 20, 6.90, 5, 'img/uccelli/vitakraft1.png', 'image/png', 1),
('Vitakraft Canarian', 'Mangime completo da 800g per canarini con ingredienti naturali come mela, datteri e fichi per rafforzare le difese immunitarie e minerali e per supportare la digestione', 20, 6.90, 5, 'img/uccelli/vitakraft2.png', 'image/png', 1),
('Vitakraft Australian', 'Mangime completo da 750g per parrocchetti australiani con ingredienti naturali come kiwi, eucalipto e bacche di sambuco e formulato senza zuccheri aggiunti, coloranti artificiali o conservanti', 20, 6.90, 5, 'img/uccelli/vitakraft3.png', 'image/png', 1),
('Vitakraft African Big', 'Mangime completo da 750g per pappagalli africani di taglia media o grande con ingredienti naturali come mais, semi di girasole, banane e cocco', 20, 6.90, 5, 'img/uccelli/vitakraft4.png', 'image/png', 1),
('Vitakraft African Small', 'Mangime completo da 750g per pappagalli africani di piccole dimensioni e inseparabili con ingredienti naturali come fichi e carrube oltre che minerali e vitamine per sostenere la salute degli uccelli', 20, 6.90, 5, 'img/uccelli/vitakraft5.png', 'image/png', 1);

INSERT INTO prodotto (Nome, Descrizione, Disponibilita, Prezzo, ID_Categoria, immagine, mime_type, attivo) VALUES
('Boccia in Vetro', 'Piccola boccia tonda in vetro trasparente con diametro di 20 cm, ideale per piccoli pesci o altri animali acquatici', 20, 15.90, 6, 'img/pesci&tartarughe/acquariop1.png', 'image/png', 1),
('Acquario in Vetro', 'Acquario in vetro per pesci a forma di cubo, di dimensioni 25x25x30 cm e capacità di 20 litri', 20, 49.90, 6, 'img/pesci&tartarughe/acquariop2.png', 'image/png', 1),
('Acquario con Filtro', 'Acquario in vetro per pesci da 23,2 litri con base in legno naturale e filtro interno con portata di 170 L/h', 20, 59.90, 6, 'img/pesci&tartarughe/acquariop3.png', 'image/png', 1),
('Trasportino Arancione', 'Contenitore trasportabile in plastica trasparente di dimensioni 31x21x20 cm e capacità 7,5 litri, dotato di un coperchio arancione con maniglia per il trasporto con incluse alcune decorazioni interne', 20, 16.90, 6, 'img/pesci&tartarughe/acquariot1.png', 'image/png', 1),
('Tartarughiera Gialla', 'Tartarughiera in plastica colorata trasparente di dimensioni 32x21x7 cm con isoletta centrale decorata con palme, ideale per piccole tartarughe acquatiche', 20, 8.90, 6, 'img/pesci&tartarughe/acquariot2.png', 'image/png', 1),
('Tartarughiera Azzurra', 'Tartarughiera rettangolare in plastica colorata trasparente di dimensioni 54x40x14 cm e capacità 22 litri, dotata di isola con palme e una rampa per consentire alle tartarughe di riposare fuori dall’acqua', 20, 12.90, 6, 'img/pesci&tartarughe/acquariot3.png', 'image/png', 1),
('Tartarughiera con Roccia', 'Tartarughiera in vetro di dimensioni 49x25x31 cm, dotata di isola filtro interna con pompa di riciclo da 264 L/h e di un coperchio in vetro per impedire la fuga delle tartarughe', 20, 54.90, 6, 'img/pesci&tartarughe/acquariot4.png', 'image/png', 1),
('Acquafriend Stick Tartarughe', 'Mangime in stick da 75 g per tartarughe d’acqua dolce, arricchito con vitamine essenziali per favorirne la salute e la crescita', 20, 4.50, 6, 'img/pesci&tartarughe/afriend1.png', 'image/png', 1),
('Acquafriend Gamberetti Tartarughe', 'Mangime da 75 g per tartarughe d’acqua dolce composto da gamberetti essiccati, un alimento naturale e proteico che favorisce la crescita sana e non intorbidisce l’acqua dell’acquario', 20, 4.50, 6, 'img/pesci&tartarughe/afriend2.png', 'image/png', 1),
('Aqualovers Tarta Stick', 'Mangime completo in pellet da 75 g per tartarughe d’acqua dolce, formulato con una fonte naturale di calcio per supportare la salute del carapace', 20, 5.50, 6, 'img/pesci&tartarughe/alovers1.png', 'image/png', 1),
('Aqualovers Tarta Shrimps', 'Mangime naturale a base di gamberetti da 150 g per tartarughe d’acqua dolce, formulato con una fonte naturale di calcio per supportare la salute del carapace', 20, 5.90, 6, 'img/pesci&tartarughe/alovers2.png', 'image/png', 1),
('Aqualovers Tarta Gammarus', 'Mangime naturale a base di gamberetti essiccati da 120 g per tartarughe d’acqua dolce, formulato con una fonte naturale di calcio per supportare la salute del carapace', 20, 5.70, 6, 'img/pesci&tartarughe/alovers3.png', 'image/png', 1),
('Decorazione Piante', 'Set di piante artificiali alte 13 cm in vari colori, realizzate in plastica atossica e con base zavorrata per mantenerle ferme sul fondale', 20, 6.20, 6, 'img/pesci&tartarughe/decorazione1.png', 'image/png', 1),
('Decorazione Polpo', 'Ornamento decorativo per acquari realizzato a mano in resina atossica di alta qualità, con dimensioni 9,5x7x9 cm', 20, 8.90, 6, 'img/pesci&tartarughe/decorazione2.png', 'image/png', 1),
('Decorazione Arco', 'Ornamento decorativo a forma di arco romano per acquari realizzato a mano in resina atossica di alta qualità, con dimensioni 12x4,5x20 cm', 20, 7.90, 6, 'img/pesci&tartarughe/decorazione3.png', 'image/png', 1),
('Decorazione Roccia', 'Roccia naturale porosa per acquario, ideale come decorazione e rifugio per piccoli pesci', 20, 4.50, 6, 'img/pesci&tartarughe/decorazione4.png', 'image/png', 1),
('Filtro Esterno', 'Filtro esterno in plastica per acquari di piccole dimensioni, dotato di una pompa silenziosa con portata di 190 litri all’ora', 20, 22.90, 6, 'img/pesci&tartarughe/filtro1.png', 'image/png', 1),
('Pompa Filtro', 'Pompa filtro sommergibile silenziosa e compatta per acquario, con portata regolabile fino a 400 litri all’ora e motore protetto contro il surriscaldamento per garantire affidabilità nel tempo', 20, 14.90, 6, 'img/pesci&tartarughe/filtro2.png', 'image/png', 1),
('Lampada Riscaldante', 'Lampada con clip di metallo progettata per fornire calore e luce UVA/UVB ideale per tartarughe, con incluso un cavo di alimentazione con interruttore e presa europea', 20, 23.90, 6, 'img/pesci&tartarughe/lampada1.png', 'image/png', 1),
('Lampada Gigasun 80W', 'Lampada riscaldante per tartarughe con tecnologia ai vapori di mercurio per aiutare i rettili a sintetizzare la vitamina D3, essenziale per l’assorbimento del calcio', 20, 25.90, 6, 'img/pesci&tartarughe/lampada2.png', 'image/png', 1),
('Sabbia per Acquario', 'Confezione di 5 kg di sabbia fine di quarzo bianco che non altera i valori chimici dell’acqua, ideale come substrato decorativo', 20, 5.90, 6, 'img/pesci&tartarughe/sabbia1.png', 'image/png', 1),
('Ghiaia per Acquario', 'Confezione di 5 kg di ghiaia naturale atossica, ideale come substrato decorativo', 20, 5.90, 6, 'img/pesci&tartarughe/sabbia2.png', 'image/png', 1),
('Sera Vipan Flakes', 'Mangime completo in scaglie da 60g per pesci ornamentali che si nutrono in superficie, con ingredienti naturali senza coloranti né conservanti artificiali', 20, 6.20, 6, 'img/pesci&tartarughe/sera1.png', 'image/png', 1),
('Sera Vipagran Granules', 'Mangime completo in granuli morbidi da 100g per pesci ornamentali che si nutrono nella zona centrale dell’acquario, con ingredienti naturali senza coloranti né conservanti artificiali', 20, 6.60, 6, 'img/pesci&tartarughe/sera2.png', 'image/png', 1),
('Sera Vipachips Wafers', 'Mangime completo in chips ad affondamento rapido da 90g per pesci ornamentali che si nutrono sul fondo, con ingredienti naturali e senza coloranti né conservanti artificiali', 20, 6.40, 6, 'img/pesci&tartarughe/sera3.png', 'image/png', 1),
('Sera Insect Granules', 'Mangime sostenibile in granuli morbidi da 95g per pesci sia di superficie che di fondo, con ingredienti naturali senza coloranti né conservanti artificiali', 20, 6.50, 6, 'img/pesci&tartarughe/sera4.png', 'image/png', 1),
('Sera Immune Probiotic Granules', 'Mangime probiotico in granuli da 112g per pesci sia di superficie che di fondo, ricco di proteine per favorire la crescita e le difese immunitarie', 20, 6.80, 6, 'img/pesci&tartarughe/sera5.png', 'image/png', 1),
('Goldfish Colour', 'Mangime bilanciato e nutriente in granuli da 75 g per pesci rossi, con alga spirulina e carotenoidi per intensificare i colori naturali dei pesci e migliorarne la brillantezza', 20, 5.20, 6, 'img/pesci&tartarughe/tetra1.png', 'image/png', 1),
('Goldfish Energy', 'Mangime bilanciato e nutriente in granuli da 75 g per tutti i pesci rossi, con sostanze nutritive essenziali come proteine e minerali per una migliore digestione e vitalità', 20, 5.20, 6, 'img/pesci&tartarughe/tetra2.png', 'image/png', 1),
('Goldfish Japan', 'Mangime bilanciato e nutriente in stick da 75 g per pesci rossi giapponesi ed esotici, con proteine di alta qualità e ingredienti a base vegetale per favorire la crescita e il benessere', 20, 5.20, 6, 'img/pesci&tartarughe/tetra3.png', 'image/png', 1);

DELETE FROM categoria WHERE ID > 6;
ALTER TABLE categoria AUTO_INCREMENT = 7;
SELECT * FROM categoria;

DELETE p1 FROM prodotto p1
INNER JOIN prodotto p2
WHERE p1.ID > p2.ID
AND p1.Nome = p2.Nome
AND p1.immagine = p2.immagine
AND p1.ID_Categoria = p2.ID_Categoria
AND p1.ID_Categoria IN (2, 3, 4);