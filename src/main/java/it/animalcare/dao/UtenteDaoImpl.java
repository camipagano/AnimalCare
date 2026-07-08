package it.animalcare.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import it.animalcare.model.UtenteModel;
import it.animalcare.util.ConnectionFactory;

public class UtenteDaoImpl implements UtenteDao {

    private static final String TABLE_NAME = "utente";

    @Override
    public void doSave(UtenteModel utente) throws SQLException {
        String query = "INSERT INTO " + TABLE_NAME + " (Nome, Cognome, Mail, Password, Ruolo, Indirizzo) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, utente.getNome());
            stmt.setString(2, utente.getCognome());
            stmt.setString(3, utente.getMail());
            stmt.setString(4, utente.getPassword());
            stmt.setString(5, utente.getRuolo());
            stmt.setString(6, utente.getIndirizzo());
            stmt.executeUpdate();
        }
    }

    @Override
    public void doUpdate(UtenteModel utente) throws SQLException {
        String query = "UPDATE " + TABLE_NAME + " SET Nome = ?, Cognome = ?, Mail = ?, Password = ?, Ruolo = ?, Indirizzo = ? WHERE ID = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, utente.getNome());
            stmt.setString(2, utente.getCognome());
            stmt.setString(3, utente.getMail());
            stmt.setString(4, utente.getPassword());
            stmt.setString(5, utente.getRuolo());
            stmt.setString(6, utente.getIndirizzo());
            stmt.setInt(7, utente.getId());
            stmt.executeUpdate();
        }
    }

    @Override
    public boolean doDelete(int id) throws SQLException {
        String query = "DELETE FROM " + TABLE_NAME + " WHERE ID = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, id);
            int righeCancellate = stmt.executeUpdate();
            return righeCancellate > 0;
        }
    }

    @Override
    public UtenteModel doRetrieveByKey(int id) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE ID = ?";
        UtenteModel utente = null;

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    utente = new UtenteModel();
                    utente.setId(rs.getInt("ID"));
                    utente.setNome(rs.getString("Nome"));
                    utente.setCognome(rs.getString("Cognome"));
                    utente.setMail(rs.getString("Mail"));
                    utente.setPassword(rs.getString("Password"));
                    utente.setRuolo(rs.getString("Ruolo"));
                    utente.setIndirizzo(rs.getString("Indirizzo"));
                }
            }
        }

        return utente;
    }

    @Override
    public Collection<UtenteModel> doRetrieveAll(String order) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME;

        // Validiamo l'ordinamento: accettiamo solo colonne note, mai input non controllato
        if ("Nome".equalsIgnoreCase(order) || "Cognome".equalsIgnoreCase(order)
                || "Mail".equalsIgnoreCase(order) || "Ruolo".equalsIgnoreCase(order)
                || "ID".equalsIgnoreCase(order)) {
            query += " ORDER BY " + order;
        }

        Collection<UtenteModel> utenti = new ArrayList<>();

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                UtenteModel utente = new UtenteModel();
                utente.setId(rs.getInt("ID"));
                utente.setNome(rs.getString("Nome"));
                utente.setCognome(rs.getString("Cognome"));
                utente.setMail(rs.getString("Mail"));
                utente.setPassword(rs.getString("Password"));
                utente.setRuolo(rs.getString("Ruolo"));
                utente.setIndirizzo(rs.getString("Indirizzo"));
                utenti.add(utente);
            }
        }

        return utenti;
    }
}