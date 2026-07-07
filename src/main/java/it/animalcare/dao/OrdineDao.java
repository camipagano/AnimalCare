package it.animalcare.dao;

import java.sql.SQLException;
import java.util.Collection;

import it.animalcare.model.OrdineModel;

public interface OrdineDao {
	
	public void doSave (OrdineModel ordine) throws SQLException;
	public void doUpdate (OrdineModel ordine) throws SQLException;
	public boolean doDelete (int codice, int idUtente) throws SQLException;
	public OrdineModel doRetrieveByKey (int codice, int idUtente) throws SQLException;
	public Collection<OrdineModel> doRetrieveAll (String order) throws SQLException;
	public Collection<OrdineModel> doRetrieveByUtente (int idUtente) throws SQLException;
}
