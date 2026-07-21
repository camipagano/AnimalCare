package it.animalcare.control;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import it.animalcare.dao.DettaglioOrdineDao;
import it.animalcare.dao.DettaglioOrdineDaoImpl;
import it.animalcare.dao.MetodoPagamentoDao;
import it.animalcare.dao.MetodoPagamentoDaoImpl;
import it.animalcare.dao.OrdineDao;
import it.animalcare.dao.OrdineDaoImpl;
import it.animalcare.dao.ProdottoDao;
import it.animalcare.dao.ProdottoDaoImpl;
import it.animalcare.dao.UtenteDao;
import it.animalcare.dao.UtenteDaoImpl;
import it.animalcare.model.DettaglioOrdineModel;
import it.animalcare.model.MetodoPagamentoModel;
import it.animalcare.model.OrdineModel;
import it.animalcare.model.ProdottoModel;
import it.animalcare.model.UtenteModel;

@WebServlet("/AdminOrdiniServlet")
public class AdminOrdiniServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminOrdiniServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!isAdmin(request, response)) {
			return;
		}

		String azioneCambiaStato = request.getParameter("cambiaStato");
		if (azioneCambiaStato != null) {
			boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

			try {
				int codice = Integer.parseInt(request.getParameter("codice"));
				int idUtenteOrdine = Integer.parseInt(request.getParameter("idUtenteOrdine"));
				String nuovoStato = request.getParameter("nuovoStato");

				OrdineDao ordineDao = new OrdineDaoImpl();
				OrdineModel ordine = ordineDao.doRetrieveByKey(codice, idUtenteOrdine);
				if (ordine != null && nuovoStato != null) {
					ordine.setStato(nuovoStato);
					ordineDao.doUpdate(ordine);
				}

				if (isAjax) {
					response.setContentType("text/plain");
					response.getWriter().print(nuovoStato);
					return;
				}

			} catch (NumberFormatException | SQLException e) {
				e.printStackTrace();
				if (isAjax) {
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
					response.getWriter().print("errore");
					return;
				}
			}
			response.sendRedirect(request.getContextPath() + "/AdminOrdiniServlet");
			return;
		}

		String dataInizio = request.getParameter("dataInizio");
		String dataFine = request.getParameter("dataFine");
		String cliente = request.getParameter("cliente");

		OrdineDao ordineDao = new OrdineDaoImpl();
		DettaglioOrdineDao dettaglioOrdineDao = new DettaglioOrdineDaoImpl();
		MetodoPagamentoDao metodoPagamentoDao = new MetodoPagamentoDaoImpl();
		ProdottoDao prodottoDao = new ProdottoDaoImpl();
		UtenteDao utenteDao = new UtenteDaoImpl();

		try {
			Collection<OrdineModel> tuttiOrdini = ordineDao.doRetrieveAll(null);
			List<OrdineModel> ordiniFiltrati = new ArrayList<>();

			Map<Integer, UtenteModel> utentiCache = new HashMap<>();

			for (OrdineModel ordine : tuttiOrdini) {
				boolean passaFiltro = true;

				if (dataInizio != null && !dataInizio.isEmpty()) {
					Date inizio = Date.valueOf(dataInizio);
					if (ordine.getData().before(inizio)) {
						passaFiltro = false;
					}
				}
				if (dataFine != null && !dataFine.isEmpty()) {
					Date fine = Date.valueOf(dataFine);
					if (ordine.getData().after(fine)) {
						passaFiltro = false;
					}
				}

				UtenteModel utenteOrdine = utentiCache.get(ordine.getIdUtente());
				if (utenteOrdine == null) {
					utenteOrdine = utenteDao.doRetrieveByKey(ordine.getIdUtente());
					if (utenteOrdine != null) {
						utentiCache.put(ordine.getIdUtente(), utenteOrdine);
					}
				}

				if (cliente != null && !cliente.trim().isEmpty() && utenteOrdine != null) {
					String filtro = cliente.trim().toLowerCase();
					String nomeCompleto = (utenteOrdine.getNome() + " " + utenteOrdine.getCognome()).toLowerCase();
					String mail = utenteOrdine.getMail().toLowerCase();
					if (!nomeCompleto.contains(filtro) && !mail.contains(filtro)) {
						passaFiltro = false;
					}
				}

				if (passaFiltro) {
					ordiniFiltrati.add(ordine);
				}
			}

			Map<Integer, List<DettaglioOrdineModel>> dettagliPerOrdine = new HashMap<>();
			Map<Integer, MetodoPagamentoModel> pagamentoPerOrdine = new HashMap<>();
			Map<Integer, String> clientePerOrdine = new HashMap<>();

			for (OrdineModel ordine : ordiniFiltrati) {
				Collection<DettaglioOrdineModel> dettagli = dettaglioOrdineDao.doRetrieveByOrdine(ordine.getCodice());
				dettagliPerOrdine.put(ordine.getCodice(), new ArrayList<>(dettagli));

				Collection<MetodoPagamentoModel> pagamenti = metodoPagamentoDao.doRetrieveByOrdine(ordine.getCodice());
				if (!pagamenti.isEmpty()) {
					pagamentoPerOrdine.put(ordine.getCodice(), pagamenti.iterator().next());
				}

				UtenteModel utenteOrdine = utentiCache.get(ordine.getIdUtente());
				String nomeCliente = (utenteOrdine != null) ? (utenteOrdine.getNome() + " " + utenteOrdine.getCognome()) : "Cliente sconosciuto";
				clientePerOrdine.put(ordine.getCodice(), nomeCliente);
			}

			Collection<ProdottoModel> tuttiProdotti = prodottoDao.doRetrieveAll(null);
			Map<Integer, ProdottoModel> prodottiPerId = new HashMap<>();
			for (ProdottoModel prodotto : tuttiProdotti) {
				prodottiPerId.put(prodotto.getId(), prodotto);
			}

			request.setAttribute("ordini", ordiniFiltrati);
			request.setAttribute("dettagliPerOrdine", dettagliPerOrdine);
			request.setAttribute("pagamentoPerOrdine", pagamentoPerOrdine);
			request.setAttribute("clientePerOrdine", clientePerOrdine);
			request.setAttribute("prodottiPerId", prodottiPerId);
			request.setAttribute("dataInizio", dataInizio);
			request.setAttribute("dataFine", dataFine);
			request.setAttribute("cliente", cliente);

		} catch (SQLException | IllegalArgumentException e) {
			e.printStackTrace();
			request.setAttribute("errore", "Errore nel caricamento degli ordini.");
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/adminordini.jsp");
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