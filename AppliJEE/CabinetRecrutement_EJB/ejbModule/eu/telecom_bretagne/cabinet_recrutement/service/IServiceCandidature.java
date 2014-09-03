package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.Date;
import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;

/**
 * Interface du service gérant les candidatures.
 * @author Philippe TANGUY
 */
@Remote
public interface IServiceCandidature
{
	//-----------------------------------------------------------------------------
	/**
	 * Référencement d'une nouvelle {@link Candidature}.
	 * 
	 * @param nom
	 * @param prenom
	 * @param dateNaissance
	 * @param adressePostale
	 * @param adresseEmail
	 * @param cv chaîne de caractère représentant le CV.
	 * @param dateDepot
	 * @param idNiveauQualification id du niveau de qualification associé.
	 * @param idsSecteursActivite liste des ids des secteurs d'activité associés à la candidature.
	 * @return l'instance de la candidature une fois persistée dans la base.
	 */
	public Candidature nouvelleCandidature(String        nom,
			                                   String        prenom,
			                                   Date          dateNaissance,
			                                   String        adressePostale,
			                                   String        adresseEmail,
			                                   String        cv,
			                                   Date          dateDepot,
			                                   int           idNiveauQualification,
			                                   List<Integer> idsSecteursActivite);
	/**
	 * Obtention d'une candidature suivant son id.
	 * 
	 * @param idCandidature id de la candidature.
	 * @return l'instance de la candidature.
	 */
	public Candidature getCandidature(int idCandidature);
	public Candidature miseAJour(int           idCandidature,
			                         String        nom, 
			                         String        prenom, 
			                         Date          dateNaissance,
			                         String        adressePostale, 
			                         String        adresseEmail,
			                         String        cv,
			                         int           idNiveauQualification,
			                         List<Integer> idsSecteursActivite);
	/**
	 * Suppression d'une candidature.
	 * 
	 * @param idCandidature id de la candidature à supprimer.
	 */
	public void effaceCandidature(int idCandidature);
	/**
	 * Obtention de la liste de toutes les candidatures référencées dans le système.
	 * 
	 * @return la liste des candidatures dans une {@code List<Candidature>}.
	 */
	public List<Candidature> listeDesCandidatures();
	/**
	 * Obtention de la liste des candidatures référencées dans le système susceptibles
	 * de correspondre à une offre d'emploi donnée.
	 * 
	 * @param idOffreEmploi id de l'offre d'emploi dont on veut connaître les
	 *                      candidatures potentielles.
	 * @return la liste des candidatures dans une {@code List<Candidature>}.
	 */
	public List<Candidature> listeDesCandidaturesPourUneOffre(int idOffreEmploi);
	/**
	 * Obtention de la liste des messages reçus pour une candidature donnée.
	 * 
	 * @param idCandidature id de la candidature dont on veut connaître les messages reçus.
	 * @return la liste des message dans une {@code List<MessageOffreEmploi>}.
	 */
	public List<MessageOffreEmploi> listeDesMessagesRecus(int idCandidature);
	/**
	 * Obtention de la liste des messages envoyés pour une candidature donnée.
	 * 
	 * @param idCandidature id de la candidature dont on veut connaître les messages envoyés.
	 * @return la liste des message dans une {@code List<MessageCandidature>}.
	 */
	public List<MessageCandidature> listeDesMessagesEnvoyes(int idCandidature);
	//-----------------------------------------------------------------------------
}
