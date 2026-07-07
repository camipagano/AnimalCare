package it.animalcare.model;

import java.io.Serializable;

public class CategoriaModel implements Serializable {
	
	private static final long serialVersionID = 1L;
	
	private int ID;
	private String nome;
	
	public CategoriaModel() {
		
	}
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	

}
