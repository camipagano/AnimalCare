package it.animalcare.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import it.animalcare.model.CategoriaModel;
import it.animalcare.util.ConnectionFactory;

public class CategoriaDaoImpl implements CategoriaDao {

    private static final String TABLE_NAME = "categoria";

    @Override
    public synchronized void doSave(CategoriaModel categoria) throws SQLException {
        String query = "INSERT INTO " + TABLE_NAME + " (nome) VALUES (?)";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, categoria.getNome());
            stmt.executeUpdate();
        }
    }

    @Override
    public synchronized void doUpdate(CategoriaModel categoria) throws SQLException {
        String query = "UPDATE " + TABLE_NAME + " SET nome = ? WHERE id = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, categoria.getNome());
            stmt.setInt(2, categoria.getId());
            stmt.executeUpdate();
        }
    }

    @Override
    public synchronized boolean doDelete(int id) throws SQLException {
        String query = "DELETE FROM " + TABLE_NAME + " WHERE id = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, id);
            int righeCancellate = stmt.executeUpdate();
            return righeCancellate > 0;
        }
    }

    @Override
    public synchronized CategoriaModel doRetrieveByKey(int id) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE id = ?";
        CategoriaModel categoria = null;

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    categoria = new CategoriaModel();
                    categoria.setId(rs.getInt("id"));
                    categoria.setNome(rs.getString("nome"));
                }
            }
        }

        return categoria;
    }

    @Override
    public synchronized Collection<CategoriaModel> doRetrieveAll(String order) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME;

        // Validiamo l'ordinamento: accettiamo solo valori noti e sicuri,
        // così non concateniamo mai input non controllato nella query
        if ("nome".equalsIgnoreCase(order) || "id".equalsIgnoreCase(order)) {
            query += " ORDER BY " + order;
        }

        Collection<CategoriaModel> categorie = new ArrayList<>();

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                CategoriaModel categoria = new CategoriaModel();
                categoria.setId(rs.getInt("id"));
                categoria.setNome(rs.getString("nome"));
                categorie.add(categoria);
            }
        }

        return categorie;
    }
}