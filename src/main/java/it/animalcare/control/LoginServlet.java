package it.animalcare.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import it.animalcare.dao.UtenteDao;
import it.animalcare.dao.UtenteDaoImpl;
import it.animalcare.model.UtenteModel;
import it.animalcare.util.PasswordUtil;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/login.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mail = request.getParameter("mail");
		String password = request.getParameter("password");

		UtenteDao utenteDao = new UtenteDaoImpl();

		try {
			UtenteModel utente = utenteDao.doRetrieveByMail(mail);

			if (utente != null) {
				String digestInserito = PasswordUtil.toDigest(password);

				if (digestInserito.equals(utente.getPassword())) {
					// Login riuscito
					HttpSession session = request.getSession();
					session.setAttribute("utenteLoggato", utente);
					if ("amministratore".equalsIgnoreCase(utente.getRuolo())) {
						// Se è admin, lo rimandiamo alla Servlet dell'amministratore
						response.sendRedirect(request.getContextPath() + "/AdminServlet");
					} else {
						// Se è un utente normale, va alla Home normale
						response.sendRedirect(request.getContextPath() + "/HomeServlet");
					}
					return;
				}
			}

			// Mail non trovata o password errata: stesso messaggio per non rivelare
			// se l'email esiste o meno (buona pratica di sicurezza)
			request.setAttribute("errore", "Email o password errati.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/login.jsp");
			dispatcher.forward(request, response);

		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errore", "Errore del server. Riprova più tardi.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/login.jsp");
			dispatcher.forward(request, response);
		}
	}
}