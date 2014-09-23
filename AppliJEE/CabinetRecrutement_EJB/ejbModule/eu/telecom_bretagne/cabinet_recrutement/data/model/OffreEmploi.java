package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;
import java.util.Set;


/**
 * The persistent class for the offre_emploi database table.
 * 
 */
@Entity
@Table(name="offre_emploi")
@NamedQuery(name="OffreEmploi.findAll", query="SELECT o FROM OffreEmploi o")
public class OffreEmploi implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="OFFRE_EMPLOI_ID_GENERATOR", sequenceName="OFFRE_EMPLOI_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="OFFRE_EMPLOI_ID_GENERATOR")
	private Integer id;

	@Temporal(TemporalType.DATE)
	@Column(name="date_depot")
	private Date dateDepot;

	@Column(name="descriptif_mission")
	private String descriptifMission;

	@Column(name="profil_recherche")
	private String profilRecherche;

	private String titre;

	//bi-directional many-to-one association to MessageCandidature
	@OneToMany(mappedBy="offreEmploi", fetch=FetchType.EAGER)
	private Set<MessageCandidature> messagesCandidature;

	//bi-directional many-to-one association to MessageOffreEmploi
	@OneToMany(mappedBy="offreEmploi", fetch=FetchType.EAGER)
	private Set<MessageOffreEmploi> messagesOffreEmploi;

	//bi-directional many-to-one association to Entreprise
	@ManyToOne
	@JoinColumn(name="id_entreprise")
	private Entreprise entreprise;

	//bi-directional many-to-one association to NiveauQualification
	@ManyToOne
	@JoinColumn(name="id_niveau_qualification")
	private NiveauQualification niveauQualification;

	//bi-directional many-to-many association to SecteurActivite
	@ManyToMany(mappedBy="offresEmploi", fetch=FetchType.EAGER)
	private Set<SecteurActivite> secteursActivite;

	public OffreEmploi() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getDateDepot() {
		return this.dateDepot;
	}

	public void setDateDepot(Date dateDepot) {
		this.dateDepot = dateDepot;
	}

	public String getDescriptifMission() {
		return this.descriptifMission;
	}

	public void setDescriptifMission(String descriptifMission) {
		this.descriptifMission = descriptifMission;
	}

	public String getProfilRecherche() {
		return this.profilRecherche;
	}

	public void setProfilRecherche(String profilRecherche) {
		this.profilRecherche = profilRecherche;
	}

	public String getTitre() {
		return this.titre;
	}

	public void setTitre(String titre) {
		this.titre = titre;
	}

	public Set<MessageCandidature> getMessagesCandidature() {
		return this.messagesCandidature;
	}

	public void setMessageCandidatures(Set<MessageCandidature> messageCandidatures) {
		this.messagesCandidature = messageCandidatures;
	}

	public MessageCandidature addMessageCandidature(MessageCandidature messageCandidature) {
		getMessagesCandidature().add(messageCandidature);
		messageCandidature.setOffreEmploi(this);

		return messageCandidature;
	}

	public MessageCandidature removeMessageCandidature(MessageCandidature messageCandidature) {
		getMessagesCandidature().remove(messageCandidature);
		messageCandidature.setOffreEmploi(null);

		return messageCandidature;
	}

	public Set<MessageOffreEmploi> getMessagesOffreEmploi() {
		return this.messagesOffreEmploi;
	}

	public void setMessageOffreEmplois(Set<MessageOffreEmploi> messageOffreEmplois) {
		this.messagesOffreEmploi = messageOffreEmplois;
	}

	public MessageOffreEmploi addMessageOffreEmploi(MessageOffreEmploi messageOffreEmploi) {
		getMessagesOffreEmploi().add(messageOffreEmploi);
		messageOffreEmploi.setOffreEmploi(this);

		return messageOffreEmploi;
	}

	public MessageOffreEmploi removeMessageOffreEmploi(MessageOffreEmploi messageOffreEmploi) {
		getMessagesOffreEmploi().remove(messageOffreEmploi);
		messageOffreEmploi.setOffreEmploi(null);

		return messageOffreEmploi;
	}

	public Entreprise getEntreprise() {
		return this.entreprise;
	}

	public void setEntreprise(Entreprise entreprise) {
		this.entreprise = entreprise;
	}

	public NiveauQualification getNiveauQualification() {
		return this.niveauQualification;
	}

	public void setNiveauQualification(NiveauQualification niveauQualification) {
		this.niveauQualification = niveauQualification;
	}

	public Set<SecteurActivite> getSecteursActivite() {
		return this.secteursActivite;
	}

	public void setSecteursActivite(Set<SecteurActivite> secteurActivites) {
		this.secteursActivite = secteurActivites;
	}

  @Override
  public String toString()
  {
    return "OffreEmploi [id=" + id + ", titre=" + titre + ", dateDepot=" + dateDepot + "]";
  }

}