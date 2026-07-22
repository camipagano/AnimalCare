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
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import it.animalcare.dao.DettaglioOrdineDao;
import it.animalcare.dao.DettaglioOrdineDaoImpl;
import it.animalcare.dao.MetodoPagamentoDao;
import it.animalcare.dao.MetodoPagamentoDaoImpl;
import it.animalcare.dao.OrdineDao;
import it.animalcare.dao.OrdineDaoImpl;
import it.animalcare.dao.ProdottoDao;
import it.animalcare.dao.ProdottoDaoImpl;
import it.animalcare.model.DettaglioOrdineModel;
import it.animalcare.model.MetodoPagamentoModel;
import it.animalcare.model.OrdineModel;
import it.animalcare.model.ProdottoModel;
import it.animalcare.model.UtenteModel;

/**
 * Servlet implementation class FatturaServlet
 */
@WebServlet("/FatturaServlet")
public class FatturaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FatturaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        UtenteModel utenteLoggato = (UtenteModel) session.getAttribute("utenteLoggato");

        if (utenteLoggato == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }

        String idOrdineStr = request.getParameter("id");
        if (idOrdineStr == null || idOrdineStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID Ordine mancante.");
            return;
        }

        int idOrdine = Integer.parseInt(idOrdineStr);

        OrdineDao ordineDao = new OrdineDaoImpl();
        DettaglioOrdineDao dettaglioOrdineDao = new DettaglioOrdineDaoImpl();
        MetodoPagamentoDao metodoPagamentoDao = new MetodoPagamentoDaoImpl();
        ProdottoDao prodottoDao = new ProdottoDaoImpl();

        try {
            OrdineModel ordine = ordineDao.doRetrieveByKey(idOrdine,utenteLoggato.getId());

            if (ordine == null || ordine.getIdUtente() != utenteLoggato.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Non sei autorizzato a visualizzare questo documento.");
                return;
            }

            Collection<DettaglioOrdineModel> dettagli = dettaglioOrdineDao.doRetrieveByOrdine(ordine.getCodice());
            Collection<MetodoPagamentoModel> pagamenti = metodoPagamentoDao.doRetrieveByOrdine(ordine.getCodice());
            
            MetodoPagamentoModel pagamento = null;
            if (!pagamenti.isEmpty()) {
                pagamento = pagamenti.iterator().next();
            }

            Collection<ProdottoModel> tuttiProdotti = prodottoDao.doRetrieveAllAdmin(null);
            Map<Integer, ProdottoModel> prodottiPerId = new HashMap<>();
            for (ProdottoModel prodotto : tuttiProdotti) {
                prodottiPerId.put(prodotto.getId(), prodotto);
            }

            // Calcoliamo la spedizione con la stessa regola del checkout
            float subtotaleProdotti = 0;
            for (DettaglioOrdineModel d : dettagli) {
                subtotaleProdotti += d.getPrezzoUnitario() * d.getQuantità();
            }
            float spedizione = (subtotaleProdotti > 50.0f) ? 0.00f : 5.99f;

            // Passiamo i dati alla pagina JSP della fattura
            request.setAttribute("ordine", ordine);
            request.setAttribute("dettagli", new ArrayList<>(dettagli));
            request.setAttribute("pagamento", pagamento);
            request.setAttribute("prodottiPerId", prodottiPerId);
            request.setAttribute("cliente", utenteLoggato);
            request.setAttribute("spedizione", spedizione);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/fattura.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Impossibile caricare i dati della fattura.");
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