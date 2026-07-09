package it.animalcare.dao;

import java.sql.SQLException;
import java.util.Collection;

import it.animalcare.model.DettaglioOrdineModel;

public interface DettaglioOrdineDao {
	public void doSave (DettaglioOrdineModel dettaglioOrdine) throws SQLException;
	public void doUpdate (DettaglioOrdineModel dettaglioOrdine) throws SQLException;
	public boolean doDelete (int codiceOrdine, int idProdotto) throws SQLException;
	public DettaglioOrdineModel doRetrieveByKey (int codiceOrdine, int idProdotto) throws SQLException;
	public Collection<DettaglioOrdineModel> doRetrieveAll (String order) throws SQLException;
	public Collection<DettaglioOrdineModel> doRetrieveByOrdine (int codiceOrdine) throws SQLException;
}
