package it.animalcare.model;

import java.io.Serializable;

public class MetodoPagamentoModel implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int codiceOrdine;
	private String stato;
	private String nome;
	
	public MetodoPagamentoModel() {
		
	}

	public int getCodiceOrdine() {
		return codiceOrdine;
	}

	public void setCodiceOrdine(int codiceOrdine) {
		this.codiceOrdine = codiceOrdine;
	}

	public String getStato() {
		return stato;
	}

	public void setStato(String stato) {
		this.stato = stato;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	
	

}
