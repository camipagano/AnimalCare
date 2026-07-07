package it.animalcare.dao;

import java.sql.SQLException;
import java.util.Collection;

import it.animalcare.model.UtenteModel;

public interface UtenteDao {
	
	public void doSave (UtenteModel utente) throws SQLException;
	public void doUpdate (UtenteModel utente) throws SQLException;
	public boolean doDelete (int id) throws SQLException;
	public UtenteModel doRetrieveByKey (int id) throws SQLException;
	public Collection<UtenteModel> doRetrieveAll (String order) throws SQLException;

}
