package it.animalcare.control;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import it.animalcare.dao.DettaglioOrdineDao;
import it.animalcare.dao.DettaglioOrdineDaoImpl;
import it.animalcare.dao.MetodoPagamentoDao;
import it.animalcare.dao.MetodoPagamentoDaoImpl;
import it.animalcare.dao.OrdineDao;
import it.animalcare.dao.OrdineDaoImpl;
import it.animalcare.dao.ProdottoDao;
import it.animalcare.dao.ProdottoDaoImpl;
import it.animalcare.model.CarrelloModel;
import it.animalcare.model.DettaglioOrdineModel;
import it.animalcare.model.ItemCarrelloModel;
import it.animalcare.model.MetodoPagamentoModel;
import it.animalcare.model.OrdineModel;
import it.animalcare.model.ProdottoModel;
import it.animalcare.model.UtenteModel;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CheckoutServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UtenteModel utenteLoggato = (UtenteModel) session.getAttribute("utenteLoggato");

		if (utenteLoggato == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}

		@SuppressWarnings("unchecked")
		Map<Integer, ItemCarrelloModel> carrello = (Map<Integer, ItemCarrelloModel>) session.getAttribute("carrello");

		if (carrello == null || carrello.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
			return;
		}

		ProdottoDao prodottoDao = new ProdottoDaoImpl();
		List<CarrelloModel> righeCarrello = new ArrayList<>();
		float totale = 0;

		try {
			for (ItemCarrelloModel item : carrello.values()) {
				ProdottoModel prodotto = prodottoDao.doRetrieveByKey(item.getIdProdotto(), item.getIdCategoria());
				if (prodotto != null) {
					CarrelloModel riga = new CarrelloModel(prodotto, item.getQuantita());
					righeCarrello.add(riga);
					totale += riga.getSubtotale();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errore", "Errore nel caricamento del carrello.");
		}
		
		float spedizione = (totale > 50.0f) ? 0.00f : 5.99f;
		float totaleComplessivo = totale + spedizione;
		
		request.setAttribute("righeCarrello", righeCarrello);
		request.setAttribute("totale", totale);
		request.setAttribute("spedizione", spedizione); 
		request.setAttribute("totaleComplessivo", totaleComplessivo);
		request.setAttribute("utenteLoggato", utenteLoggato);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/checkout.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UtenteModel utenteLoggato = (UtenteModel) session.getAttribute("utenteLoggato");

		if (utenteLoggato == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}

		@SuppressWarnings("unchecked")
		Map<Integer, ItemCarrelloModel> carrello = (Map<Integer, ItemCarrelloModel>) session.getAttribute("carrello");

		if (carrello == null || carrello.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
			return;
		}

		String indirizzo = request.getParameter("indirizzo");
		String metodoPagamento = request.getParameter("metodoPagamento");

		if (indirizzo == null || indirizzo.trim().isEmpty() || metodoPagamento == null || metodoPagamento.trim().isEmpty()) {
			request.setAttribute("errore", "Compila tutti i campi richiesti.");
			doGet(request, response);
			return;
		}

		ProdottoDao prodottoDao = new ProdottoDaoImpl();
		OrdineDao ordineDao = new OrdineDaoImpl();
		DettaglioOrdineDao dettaglioOrdineDao = new DettaglioOrdineDaoImpl();
		MetodoPagamentoDao metodoPagamentoDao = new MetodoPagamentoDaoImpl();

		try {
			// Ricalcoliamo il totale velocemente per sicurezza
			float totaleProdotti = 0;
			for (ItemCarrelloModel item : carrello.values()) {
				ProdottoModel prodotto = prodottoDao.doRetrieveByKey(item.getIdProdotto(), item.getIdCategoria());
				if (prodotto != null) {
					totaleProdotti += (prodotto.getPrezzo() * item.getQuantita());
				}
			}
			float spedizione = (totaleProdotti > 50.0f) ? 0.00f : 5.99f;
			float totaleOrdine = totaleProdotti + spedizione;
			
			OrdineModel ordine = new OrdineModel();
			ordine.setIndirizzo(indirizzo);
			ordine.setStato("In lavorazione");
			ordine.setData(new Date(System.currentTimeMillis()));
			ordine.setIdUtente(utenteLoggato.getId());

			ordineDao.doSave(ordine);
			int codiceOrdine = ordine.getCodice();

			for (ItemCarrelloModel item : carrello.values()) {
				ProdottoModel prodotto = prodottoDao.doRetrieveByKey(item.getIdProdotto(), item.getIdCategoria());
				if (prodotto != null) {
					DettaglioOrdineModel dettaglio = new DettaglioOrdineModel();
					dettaglio.setCodiceOrdine(codiceOrdine);
					dettaglio.setIdProdotto(item.getIdProdotto());
					dettaglio.setPrezzoUnitario(prodotto.getPrezzo());
					dettaglio.setQuantità(item.getQuantita());
					dettaglioOrdineDao.doSave(dettaglio);
					
					int quantitaAttuale = prodotto.getDisponibilità(); 
					int nuovaQuantita = quantitaAttuale - item.getQuantita();
					
					if (nuovaQuantita < 0) {
						nuovaQuantita = 0; 
					}
					prodottoDao.doUpdateQuantita(item.getIdProdotto(), item.getIdCategoria(), nuovaQuantita);
				}
			}

			MetodoPagamentoModel pagamento = new MetodoPagamentoModel();
			pagamento.setCodiceOrdine(codiceOrdine);
			pagamento.setNome(metodoPagamento);
			pagamento.setStato("Completato");
			metodoPagamentoDao.doSave(pagamento);

			carrello.clear();

			response.sendRedirect(request.getContextPath() + "/OrdiniServlet?confermato=" + codiceOrdine);
			return;

		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errore", "Errore nel salvataggio dell'ordine. Riprova.");
			doGet(request, response);
		}
	}
}
