package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Set;


/**
 * The persistent class for the entreprise database table.
 * 
 */
@Entity
@NamedQuery(name="Entreprise.findAll", query="SELECT e FROM Entreprise e")
public class Entreprise implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="ENTREPRISE_ID_GENERATOR", sequenceName="ENTREPRISE_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="ENTREPRISE_ID_GENERATOR")
	private Integer id;

	@Column(name="adresse_postale")
	private String adressePostale;

	private String descriptif;

	private String nom;

	//bi-directional many-to-one association to OffreEmploi
	@OneToMany(mappedBy="entreprise", fetch=FetchType.EAGER)
	private Set<OffreEmploi> offresEmploi;

	public Entreprise() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAdressePostale() {
		return this.adressePostale;
	}

	public void setAdressePostale(String adressePostale) {
		this.adressePostale = adressePostale;
	}

	public String getDescriptif() {
		return this.descriptif;
	}

	public void setDescriptif(String descriptif) {
		this.descriptif = descriptif;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public Set<OffreEmploi> getOffresEmploi() {
		return this.offresEmploi;
	}

	public void setOffresEmploi(Set<OffreEmploi> offreEmplois) {
		this.offresEmploi = offreEmplois;
	}

	public OffreEmploi addOffreEmploi(OffreEmploi offreEmploi) {
		getOffresEmploi().add(offreEmploi);
		offreEmploi.setEntreprise(this);

		return offreEmploi;
	}

	public OffreEmploi removeOffreEmploi(OffreEmploi offreEmploi) {
		getOffresEmploi().remove(offreEmploi);
		offreEmploi.setEntreprise(null);

		return offreEmploi;
	}

  @Override
  public String toString()
  {
    return "Entreprise [id=" + id + ", nom=" + nom + ", adressePostale=" + adressePostale + "]";
  }

}