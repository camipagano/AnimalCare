package it.animalcare.model;

import java.io.Serializable;

public class CarrelloModel implements Serializable {

	private static final long serialVersionUID = 1L;

	private ProdottoModel prodotto;
	private int quantita;

	public CarrelloModel() {

	}

	public CarrelloModel(ProdottoModel prodotto, int quantita) {
		this.prodotto = prodotto;
		this.quantita = quantita;
	}

	public ProdottoModel getProdotto() {
		return prodotto;
	}

	public void setProdotto(ProdottoModel prodotto) {
		this.prodotto = prodotto;
	}

	public int getQuantita() {
		return quantita;
	}

	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}

	public float getSubtotale() {
		return prodotto.getPrezzo() * quantita;
	}

}