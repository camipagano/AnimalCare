package it.animalcare.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import it.animalcare.model.RecensioneModel;
import it.animalcare.util.ConnectionFactory;

public class RecensioneDaoImpl implements RecensioneDao {

    private static final String TABLE_NAME = "recensione";

    @Override
    public void doSave(RecensioneModel recensione) throws SQLException {
        String query = "INSERT INTO " + TABLE_NAME + " (Voto, Commento, Data, ID_Utente, ID_Prodotto) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, recensione.getVoto());
            stmt.setString(2, recensione.getCommento());
            stmt.setDate(3, recensione.getData());
            stmt.setInt(4, recensione.getIdUtente());
            stmt.setInt(5, recensione.getIdProdotto());

            stmt.executeUpdate();
        }
    }

    @Override
    public void doUpdate(RecensioneModel recensione) throws SQLException {
        String query = "UPDATE " + TABLE_NAME + " SET Voto = ?, Commento = ?, Data = ?, ID_Utente = ?, ID_Prodotto = ? WHERE ID = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, recensione.getVoto());
            stmt.setString(2, recensione.getCommento());
            stmt.setDate(3, recensione.getData());
            stmt.setInt(4, recensione.getIdUtente());
            stmt.setInt(5, recensione.getIdProdotto());
            stmt.setInt(6, recensione.getId());

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
    public RecensioneModel doRetrieveByKey(int id, int idUtente, int idProdotto) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE ID = ? AND ID_Utente = ? AND ID_Prodotto = ?";
        RecensioneModel recensione = null;

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.setInt(2, idUtente);
            stmt.setInt(3, idProdotto);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    recensione = mappaRecensione(rs);
                }
            }
        }

        return recensione;
    }

    @Override
    public Collection<RecensioneModel> doRetrieveAll(String order) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME;

        if ("Voto".equalsIgnoreCase(order) || "Data".equalsIgnoreCase(order)
                || "ID".equalsIgnoreCase(order) || "ID_Utente".equalsIgnoreCase(order)
                || "ID_Prodotto".equalsIgnoreCase(order)) {
            query += " ORDER BY " + order;
        }

        Collection<RecensioneModel> recensioni = new ArrayList<>();

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                recensioni.add(mappaRecensione(rs));
            }
        }

        return recensioni;
    }

    @Override
    public Collection<RecensioneModel> doRetrieveByProdotto(int idProdotto) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE ID_Prodotto = ?";

        Collection<RecensioneModel> recensioni = new ArrayList<>();

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, idProdotto);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    recensioni.add(mappaRecensione(rs));
                }
            }
        }

        return recensioni;
    }

    private RecensioneModel mappaRecensione(ResultSet rs) throws SQLException {
        RecensioneModel recensione = new RecensioneModel();
        recensione.setId(rs.getInt("ID"));
        recensione.setVoto(rs.getInt("Voto"));
        recensione.setCommento(rs.getString("Commento"));
        recensione.setData(rs.getDate("Data"));
        recensione.setIdUtente(rs.getInt("ID_Utente"));
        recensione.setIdProdotto(rs.getInt("ID_Prodotto"));
        return recensione;
    }
}