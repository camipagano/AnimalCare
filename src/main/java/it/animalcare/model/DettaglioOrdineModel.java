package it.animalcare.model;

import java.io.Serializable;

public class DettaglioOrdineModel implements Serializable {
	
	private static final long seriaVersionID= 1L;
	
	private int codiceOrdine;
	private int idProdotto;
	private float prezzoUnitario;
	private int quantità;
	
	public DettaglioOrdineModel() {
		
	}

	public int getCodiceOrdine() {
		return codiceOrdine;
	}

	public void setCodiceOrdine(int codiceOrdine) {
		this.codiceOrdine = codiceOrdine;
	}

	public int getIdProdotto() {
		return idProdotto;
	}

	public void setIdProdotto(int idProdotto) {
		this.idProdotto = idProdotto;
	}

	public float getPrezzoUnitario() {
		return prezzoUnitario;
	}

	public void setPrezzoUnitario(float prezzoUnitario) {
		this.prezzoUnitario = prezzoUnitario;
	}

	public int getQuantità() {
		return quantità;
	}

	public void setQuantità(int quantità) {
		this.quantità = quantità;
	}
	
	

}
