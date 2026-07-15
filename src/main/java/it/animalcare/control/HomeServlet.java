package it.animalcare.control;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import it.animalcare.dao.CategoriaDao;
import it.animalcare.dao.CategoriaDaoImpl;
import it.animalcare.dao.ProdottoDao;
import it.animalcare.dao.ProdottoDaoImpl;
import it.animalcare.model.CategoriaModel;
import it.animalcare.model.ProdottoModel;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CategoriaDao categoriaDao= new CategoriaDaoImpl();
		ProdottoDao prodottoDao= new ProdottoDaoImpl();
		
		try {
		Collection<CategoriaModel> categorie= categoriaDao.doRetrieveAll(null);
		request.setAttribute("categorie", categorie);
		Collection<ProdottoModel> prodotti = prodottoDao.doRetrieveAll("");
		request.setAttribute("prodotti", prodotti);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		RequestDispatcher dispatcher= request.getRequestDispatcher("/WEB-INF/views/home.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
