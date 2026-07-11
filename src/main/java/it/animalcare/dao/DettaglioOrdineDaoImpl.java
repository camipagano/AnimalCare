package it.animalcare.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import it.animalcare.model.DettaglioOrdineModel;
import it.animalcare.util.ConnectionFactory;

public class DettaglioOrdineDaoImpl implements DettaglioOrdineDao {

    private static final String TABLE_NAME = "dettaglio_ordine";

    @Override
    public synchronized void doSave(DettaglioOrdineModel dettaglioOrdine) throws SQLException {
        String query = "INSERT INTO " + TABLE_NAME + " (Codice_Ordine, ID_Prodotto, Prezzo_Unitario, Quantita) VALUES (?, ?, ?, ?)";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, dettaglioOrdine.getCodiceOrdine());
            stmt.setInt(2, dettaglioOrdine.getIdProdotto());
            stmt.setFloat(3, dettaglioOrdine.getPrezzoUnitario());
            stmt.setInt(4, dettaglioOrdine.getQuantità());

            stmt.executeUpdate();
        }
    }

    @Override
    public synchronized void doUpdate(DettaglioOrdineModel dettaglioOrdine) throws SQLException {
        String query = "UPDATE " + TABLE_NAME + " SET Prezzo_Unitario = ?, Quantita = ? WHERE Codice_Ordine = ? AND ID_Prodotto = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setFloat(1, dettaglioOrdine.getPrezzoUnitario());
            stmt.setInt(2, dettaglioOrdine.getQuantità());
            stmt.setInt(3, dettaglioOrdine.getCodiceOrdine());
            stmt.setInt(4, dettaglioOrdine.getIdProdotto());

            stmt.executeUpdate();
        }
    }

    @Override
    public synchronized boolean doDelete(int codiceOrdine, int idProdotto) throws SQLException {
        String query = "DELETE FROM " + TABLE_NAME + " WHERE Codice_Ordine = ? AND ID_Prodotto = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, codiceOrdine);
            stmt.setInt(2, idProdotto);

            int righeCancellate = stmt.executeUpdate();
            return righeCancellate > 0;
        }
    }

    @Override
    public synchronized DettaglioOrdineModel doRetrieveByKey(int codiceOrdine, int idProdotto) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE Codice_Ordine = ? AND ID_Prodotto = ?";
        DettaglioOrdineModel dettaglioOrdine = null;

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, codiceOrdine);
            stmt.setInt(2, idProdotto);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    dettaglioOrdine = mappaDettaglioOrdine(rs);
                }
            }
        }

        return dettaglioOrdine;
    }

    @Override
    public synchronized Collection<DettaglioOrdineModel> doRetrieveAll(String order) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME;

        if ("Codice_Ordine".equalsIgnoreCase(order) || "ID_Prodotto".equalsIgnoreCase(order)
                || "Quantita".equalsIgnoreCase(order) || "Prezzo_Unitario".equalsIgnoreCase(order)) {
            query += " ORDER BY " + order;
        }

        Collection<DettaglioOrdineModel> dettagli = new ArrayList<>();

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                dettagli.add(mappaDettaglioOrdine(rs));
            }
        }

        return dettagli;
    }

    @Override
    public synchronized Collection<DettaglioOrdineModel> doRetrieveByOrdine(int codiceOrdine) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE Codice_Ordine = ?";

        Collection<DettaglioOrdineModel> dettagli = new ArrayList<>();

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, codiceOrdine);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    dettagli.add(mappaDettaglioOrdine(rs));
                }
            }
        }

        return dettagli;
    }

    private DettaglioOrdineModel mappaDettaglioOrdine(ResultSet rs) throws SQLException {
        DettaglioOrdineModel dettaglioOrdine = new DettaglioOrdineModel();
        dettaglioOrdine.setCodiceOrdine(rs.getInt("Codice_Ordine"));
        dettaglioOrdine.setIdProdotto(rs.getInt("ID_Prodotto"));
        dettaglioOrdine.setPrezzoUnitario(rs.getFloat("Prezzo_Unitario"));
        dettaglioOrdine.setQuantità(rs.getInt("Quantita"));
        return dettaglioOrdine;
    }
}