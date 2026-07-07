package it.animalcare.dao;

import java.sql.SQLException;
import java.util.Collection;

import it.animalcare.model.CategoriaModel;

public interface CategoriaDao {
	
	public void doSave (CategoriaModel categoria) throws SQLException;
	public void doUpdate (CategoriaModel categoria) throws SQLException;
	public boolean doDelete (int id) throws SQLException;
	public CategoriaModel doRetrieveByKey (int id) throws SQLException;
	public Collection<CategoriaModel> doRetrieveAll (String order) throws SQLException;

}
