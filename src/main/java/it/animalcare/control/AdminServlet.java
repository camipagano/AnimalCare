package it.animalcare.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import it.animalcare.model.UtenteModel;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("utenteLoggato") == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}

		UtenteModel utenteLoggato = (UtenteModel) session.getAttribute("utenteLoggato");

		if (!"amministratore".equalsIgnoreCase(utenteLoggato.getRuolo())) {
			response.sendRedirect(request.getContextPath() + "/HomeServlet");
			return;
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/admin.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
