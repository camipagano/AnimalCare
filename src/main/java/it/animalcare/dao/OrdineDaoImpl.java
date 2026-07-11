package it.animalcare.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import it.animalcare.model.OrdineModel;
import it.animalcare.util.ConnectionFactory;

public class OrdineDaoImpl implements OrdineDao {

    private static final String TABLE_NAME = "ordine";

    @Override
    public synchronized void doSave(OrdineModel ordine) throws SQLException {
        String query = "INSERT INTO " + TABLE_NAME + " (Indirizzo, Stato, Data, ID_Utente) VALUES (?, ?, ?, ?)";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, ordine.getIndirizzo());
            stmt.setString(2, ordine.getStato());
            stmt.setDate(3, ordine.getData());
            stmt.setInt(4, ordine.getIdUtente());

            stmt.executeUpdate();
        }
    }

    @Override
    public synchronized void doUpdate(OrdineModel ordine) throws SQLException {
        String query = "UPDATE " + TABLE_NAME + " SET Indirizzo = ?, Stato = ?, Data = ?, ID_Utente = ? WHERE Codice = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, ordine.getIndirizzo());
            stmt.setString(2, ordine.getStato());
            stmt.setDate(3, ordine.getData());
            stmt.setInt(4, ordine.getIdUtente());
            stmt.setInt(5, ordine.getCodice());

            stmt.executeUpdate();
        }
    }

    @Override
    public synchronized boolean doDelete(int codice, int idUtente) throws SQLException {
        String query = "DELETE FROM " + TABLE_NAME + " WHERE Codice = ? AND ID_Utente = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, codice);
            stmt.setInt(2, idUtente);

            int righeCancellate = stmt.executeUpdate();
            return righeCancellate > 0;
        }
    }

    @Override
    public synchronized OrdineModel doRetrieveByKey(int codice, int idUtente) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE Codice = ? AND ID_Utente = ?";
        OrdineModel ordine = null;

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, codice);
            stmt.setInt(2, idUtente);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ordine = mappaOrdine(rs);
                }
            }
        }

        return ordine;
    }

    @Override
    public synchronized Collection<OrdineModel> doRetrieveAll(String order) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME;

        if ("Codice".equalsIgnoreCase(order) || "Data".equalsIgnoreCase(order)
                || "Stato".equalsIgnoreCase(order) || "ID_Utente".equalsIgnoreCase(order)) {
            query += " ORDER BY " + order;
        }

        Collection<OrdineModel> ordini = new ArrayList<>();

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ordini.add(mappaOrdine(rs));
            }
        }

        return ordini;
    }

    @Override
    public synchronized Collection<OrdineModel> doRetrieveByUtente(int idUtente) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE ID_Utente = ?";
        Collection<OrdineModel> ordini = new ArrayList<>();

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, idUtente);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ordini.add(mappaOrdine(rs));
                }
            }
        }

        return ordini;
    }

        private OrdineModel mappaOrdine(ResultSet rs) throws SQLException {
        OrdineModel ordine = new OrdineModel();
        ordine.setCodice(rs.getInt("Codice"));
        ordine.setIndirizzo(rs.getString("Indirizzo"));
        ordine.setStato(rs.getString("Stato"));
        ordine.setData(rs.getDate("Data"));
        ordine.setIdUtente(rs.getInt("ID_Utente"));
        return ordine;
    }
}