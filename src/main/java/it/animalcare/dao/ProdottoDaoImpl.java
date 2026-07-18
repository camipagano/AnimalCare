package it.animalcare.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;

import it.animalcare.model.ProdottoModel;
import it.animalcare.util.ConnectionFactory;

public class ProdottoDaoImpl implements ProdottoDao {

    private static final String TABLE_NAME = "prodotto";

    @Override
    public synchronized void doSave(ProdottoModel prodotto) throws SQLException {
        String query = "INSERT INTO " + TABLE_NAME
                + " (Nome, Descrizione, Disponibilita, Prezzo, ID_Categoria, immagine, mime_type, attivo) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, prodotto.getNome());
            stmt.setString(2, prodotto.getDescrizione());
            stmt.setInt(3, prodotto.getDisponibilità());
            stmt.setFloat(4, prodotto.getPrezzo());
            stmt.setInt(5, prodotto.getIdCategoria());
            stmt.setString(6, prodotto.getImmagine());
            stmt.setString(7, prodotto.getMimeType());
            stmt.setBoolean(8, prodotto.isAttivo());
            stmt.executeUpdate();
        }
    }

    @Override
    public synchronized void doUpdate(ProdottoModel prodotto) throws SQLException {
        String query = "UPDATE " + TABLE_NAME
                + " SET Nome = ?, Descrizione = ?, Disponibilita = ?, Prezzo = ?, ID_Categoria = ?, "
                + "immagine = ?, mime_type = ?, attivo = ? WHERE ID = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, prodotto.getNome());
            stmt.setString(2, prodotto.getDescrizione());
            stmt.setInt(3, prodotto.getDisponibilità());
            stmt.setFloat(4, prodotto.getPrezzo());
            stmt.setInt(5, prodotto.getIdCategoria());
            stmt.setString(6, prodotto.getImmagine());
            stmt.setString(7, prodotto.getMimeType());
            stmt.setBoolean(8, prodotto.isAttivo());
            stmt.setInt(9, prodotto.getId());
            stmt.executeUpdate();
        }
    }

    @Override
    public synchronized boolean doDelete(int id, int idCategoria) throws SQLException {
        String query = "DELETE FROM " + TABLE_NAME + " WHERE ID = ? AND ID_Categoria = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.setInt(2, idCategoria);
            int righeCancellate = stmt.executeUpdate();
            return righeCancellate > 0;
        }
    }
    
    public synchronized void doUpdateQuantita(int idProdotto, int idCategoria, int nuovaQuantita) throws SQLException {
        String sql = "UPDATE prodotto SET quantita = ? WHERE id = ? AND id_categoria = ?";
        try (Connection connection = ConnectionFactory.getConnection(); 
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, nuovaQuantita);
            ps.setInt(2, idProdotto);
            ps.setInt(3, idCategoria);
            ps.executeUpdate();
        }
    }

    @Override
    public synchronized ProdottoModel doRetrieveByKey(int id, int idCategoria) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE ID = ? AND ID_Categoria = ?";
        ProdottoModel prodotto = null;

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.setInt(2, idCategoria);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    prodotto = mappaProdotto(rs);
                }
            }
        }

        return prodotto;
    }

    @Override
    public synchronized Collection<ProdottoModel> doRetrieveAll(String order) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME;

        if ("Nome".equalsIgnoreCase(order) || "Prezzo".equalsIgnoreCase(order)
                || "Disponibilita".equalsIgnoreCase(order) || "ID".equalsIgnoreCase(order)) {
            query += " ORDER BY " + order;
        }

        Collection<ProdottoModel> prodotti = new ArrayList<>();

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                prodotti.add(mappaProdotto(rs));
            }
        }

        return prodotti;
    }

    @Override
    public synchronized Collection<ProdottoModel> doRetrieveByCategoria(int idCategoria) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE ID_Categoria = ?";

        Collection<ProdottoModel> prodotti = new ArrayList<>();

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, idCategoria);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    prodotti.add(mappaProdotto(rs));
                }
            }
        }

        return prodotti;
    }
    
    public synchronized Collection<ProdottoModel> doRetrieveByKeyword(String keyword) throws SQLException{
    	Collection<ProdottoModel> prodotti = new ArrayList<>();
    	String query = "SELECT * FROM prodotto WHERE LOWER(nome) LIKE ? OR LOWER(descrizione) LIKE ?";
    	try (Connection con = ConnectionFactory.getConnection();
    			PreparedStatement stmt = con.prepareStatement(query)) {
    				String searchParam = "%" + keyword.toLowerCase() + "%";
    		        stmt.setString(1, searchParam);
    		        stmt.setString(2, searchParam);
    			
    	try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
            	 prodotti.add(mappaProdotto(rs));
            }
    	}
    	}
    	return prodotti;
    }
    	

    // Metodo di utilità privato per non ripetere lo stesso mapping in ogni metodo
    private ProdottoModel mappaProdotto(ResultSet rs) throws SQLException {
        ProdottoModel prodotto = new ProdottoModel();
        prodotto.setId(rs.getInt("ID"));
        prodotto.setNome(rs.getString("Nome"));
        prodotto.setDescrizione(rs.getString("Descrizione"));
        prodotto.setDisponibilità(rs.getInt("Disponibilita"));
        prodotto.setPrezzo(rs.getFloat("Prezzo"));
        prodotto.setIdCategoria(rs.getInt("ID_Categoria"));
        prodotto.setImmagine(rs.getString("immagine"));
        prodotto.setMimeType(rs.getString("mime_type"));
        prodotto.setAttivo(rs.getBoolean("attivo"));
        return prodotto;
    }
}