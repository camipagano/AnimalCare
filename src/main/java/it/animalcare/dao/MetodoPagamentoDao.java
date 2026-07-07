package it.animalcare.dao;

import java.sql.SQLException;
import java.util.Collection;

import it.animalcare.model.MetodoPagamentoModel;

public interface MetodoPagamentoDao {
	
	public void doSave (MetodoPagamentoModel metodo) throws SQLException;
	public void doUpdate (MetodoPagamentoModel metodo) throws SQLException;
	public boolean doDelete (int codiceOrdine, String nome) throws SQLException;
	public MetodoPagamentoModel doRetrieveByKey (int codiceOrdine, String nome) throws SQLException;
	public Collection<MetodoPagamentoModel> doRetrieveAll (String order) throws SQLException;
	public Collection<MetodoPagamentoModel> doRetrieveByOrdine (int codiceOrdine) throws SQLException;
}
