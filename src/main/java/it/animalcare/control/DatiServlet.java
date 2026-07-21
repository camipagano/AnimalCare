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

/**
 * Servlet implementation class DatiServlet
 */
@WebServlet("/DatiServlet")
public class DatiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DatiServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
        UtenteModel utenteLoggato = (session != null) ? (UtenteModel) session.getAttribute("utenteLoggato") : null;

        if (utenteLoggato == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
       
        request.setAttribute("utente", utenteLoggato);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/dati.jsp"); 
        dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
        UtenteModel utenteLoggato = (session != null) ? (UtenteModel) session.getAttribute("utenteLoggato") : null;

        if (utenteLoggato == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String email = request.getParameter("email");
        String indirizzo = request.getParameter("indirizzo");
        
        utenteLoggato.setNome(nome);
        utenteLoggato.setCognome(cognome);
        utenteLoggato.setMail(email);
        utenteLoggato.setIndirizzo(indirizzo);

        UtenteDao utenteDao = new UtenteDaoImpl();

        try {
            utenteDao.doUpdate(utenteLoggato); 
            session.setAttribute("utenteLoggato", utenteLoggato);
            request.setAttribute("messaggioSuccesso", "Dati personali aggiornati con successo!");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("messaggioErrore", "Si è verificato un errore durante l'aggiornamento.");
        }

        request.setAttribute("utente", utenteLoggato);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/dati.jsp");
        dispatcher.forward(request, response);
	}

}
