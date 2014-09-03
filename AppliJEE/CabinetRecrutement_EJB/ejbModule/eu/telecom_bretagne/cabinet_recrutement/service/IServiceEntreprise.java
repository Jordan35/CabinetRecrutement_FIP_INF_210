package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;

/**
 * Interface du service gérant les entreprises.
 * @author Philippe TANGUY
 */
@Remote
public interface IServiceEntreprise
{
	//-----------------------------------------------------------------------------
	/**
	 * Ajout d'une nouvelle entreprise.
	 * 
	 * @param nom
	 * @param descriptif
	 * @param adressePostale
	 * @return l'instance de l'{@link Entreprise} une fois qu'elle a été rendue
	 *         persistante dans la base.
	 */
	public Entreprise               nouvelleEntreprise(String nom, String descriptif, String adressePostale);
	/**
	 * Obtention d'une <{@link Entreprise}.
	 * 
	 * @param id id de l'entreprise à récupérer.
	 * @return
	 */
	public Entreprise               getEntreprise(int id);
	/**
	 * Mise à jour d'une <{@link Entreprise}.
	 * 
	 * @param idEntreprise
	 * @param nom
	 * @param descriptif
	 * @param adressePostale
	 * @return l'instance de l'{@link Entreprise} une fois que les modifications
	 *         ont été rendues persistantes dans la base.
	 */
	public Entreprise               miseAJour(int    idEntreprise,
			                                      String nom, 
			                                      String descriptif, 
			                                      String adressePostale);
	/**
	 * Suppression d'une entreprise.
	 * 
	 * @param idEntreprise
	 */
	public void                     effaceEntreprise(int idEntreprise);
	/**
	 * Obtention de la liste de toutes les entreprises.
	 * 
	 * @return la liste des entreprises dans une {@code List<Entreprise>}.
	 */
	public List<Entreprise>         listeDesEntreprises();
	/**
	 * Obtention de la liste des messages reçus à destination d'une entreprise
	 * donnée.
	 * 
	 * @param idEntreprise id de l'entreprise dont o veut récupérer la liste
	 *                     des messages. 
	 * @return la liste des messages reçus dans une {@code List<MessageCandidature>}.
	 */
	public List<MessageCandidature> listeDesMessagesRecus(int idEntreprise);
	/**
	 * Obtention de la liste des messages envoyés à destination des candidats
	 * pour une entreprise donnée.
	 * 
	 * @param idEntreprise id de l'entreprise dont o veut récupérer la liste
	 *                     des messages. 
	 * @return la liste des messages envoyés dans une {@code List<MessageOffreEmploi>}.
	 */
	public List<MessageOffreEmploi> listeDesMessagesEnvoyes(int idEntreprise);
	//-----------------------------------------------------------------------------
}
