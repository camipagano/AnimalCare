package it.animalcare.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import it.animalcare.dao.CategoriaDao;
import it.animalcare.dao.CategoriaDaoImpl;
import it.animalcare.dao.ProdottoDao;
import it.animalcare.dao.ProdottoDaoImpl;
import it.animalcare.model.CategoriaModel;
import it.animalcare.model.ProdottoModel;
import it.animalcare.model.UtenteModel;

@WebServlet("/AdminProdottiServlet")
public class AdminProdottiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminProdottiServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!isAdmin(request, response)) {
			return;
		}

		String azione = request.getParameter("azione");

		if ("nuovo".equals(azione)) {
			mostraForm(request, response, null);
			return;
		}

		if ("modifica".equals(azione)) {
			try {
				int id = Integer.parseInt(request.getParameter("id"));
				int idCategoria = Integer.parseInt(request.getParameter("categoria"));
				ProdottoDao prodottoDao = new ProdottoDaoImpl();
				ProdottoModel prodotto = prodottoDao.doRetrieveByKey(id, idCategoria);
				mostraForm(request, response, prodotto);
			} catch (NumberFormatException | SQLException e) {
				e.printStackTrace();
				response.sendRedirect(request.getContextPath() + "/AdminProdottiServlet");
			}
			return;
		}

		mostraLista(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!isAdmin(request, response)) {
			return;
		}

		String azione = request.getParameter("azione");

		ProdottoDao prodottoDao = new ProdottoDaoImpl();

		try {
			if ("salva".equals(azione)) {
				String idParam = request.getParameter("id");

				ProdottoModel prodotto = new ProdottoModel();
				prodotto.setNome(request.getParameter("nome"));
				prodotto.setDescrizione(request.getParameter("descrizione"));
				prodotto.setDisponibilità(Integer.parseInt(request.getParameter("disponibilita")));
				prodotto.setPrezzo(Float.parseFloat(request.getParameter("prezzo")));
				prodotto.setIdCategoria(Integer.parseInt(request.getParameter("categoria")));
				prodotto.setImmagine(request.getParameter("immagine"));
				prodotto.setMimeType(request.getParameter("mimeType"));
				prodotto.setAttivo(request.getParameter("attivo") != null);

				if (idParam != null && !idParam.isEmpty()) {
					prodotto.setId(Integer.parseInt(idParam));
					prodottoDao.doUpdate(prodotto);
				} else {
					prodottoDao.doSave(prodotto);
				}

			} else if ("elimina".equals(azione)) {
				int id = Integer.parseInt(request.getParameter("id"));
				int idCategoria = Integer.parseInt(request.getParameter("categoria"));

				ProdottoModel prodotto = prodottoDao.doRetrieveByKey(id, idCategoria);
				if (prodotto != null) {
					prodotto.setAttivo(false);
					prodottoDao.doUpdate(prodotto);
				}

			} else if ("riattiva".equals(azione)) {
				int id = Integer.parseInt(request.getParameter("id"));
				int idCategoria = Integer.parseInt(request.getParameter("categoria"));

				ProdottoModel prodotto = prodottoDao.doRetrieveByKey(id, idCategoria);
				if (prodotto != null) {
					prodotto.setAttivo(true);
					prodottoDao.doUpdate(prodotto);
				}
			}

		} catch (SQLException | NumberFormatException e) {
			e.printStackTrace();
			request.setAttribute("errore", "Errore nel salvataggio del prodotto.");
		}

		response.sendRedirect(request.getContextPath() + "/AdminProdottiServlet");
	}

	private void mostraLista(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    ProdottoDao prodottoDao = new ProdottoDaoImpl();
	    CategoriaDao categoriaDao = new CategoriaDaoImpl();

	    try {
	        Collection<ProdottoModel> prodotti = prodottoDao.doRetrieveAll("Nome");
	        request.setAttribute("prodotti", prodotti);

	        Collection<CategoriaModel> categorie = categoriaDao.doRetrieveAll(null);
	        java.util.Map<Integer, String> nomiCategorie = new java.util.HashMap<>();
	        for (CategoriaModel cat : categorie) {
	            nomiCategorie.put(cat.getId(), cat.getNome());
	        }
	        request.setAttribute("nomiCategorie", nomiCategorie);

	    } catch (SQLException e) {
	        e.printStackTrace();
	        request.setAttribute("errore", "Errore nel caricamento del catalogo.");
	    }

	    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/adminprodotti.jsp");
	    dispatcher.forward(request, response);
	}
	
	private void mostraForm(HttpServletRequest request, HttpServletResponse response, ProdottoModel prodotto) throws ServletException, IOException {
		CategoriaDao categoriaDao = new CategoriaDaoImpl();

		try {
			Collection<CategoriaModel> categorie = categoriaDao.doRetrieveAll("Nome");
			request.setAttribute("categorie", categorie);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		request.setAttribute("prodotto", prodotto);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/adminform.jsp");
		dispatcher.forward(request, response);
	}

	private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("utenteLoggato") == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return false;
		}

		UtenteModel utenteLoggato = (UtenteModel) session.getAttribute("utenteLoggato");

		if (!"amministratore".equalsIgnoreCase(utenteLoggato.getRuolo())) {
			response.sendRedirect(request.getContextPath() + "/HomeServlet");
			return false;
		}

		return true;
	}
}