package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Set;


/**
 * The persistent class for the niveau_qualification database table.
 * 
 */
@Entity
@Table(name="niveau_qualification")
@NamedQuery(name="NiveauQualification.findAll", query="SELECT n FROM NiveauQualification n")
public class NiveauQualification implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="NIVEAU_QUALIFICATION_ID_GENERATOR", sequenceName="NIVEAU_QUALIFICATION_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="NIVEAU_QUALIFICATION_ID_GENERATOR")
	private Integer id;

	private String intitule;

	//bi-directional many-to-one association to Candidature
	@OneToMany(mappedBy="niveauQualification", fetch=FetchType.EAGER)
	private Set<Candidature> candidatures;

	//bi-directional many-to-one association to OffreEmploi
	@OneToMany(mappedBy="niveauQualification", fetch=FetchType.EAGER)
	private Set<OffreEmploi> offresEmploi;

	public NiveauQualification() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getIntitule() {
		return this.intitule;
	}

	public void setIntitule(String intitule) {
		this.intitule = intitule;
	}

	public Set<Candidature> getCandidatures() {
		return this.candidatures;
	}

	public void setCandidatures(Set<Candidature> candidatures) {
		this.candidatures = candidatures;
	}

	public Candidature addCandidature(Candidature candidature) {
		getCandidatures().add(candidature);
		candidature.setNiveauQualification(this);

		return candidature;
	}

	public Candidature removeCandidature(Candidature candidature) {
		getCandidatures().remove(candidature);
		candidature.setNiveauQualification(null);

		return candidature;
	}

	public Set<OffreEmploi> getOffresEmploi() {
		return this.offresEmploi;
	}

	public void setOffresEmploi(Set<OffreEmploi> offreEmplois) {
		this.offresEmploi = offreEmplois;
	}

	public OffreEmploi addOffreEmploi(OffreEmploi offreEmploi) {
		getOffresEmploi().add(offreEmploi);
		offreEmploi.setNiveauQualification(this);

		return offreEmploi;
	}

	public OffreEmploi removeOffreEmploi(OffreEmploi offreEmploi) {
		getOffresEmploi().remove(offreEmploi);
		offreEmploi.setNiveauQualification(null);

		return offreEmploi;
	}

  @Override
  public String toString()
  {
    return "NiveauQualification [id=" + id + ", intitule=" + intitule + "]";
  }

}