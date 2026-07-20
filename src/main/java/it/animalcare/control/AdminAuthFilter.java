package it.animalcare.control;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import it.animalcare.model.UtenteModel;

@WebFilter(urlPatterns = { 
    "/AdminServlet", 
    "/AdminOrdiniServlet", 
    "/AdminProdottiServlet" 
})
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        UtenteModel utente = (session != null) ? (UtenteModel) session.getAttribute("utenteLoggato") : null;

        if (utente != null && "amministratore".equalsIgnoreCase(utente.getRuolo())) { 
            chain.doFilter(request, response);
        } else {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Accesso negato: Riservato agli amministratori.");
        }
    }
}