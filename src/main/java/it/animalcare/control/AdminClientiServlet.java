package it.animalcare.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import it.animalcare.dao.UtenteDao;
import it.animalcare.dao.UtenteDaoImpl;
import it.animalcare.model.UtenteModel;

@WebServlet("/AdminClientiServlet")
public class AdminClientiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminClientiServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!isAdmin(request, response)) {
			return;
		}

		UtenteDao utenteDao = new UtenteDaoImpl();

		try {
			Collection<UtenteModel> tuttiUtenti = utenteDao.doRetrieveAll("Cognome");

			// Mostriamo solo i clienti, non gli altri amministratori
			List<UtenteModel> clienti = new ArrayList<>();
			for (UtenteModel utente : tuttiUtenti) {
				if (!"amministratore".equalsIgnoreCase(utente.getRuolo())) {
					clienti.add(utente);
				}
			}

			request.setAttribute("clienti", clienti);

		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errore", "Errore nel caricamento dei clienti.");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/adminclienti.jsp");
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
