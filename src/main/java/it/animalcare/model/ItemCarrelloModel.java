package it.animalcare.model;

import java.io.Serializable;

public class ItemCarrelloModel implements Serializable {

	private static final long serialVersionUID = 1L;

	private int idProdotto;
	private int idCategoria;
	private int quantita;

	public ItemCarrelloModel() {

	}

	public ItemCarrelloModel(int idProdotto, int idCategoria, int quantita) {
		this.idProdotto = idProdotto;
		this.idCategoria = idCategoria;
		this.quantita = quantita;
	}

	public int getIdProdotto() {
		return idProdotto;
	}

	public void setIdProdotto(int idProdotto) {
		this.idProdotto = idProdotto;
	}

	public int getIdCategoria() {
		return idCategoria;
	}

	public void setIdCategoria(int idCategoria) {
		this.idCategoria = idCategoria;
	}

	public int getQuantita() {
		return quantita;
	}

	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}

}