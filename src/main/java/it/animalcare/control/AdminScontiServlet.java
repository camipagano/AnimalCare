package it.animalcare.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import it.animalcare.dao.CategoriaDao;
import it.animalcare.dao.CategoriaDaoImpl;
import it.animalcare.dao.ProdottoDao;
import it.animalcare.dao.ProdottoDaoImpl;
import it.animalcare.model.CategoriaModel;
import it.animalcare.model.ProdottoModel;

/**
 * Servlet implementation class AdminScontiServlet
 */
@WebServlet("/AdminScontiServlet")
public class AdminScontiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminScontiServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProdottoDao prodottoDao = new ProdottoDaoImpl();
        CategoriaDao categoriaDao = new CategoriaDaoImpl();
        
        try {
            Collection<ProdottoModel> prodotti = prodottoDao.doRetrieveAll("ID");
            Map<Integer, String> nomiCategorie = new HashMap<>();
            Collection<CategoriaModel> categorie = categoriaDao.doRetrieveAll(null);
            for (CategoriaModel cat : categorie) {
                nomiCategorie.put(cat.getId(), cat.getNome());
            }

            request.setAttribute("prodotti", prodotti);
            request.setAttribute("nomiCategorie", nomiCategorie);
            request.getRequestDispatcher("/WEB-INF/views/adminsconti.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/AdminServlet");
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String percStr = request.getParameter("percentualeSconto");
        double percentuale = 0.0;

        try {
            if (percStr != null && !percStr.isEmpty()) {
                percentuale = Double.parseDouble(percStr);
            }
        } catch (NumberFormatException e) {
            percentuale = 0.0;
        }
        
        getServletContext().setAttribute("scontoGenerale", percentuale);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\": true, \"sconto\": " + percentuale + "}");
	}

}
