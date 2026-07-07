package it.animalcare.dao;

import java.sql.SQLException;
import java.util.Collection;

import it.animalcare.model.RecensioneModel;

public interface RecensioneDao {
	
	public void doSave (RecensioneModel recensione) throws SQLException;
	public void doUpdate (RecensioneModel recensione) throws SQLException;
	public boolean doDelete (int id) throws SQLException;
	public RecensioneModel doRetrieveByKey (int id, int idUtente, int idProdotto) throws SQLException;
	public Collection<RecensioneModel> doRetrieveAll (String order) throws SQLException;
	public Collection<RecensioneModel> doRetrieveByProdotto (int idProdotto) throws SQLException;

}
