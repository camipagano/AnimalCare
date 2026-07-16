package it.animalcare.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
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
import it.animalcare.model.DettaglioOrdineModel;
import it.animalcare.model.MetodoPagamentoModel;
import it.animalcare.model.OrdineModel;
import it.animalcare.model.ProdottoModel;
import it.animalcare.model.UtenteModel;

@WebServlet("/OrdiniServlet")
public class OrdiniServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public OrdiniServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UtenteModel utenteLoggato = (UtenteModel) session.getAttribute("utenteLoggato");

		if (utenteLoggato == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}

		OrdineDao ordineDao = new OrdineDaoImpl();
		DettaglioOrdineDao dettaglioOrdineDao = new DettaglioOrdineDaoImpl();
		MetodoPagamentoDao metodoPagamentoDao = new MetodoPagamentoDaoImpl();
		ProdottoDao prodottoDao = new ProdottoDaoImpl();

		try {
			Collection<OrdineModel> ordini = ordineDao.doRetrieveByUtente(utenteLoggato.getId());

			Map<Integer, List<DettaglioOrdineModel>> dettagliPerOrdine = new HashMap<>();
			Map<Integer, MetodoPagamentoModel> pagamentoPerOrdine = new HashMap<>();

			for (OrdineModel ordine : ordini) {
				Collection<DettaglioOrdineModel> dettagli = dettaglioOrdineDao.doRetrieveByOrdine(ordine.getCodice());
				dettagliPerOrdine.put(ordine.getCodice(), new ArrayList<>(dettagli));

				Collection<MetodoPagamentoModel> pagamenti = metodoPagamentoDao.doRetrieveByOrdine(ordine.getCodice());
				if (!pagamenti.isEmpty()) {
					pagamentoPerOrdine.put(ordine.getCodice(), pagamenti.iterator().next());
				}
			}

			Collection<ProdottoModel> tuttiProdotti = prodottoDao.doRetrieveAll(null);
			Map<Integer, ProdottoModel> prodottiPerId = new HashMap<>();
			for (ProdottoModel prodotto : tuttiProdotti) {
				prodottiPerId.put(prodotto.getId(), prodotto);
			}

			request.setAttribute("ordini", ordini);
			request.setAttribute("dettagliPerOrdine", dettagliPerOrdine);
			request.setAttribute("pagamentoPerOrdine", pagamentoPerOrdine);
			request.setAttribute("prodottiPerId", prodottiPerId);

		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errore", "Errore nel caricamento degli ordini.");
		}

		String confermatoParam = request.getParameter("confermato");
		if (confermatoParam != null) {
			request.setAttribute("confermato", confermatoParam);
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/ordini.jsp");
		dispatcher.forward(request, response);
	}
}