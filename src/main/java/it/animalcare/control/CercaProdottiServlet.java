package it.animalcare.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import it.animalcare.dao.ProdottoDao;
import it.animalcare.dao.ProdottoDaoImpl;
import it.animalcare.model.ProdottoModel;

/**
 * Servlet implementation class CercaProdottiServlet
 */
@WebServlet("/CercaProdottiServlet")
public class CercaProdottiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CercaProdottiServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 //Recuperiamo il testo inserito dall'utente nella barra di ricerca
        String testo = request.getParameter("cercaProdotti");
        
        if (testo == null || testo.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/HomeServlet");
            return;
        }

        try {
            ProdottoDao prodottoDao = new ProdottoDaoImpl(); // Adatta alla tua struttura di istanziazione
            Collection<ProdottoModel> prodottiTrovati = prodottoDao.doRetrieveByKeyword(testo.trim());
           
            request.setAttribute("prodottiRicerca", prodottiTrovati);
            request.setAttribute("testoCercato", testo);
            request.getRequestDispatcher("WEB-INF/views/ricerca.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/HomeServlet"); 
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
