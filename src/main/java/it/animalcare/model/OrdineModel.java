package it.animalcare.model;

import java.io.Serializable;
import java.sql.Date;

public class OrdineModel implements Serializable {
	
	private static final long serialVersionID = 1L;
	
	private int codice;
	private String indirizzo;
	private String stato;
	private Date data;
	private int idUtente;
	
	public OrdineModel() {
		
	}

	public int getCodice() {
		return codice;
	}

	public void setCodice(int codice) {
		this.codice = codice;
	}

	public String getIndirizzo() {
		return indirizzo;
	}

	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}

	public String getStato() {
		return stato;
	}

	public void setStato(String stato) {
		this.stato = stato;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public int getIdUtente() {
		return idUtente;
	}

	public void setIdUtente(int idUtente) {
		this.idUtente = idUtente;
	}
	
	

}
