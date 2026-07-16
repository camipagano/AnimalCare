package it.animalcare.control;

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
 * Servlet implementation class CategoriaServlet
 */
@WebServlet("/CategoriaServlet")
public class CategoriaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CategoriaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idCategoriaStr= request.getParameter("categoria");
		
		if (idCategoriaStr == null || idCategoriaStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/HomeServlet"); 
            return;
        }
		
		try {
            int idCategoria = Integer.parseInt(idCategoriaStr);
            CategoriaDao categoriaDao = new CategoriaDaoImpl();
            CategoriaModel categoria = categoriaDao.doRetrieveByKey(idCategoria);
            
            String nomeCategoria;
            if(categoria!=null) nomeCategoria=categoria.getNome();
            else nomeCategoria="Sconosciuta";
            
            ProdottoDao prodottoDao = new ProdottoDaoImpl();
            Collection<ProdottoModel> prodottiCategoria = prodottoDao.doRetrieveByCategoria(idCategoria);
            
            request.setAttribute("prodottiRicerca", prodottiCategoria); 
            request.setAttribute("nomeCategoria", nomeCategoria);
            request.getRequestDispatcher("WEB-INF/views/ricerca.jsp").forward(request, response);           
	}catch(NumberFormatException | SQLException e) {
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
