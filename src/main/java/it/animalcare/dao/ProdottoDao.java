package it.animalcare.dao;

import java.sql.SQLException;
import java.util.Collection;

import it.animalcare.model.ProdottoModel;

public interface ProdottoDao {
	public void doSave (ProdottoModel prodotto) throws SQLException;
	public void doUpdate (ProdottoModel prodotto) throws SQLException;
	public boolean doDelete (int id, int idCategoria) throws SQLException;
	public ProdottoModel doRetrieveByKey (int id, int idCategoria) throws SQLException;
	public Collection<ProdottoModel> doRetrieveAll (String order) throws SQLException;
	public Collection<ProdottoModel> doRetrieveByCategoria (int idCategoria) throws SQLException;
	public Collection<ProdottoModel> doRetrieveByKeyword(String keyword) throws SQLException;
}
