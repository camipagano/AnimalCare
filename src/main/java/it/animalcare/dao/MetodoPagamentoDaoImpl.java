package it.animalcare.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import it.animalcare.model.MetodoPagamentoModel;
import it.animalcare.util.ConnectionFactory;

public class MetodoPagamentoDaoImpl implements MetodoPagamentoDao {

    private static final String TABLE_NAME = "metodo_di_pagamento";

    @Override
    public void doSave(MetodoPagamentoModel metodo) throws SQLException {
        String query = "INSERT INTO " + TABLE_NAME + " (Codice_Ordine, Nome, Stato) VALUES (?, ?, ?)";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, metodo.getCodiceOrdine());
            stmt.setString(2, metodo.getNome());
            stmt.setString(3, metodo.getStato());
            stmt.executeUpdate();
        }
    }

    @Override
    public void doUpdate(MetodoPagamentoModel metodo) throws SQLException {
        // Aggiorniamo solo lo Stato, dato che Codice_Ordine + Nome sono la chiave e non dovrebbero cambiare
        String query = "UPDATE " + TABLE_NAME + " SET Stato = ? WHERE Codice_Ordine = ? AND Nome = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, metodo.getStato());
            stmt.setInt(2, metodo.getCodiceOrdine());
            stmt.setString(3, metodo.getNome());
            stmt.executeUpdate();
        }
    }

    @Override
    public boolean doDelete(int codiceOrdine, String nome) throws SQLException {
        String query = "DELETE FROM " + TABLE_NAME + " WHERE Codice_Ordine = ? AND Nome = ?";

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, codiceOrdine);
            stmt.setString(2, nome);
            int righeCancellate = stmt.executeUpdate();
            return righeCancellate > 0;
        }
    }

    @Override
    public MetodoPagamentoModel doRetrieveByKey(int codiceOrdine, String nome) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE Codice_Ordine = ? AND Nome = ?";
        MetodoPagamentoModel metodo = null;

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, codiceOrdine);
            stmt.setString(2, nome);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    metodo = new MetodoPagamentoModel();
                    metodo.setCodiceOrdine(rs.getInt("Codice_Ordine"));
                    metodo.setNome(rs.getString("Nome"));
                    metodo.setStato(rs.getString("Stato"));
                }
            }
        }

        return metodo;
    }

    @Override
    public Collection<MetodoPagamentoModel> doRetrieveAll(String order) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME;

        // Validiamo l'ordinamento: accettiamo solo colonne note, mai input non controllato
        if ("Nome".equalsIgnoreCase(order) || "Stato".equalsIgnoreCase(order) || "Codice_Ordine".equalsIgnoreCase(order)) {
            query += " ORDER BY " + order;
        }

        Collection<MetodoPagamentoModel> metodi = new ArrayList<>();

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                MetodoPagamentoModel metodo = new MetodoPagamentoModel();
                metodo.setCodiceOrdine(rs.getInt("Codice_Ordine"));
                metodo.setNome(rs.getString("Nome"));
                metodo.setStato(rs.getString("Stato"));
                metodi.add(metodo);
            }
        }

        return metodi;
    }

    @Override
    public Collection<MetodoPagamentoModel> doRetrieveByOrdine(int codiceOrdine) throws SQLException {
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE Codice_Ordine = ?";

        Collection<MetodoPagamentoModel> metodi = new ArrayList<>();

        try (Connection connection = ConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, codiceOrdine);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    MetodoPagamentoModel metodo = new MetodoPagamentoModel();
                    metodo.setCodiceOrdine(rs.getInt("Codice_Ordine"));
                    metodo.setNome(rs.getString("Nome"));
                    metodo.setStato(rs.getString("Stato"));
                    metodi.add(metodo);
                }
            }
        }

        return metodi;
    }
}
