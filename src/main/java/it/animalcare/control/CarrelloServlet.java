package it.animalcare.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import it.animalcare.dao.ProdottoDao;
import it.animalcare.dao.ProdottoDaoImpl;
import it.animalcare.model.CarrelloModel;
import it.animalcare.model.ItemCarrelloModel;
import it.animalcare.model.ProdottoModel;

@WebServlet("/CarrelloServlet")
public class CarrelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CarrelloServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		gestisci(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		gestisci(request, response);
	}

	private void gestisci(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		@SuppressWarnings("unchecked")
		Map<Integer, ItemCarrelloModel> carrello = (Map<Integer, ItemCarrelloModel>) session.getAttribute("carrello");

		if (carrello == null) {
			carrello = new LinkedHashMap<>();
			session.setAttribute("carrello", carrello);
		}

		String azione = request.getParameter("azione");
		ProdottoDao prodottoDao = new ProdottoDaoImpl();

		if ("aggiungi".equals(azione)) {
			int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
			int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
			int quantita = 1;

			String quantitaParam = request.getParameter("quantita");
			if (quantitaParam != null && !quantitaParam.isEmpty()) {
				quantita = Integer.parseInt(quantitaParam);
			}

			try {
				ProdottoModel prodotto = prodottoDao.doRetrieveByKey(idProdotto, idCategoria);

				if (prodotto != null) {
					int disponibilita = prodotto.getDisponibilità();
					int quantitaAttuale = carrello.containsKey(idProdotto) ? carrello.get(idProdotto).getQuantita() : 0;
					int nuovaQuantita = quantitaAttuale + quantita;

					if (nuovaQuantita > disponibilita) {
						nuovaQuantita = disponibilita;
						session.setAttribute("messaggioCarrello", "Hai raggiunto la disponibilità massima per questo prodotto.");
					}

					if (carrello.containsKey(idProdotto)) {
						carrello.get(idProdotto).setQuantita(nuovaQuantita);
					} else {
						carrello.put(idProdotto, new ItemCarrelloModel(idProdotto, idCategoria, nuovaQuantita));
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
			return;

		} else if ("aumenta".equals(azione)) {
			int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
			ItemCarrelloModel item = carrello.get(idProdotto);

			if (item != null) {
				try {
					ProdottoModel prodotto = prodottoDao.doRetrieveByKey(item.getIdProdotto(), item.getIdCategoria());

					if (prodotto != null) {
						if (item.getQuantita() < prodotto.getDisponibilità()) {
							item.setQuantita(item.getQuantita() + 1);
						} else {
							session.setAttribute("messaggioCarrello", "Hai raggiunto la disponibilità massima per questo prodotto.");
						}
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
			return;

		} else if ("diminuisci".equals(azione)) {
			int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
			ItemCarrelloModel item = carrello.get(idProdotto);
			if (item != null) {
				if (item.getQuantita() > 1) {
					item.setQuantita(item.getQuantita() - 1);
				} else {
					carrello.remove(idProdotto);
				}
			}

			response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
			return;

		} else if ("rimuovi".equals(azione)) {
			int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
			carrello.remove(idProdotto);

			response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
			return;

		} else if ("svuota".equals(azione)) {
			carrello.clear();

			response.sendRedirect(request.getContextPath() + "/CarrelloServlet");
			return;
		}

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

		// Recuperiamo e "consumiamo" il messaggio flash, se presente
		String messaggio = (String) session.getAttribute("messaggioCarrello");
		if (messaggio != null) {
			request.setAttribute("messaggioCarrello", messaggio);
			session.removeAttribute("messaggioCarrello");
		}

		request.setAttribute("righeCarrello", righeCarrello);
		request.setAttribute("totale", totale);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/carrello.jsp");
		dispatcher.forward(request, response);
	}
}