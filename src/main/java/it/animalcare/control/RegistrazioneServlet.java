package it.animalcare.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import it.animalcare.dao.UtenteDao;
import it.animalcare.dao.UtenteDaoImpl;
import it.animalcare.model.UtenteModel;

@WebServlet("/RegistrazioneServlet")
public class RegistrazioneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegistrazioneServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/registrazione.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		String mail = request.getParameter("mail");
		String password = request.getParameter("password");
		String indirizzo = request.getParameter("indirizzo");

		UtenteDao utenteDao = new UtenteDaoImpl();

		try {
			UtenteModel esistente = utenteDao.doRetrieveByMail(mail);

			if (esistente != null) {
				request.setAttribute("errore", "Esiste già un account con questa email.");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/registrazione.jsp");
				dispatcher.forward(request, response);
				return;
			}

			UtenteModel nuovoUtente = new UtenteModel();
			nuovoUtente.setNome(nome);
			nuovoUtente.setCognome(cognome);
			nuovoUtente.setMail(mail);
			nuovoUtente.setPassword(password);
			nuovoUtente.setRuolo("cliente");
			nuovoUtente.setIndirizzo(indirizzo);

			utenteDao.doSave(nuovoUtente);

			response.sendRedirect(request.getContextPath() + "/LoginServlet");

		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("errore", "Errore del server. Riprova più tardi.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/registrazione.jsp");
			dispatcher.forward(request, response);
		}
	}
}