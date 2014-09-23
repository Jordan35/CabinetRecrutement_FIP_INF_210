package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the message_offre_emploi database table.
 * 
 */
@Entity
@Table(name="message_offre_emploi")
@NamedQuery(name="MessageOffreEmploi.findAll", query="SELECT m FROM MessageOffreEmploi m")
public class MessageOffreEmploi implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="MESSAGE_OFFRE_EMPLOI_ID_GENERATOR", sequenceName="MESSAGE_OFFRE_EMPLOI_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="MESSAGE_OFFRE_EMPLOI_ID_GENERATOR")
	private Integer id;

	private String corps;

	@Temporal(TemporalType.DATE)
	@Column(name="date_envoi")
	private Date dateEnvoi;

	//bi-directional many-to-one association to Candidature
	@ManyToOne
	@JoinColumn(name="id_destination")
	private Candidature candidature;

	//bi-directional many-to-one association to OffreEmploi
	@ManyToOne
	@JoinColumn(name="id_source")
	private OffreEmploi offreEmploi;

	public MessageOffreEmploi() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCorps() {
		return this.corps;
	}

	public void setCorps(String corps) {
		this.corps = corps;
	}

	public Date getDateEnvoi() {
		return this.dateEnvoi;
	}

	public void setDateEnvoi(Date dateEnvoi) {
		this.dateEnvoi = dateEnvoi;
	}

	public Candidature getCandidature() {
		return this.candidature;
	}

	public void setCandidature(Candidature candidature) {
		this.candidature = candidature;
	}

	public OffreEmploi getOffreEmploi() {
		return this.offreEmploi;
	}

	public void setOffreEmploi(OffreEmploi offreEmploi) {
		this.offreEmploi = offreEmploi;
	}

  @Override
  public String toString()
  {
    return "MessageOffreEmploi [id=" + id + ", corps=" + corps + ", dateEnvoi=" + dateEnvoi + "]";
  }

}