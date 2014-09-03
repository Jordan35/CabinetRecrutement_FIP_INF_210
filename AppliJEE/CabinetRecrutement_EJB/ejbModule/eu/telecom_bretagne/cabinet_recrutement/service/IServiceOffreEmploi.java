package eu.telecom_bretagne.cabinet_recrutement.service;
import java.util.Date;
import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

/**
 * Interface du service gérant les offres d'emploi.
 * @author Philippe TANGUY
 */
@Remote
public interface IServiceOffreEmploi
{
	//-----------------------------------------------------------------------------
	/**
	 * Référencement d'une nouvelle offre d'emploi.
	 * 
	 * @param titre
	 * @param descriptifMission
	 * @param profilRecherche
	 * @param dateDepot
	 * @param idEntreprise
	 * @param idNiveauQualification
	 * @param idsSecteursActivite
	 * @return l'instance de l'{@link OffreEmploi} une fois qu'elle a été rendue
	 *         persistante dans la base.
	 */
	public OffreEmploi       nouvelleOffre(String titre, String descriptifMission,
                                         String profilRecherche, Date dateDepot,
                                         int idEntreprise,
                                         int idNiveauQualification,
                                         List<Integer> idsSecteursActivite);
	/**
	 * Obtention d'une <{@link OffreEmploi}.
	 * 
	 * @param id id de l'offre d'emploi à récupérer.
	 * @return
	 */
	public OffreEmploi       getOffreEmploi(int id);
	/**
	 * Obtention d'une offre d'emploi} dans le cadre d'un appel via un Web
	 * Service : les informations de l'offre sont encapsulées non pas dans une
	 * instance d'{@link OffreEmploi} mais dans un tableau de chaînes de
	 * caractères.
	 * Travail autour des Web Services non terminé.
	 * 
	 * @param id id de l'offre d'emploi à récupérer.
	 * @return les inforlations relatives à l'offre d'emploi dans un {@code String[]}.
	 */
	public String[]          getOffreEmploiWS(int id);
	/**
	 * Mise à jour d'une <{@link OffreEmploi}.
	 * 
	 * @param idOffre
	 * @param titre
	 * @param descriptifMission
	 * @param profilRecherche
	 * @param idNiveauQualification
	 * @param idsSecteursActivite
	 * @return l'instance de l'{@link OffreEmploi} une fois que les modifications
	 *         ont été rendues persistantes dans la base.
	 */
	public OffreEmploi       miseAJour(int           idOffre,
			                               String        titre, 
			                               String        descriptifMission,
			                               String        profilRecherche, 
			                               int           idNiveauQualification,
			                               List<Integer> idsSecteursActivite);
	/**
	 * Suppression d'une offre d'emploi.
	 * 
	 * @param idOffre id de l'offre d'emploi à supprimer.
	 */
	public void              effaceOffre(int idOffre);
	/**
	 * Obtention de la liste de toutes les offres d'emploi.
	 * 
	 * @return la liste des offres d'emploi dans une {@code List<OffreEmploi>}.
	 */
	public List<OffreEmploi> listeDesOffres();
	/**
	 * Obtention de la liste de toutes les offres d'emploi dans le cadre
	 * d'un appel via un Web Service : les informations de l'offre sont
	 * encapsulées non pas dans une liste d'{@link OffreEmploi} mais dans
	 * une liste de tableaus de chaînes de caractères.
	 * Travail autour des Web Services non terminé.
	 * 
	 * @return la liste des offres d'emploi dans une {@code List<String[]>}.
	 */
	public List<String[]>    listeDesOffresWS();
	/**
	 * Obtention de la liste de toutes les offres d'emploi d'une entreprise
	 * donnée.
	 * 
	 * @param idEntreprise id de l'entreprise dont on veut récupérer la liste
	 *                     des offres.
	 * @return la liste des offres d'emploi de l'entreprise dans une {@code List<OffreEmploi>}.
	 */
	public List<OffreEmploi> listeDesOffresPourUneEntreprise(int idEntreprise);
	/**
	 * Obtention de la liste de toutes les offres d'emploi qui correspondent
	 * (niveau de qualification égal et au moins un secteur d'activité en commun)
	 * à une candidature donnée.
	 * 
	 * @param idCandidature id de la candidature dont on veut récupérer la liste
	 *                      des offres d'emploi correspondante.
	 * @return la liste des offres d'emploi de la candidature dans une {@code List<OffreEmploi>}.
	 */
	public List<OffreEmploi> listeDesOffresPourUneCandidature(int idCandidature);
	//-----------------------------------------------------------------------------
}
