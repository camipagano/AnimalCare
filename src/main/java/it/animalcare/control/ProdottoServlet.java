package it.animalcare.control;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Date;
import java.util.Collection;
import java.util.HashMap;
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
import it.animalcare.dao.RecensioneDao;
import it.animalcare.dao.RecensioneDaoImpl;
import it.animalcare.dao.UtenteDao;
import it.animalcare.dao.UtenteDaoImpl;
import it.animalcare.model.ProdottoModel;
import it.animalcare.model.RecensioneModel;
import it.animalcare.model.UtenteModel;

@WebServlet("/ProdottoServlet")
public class ProdottoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProdottoServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		mostraProdotto(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UtenteModel utenteLoggato = (UtenteModel) session.getAttribute("utenteLoggato");

		if (utenteLoggato == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}

		try {
			int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
			int voto = Integer.parseInt(request.getParameter("voto"));
			String commento = request.getParameter("commento");

			RecensioneModel recensione = new RecensioneModel();
			recensione.setIdProdotto(idProdotto);
			recensione.setIdUtente(utenteLoggato.getId());
			recensione.setVoto(voto);
			recensione.setCommento(commento);
			recensione.setData(new Date(System.currentTimeMillis()));

			RecensioneDao recensioneDao = new RecensioneDaoImpl();
			recensioneDao.doSave(recensione);

		} catch (SQLException | NumberFormatException e) {
			e.printStackTrace();
			request.setAttribute("errore", "Errore nel salvataggio della recensione.");
		}

		mostraProdotto(request, response);
	}

	private void mostraProdotto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idParam = request.getParameter("id");
		String categoriaParam = request.getParameter("categoria");

		if (idParam == null || categoriaParam == null) {
			response.sendRedirect(request.getContextPath() + "/HomeServlet");
			return;
		}

		try {
			int id = Integer.parseInt(idParam);
			int idCategoria = Integer.parseInt(categoriaParam);

			ProdottoDao prodottoDao = new ProdottoDaoImpl();
			ProdottoModel prodotto = prodottoDao.doRetrieveByKey(id, idCategoria);

			if (prodotto == null) {
				response.sendRedirect(request.getContextPath() + "/HomeServlet");
				return;
			}

			RecensioneDao recensioneDao = new RecensioneDaoImpl();
			Collection<RecensioneModel> recensioni = recensioneDao.doRetrieveByProdotto(id);

			// Recuperiamo il nome di chi ha scritto ogni recensione
			UtenteDao utenteDao = new UtenteDaoImpl();
			Map<Integer, String> nomiUtenti = new HashMap<>();
			for (RecensioneModel r : recensioni) {
				if (!nomiUtenti.containsKey(r.getIdUtente())) {
					UtenteModel u = utenteDao.doRetrieveByKey(r.getIdUtente());
					nomiUtenti.put(r.getIdUtente(), (u != null) ? u.getNome() : "Utente");
				}
			}

			request.setAttribute("prodotto", prodotto);
			request.setAttribute("recensioni", recensioni);
			request.setAttribute("nomiUtenti", nomiUtenti);

		} catch (NumberFormatException | SQLException e) {
			e.printStackTrace();
			request.setAttribute("errore", "Errore nel caricamento del prodotto.");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/prodotto.jsp");
		dispatcher.forward(request, response);
	}
}