package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;
import java.util.Set;


/**
 * The persistent class for the candidature database table.
 * 
 */
@Entity
@NamedQuery(name="Candidature.findAll", query="SELECT c FROM Candidature c")
public class Candidature implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="CANDIDATURE_ID_GENERATOR", sequenceName="CANDIDATURE_ID_SEQ")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="CANDIDATURE_ID_GENERATOR")
	private Integer id;

	@Column(name="adresse_email")
	private String adresseEmail;

	@Column(name="adresse_postale")
	private String adressePostale;

	private String cv;

	@Temporal(TemporalType.DATE)
	@Column(name="date_depot")
	private Date dateDepot;

	@Temporal(TemporalType.DATE)
	@Column(name="date_naissance")
	private Date dateNaissance;

	private String nom;

	private String prenom;

	//bi-directional many-to-one association to NiveauQualification
	@ManyToOne
	@JoinColumn(name="id_niveau_qualification")
	private NiveauQualification niveauQualification;

	//bi-directional many-to-one association to MessageCandidature
	@OneToMany(mappedBy="candidature", fetch=FetchType.EAGER)
	private Set<MessageCandidature> messagesCandidature;

	//bi-directional many-to-one association to MessageOffreEmploi
	@OneToMany(mappedBy="candidature", fetch=FetchType.EAGER)
	private Set<MessageOffreEmploi> messagesOffreEmploi;

	//bi-directional many-to-many association to SecteurActivite
	@ManyToMany(mappedBy="candidatures", fetch=FetchType.EAGER)
	private Set<SecteurActivite> secteursActivite;

	public Candidature() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAdresseEmail() {
		return this.adresseEmail;
	}

	public void setAdresseEmail(String adresseEmail) {
		this.adresseEmail = adresseEmail;
	}

	public String getAdressePostale() {
		return this.adressePostale;
	}

	public void setAdressePostale(String adressePostale) {
		this.adressePostale = adressePostale;
	}

	public String getCv() {
		return this.cv;
	}

	public void setCv(String cv) {
		this.cv = cv;
	}

	public Date getDateDepot() {
		return this.dateDepot;
	}

	public void setDateDepot(Date dateDepot) {
		this.dateDepot = dateDepot;
	}

	public Date getDateNaissance() {
		return this.dateNaissance;
	}

	public void setDateNaissance(Date dateNaissance) {
		this.dateNaissance = dateNaissance;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return this.prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public NiveauQualification getNiveauQualification() {
		return this.niveauQualification;
	}

	public void setNiveauQualification(NiveauQualification niveauQualification) {
		this.niveauQualification = niveauQualification;
	}

	public Set<MessageCandidature> getMessagesCandidature() {
		return this.messagesCandidature;
	}

	public void setMessagesCandidature(Set<MessageCandidature> messageCandidatures) {
		this.messagesCandidature = messageCandidatures;
	}

	public MessageCandidature addMessageCandidature(MessageCandidature messageCandidature) {
		getMessagesCandidature().add(messageCandidature);
		messageCandidature.setCandidature(this);

		return messageCandidature;
	}

	public MessageCandidature removeMessageCandidature(MessageCandidature messageCandidature) {
		getMessagesCandidature().remove(messageCandidature);
		messageCandidature.setCandidature(null);

		return messageCandidature;
	}

	public Set<MessageOffreEmploi> getMessagesOffreEmploi() {
		return this.messagesOffreEmploi;
	}

	public void setMessagesOffreEmploi(Set<MessageOffreEmploi> messageOffreEmplois) {
		this.messagesOffreEmploi = messageOffreEmplois;
	}

	public MessageOffreEmploi addMessageOffreEmploi(MessageOffreEmploi messageOffreEmploi) {
		getMessagesOffreEmploi().add(messageOffreEmploi);
		messageOffreEmploi.setCandidature(this);

		return messageOffreEmploi;
	}

	public MessageOffreEmploi removeMessageOffreEmploi(MessageOffreEmploi messageOffreEmploi) {
		getMessagesOffreEmploi().remove(messageOffreEmploi);
		messageOffreEmploi.setCandidature(null);

		return messageOffreEmploi;
	}

	public Set<SecteurActivite> getSecteursActivite() {
		return this.secteursActivite;
	}

	public void setSecteursActivite(Set<SecteurActivite> secteurActivites) {
		this.secteursActivite = secteurActivites;
	}

}