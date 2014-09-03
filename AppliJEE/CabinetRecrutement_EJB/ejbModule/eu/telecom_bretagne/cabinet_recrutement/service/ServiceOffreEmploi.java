package eu.telecom_bretagne.cabinet_recrutement.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageCandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageOffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.NiveauQualificationDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.SecteurActiviteDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Session Bean implementation class ServiceOffreEmploi
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
//@WebService
public class ServiceOffreEmploi implements IServiceOffreEmploi
{
	//-----------------------------------------------------------------------------
	@EJB private OffreEmploiDAO         offreEmploiDAO;
	@EJB private EntrepriseDAO          entrepriseDAO;
	@EJB private SecteurActiviteDAO     secteurActiviteDAO;
	@EJB private NiveauQualificationDAO niveauQualificationDAO;
	@EJB private CandidatureDAO         candidatureDAO;
	@EJB private MessageOffreEmploiDAO  messageOffreEmploiDAO;
	@EJB private MessageCandidatureDAO  messageCandidatureDAO;

	private DateFormat formatDeDate = new SimpleDateFormat("dd/MM/yyyy");
	//-----------------------------------------------------------------------------
	/**
	 * Default constructor.
	 */
	public ServiceOffreEmploi()
	{
	}
	//-----------------------------------------------------------------------------
	@Override
	public OffreEmploi nouvelleOffre(String titre, String descriptifMission,
	                                 String profilRecherche, Date dateDepot,
	                                 int idEntreprise,
	                                 int idNiveauQualification,
	                                 List<Integer> idsSecteursActivite)
	{
		// Commentaires ajoutés pour les explications
		// données à Thomas Letemplier (26/10/2012).
		
		// Instanciation de la nouvelle offre
		OffreEmploi offreEmploi = new OffreEmploi();

		// Renseignement des infos de base...
		offreEmploi.setTitre(titre);
		offreEmploi.setDescriptifMission(descriptifMission);
		offreEmploi.setProfilRecherche(profilRecherche);
		offreEmploi.setDateDepot(dateDepot);
		offreEmploi.setEntreprise(entrepriseDAO.findById(idEntreprise));

		// Le niveau de qualif
		offreEmploi.setNiveauQualification(niveauQualificationDAO.findById(idNiveauQualification));
		
		// Intanciation du nouveau set (vide pour le moment !).
		offreEmploi.setSecteursActivite(new HashSet<SecteurActivite>()); 
		
		// Parcours de l'ensemble des SA
		for(int id : idsSecteursActivite)
		{
			// Récup
			SecteurActivite secteur = secteurActiviteDAO.findById(id);
			
			// Le secteur est ajouté à l'offre
			offreEmploi.getSecteursActivite().add(secteur);
			
			// Ajout de l'offre d'emploi au secteur
			secteur.getOffresEmploi().add(offreEmploi);
			
			// Mise à jour (le set a été modifié). --> mise à jour de la table
			// d'association dans la BD.
			secteurActiviteDAO.update(secteur);
		}
		
		// Persistance de la nouvelle offre...
		offreEmploi = offreEmploiDAO.persist(offreEmploi);
		
		return offreEmploi;
	}
	//-----------------------------------------------------------------------------
	@Override
  public OffreEmploi getOffreEmploi(int id)
  {
	  return offreEmploiDAO.findById(id);
  }
	//-----------------------------------------------------------------------------
	@Override
  public String[] getOffreEmploiWS(int id)
  {
	  OffreEmploi offre = offreEmploiDAO.findById(id);
	  
		String[] offreWS = new String[10];
		offreWS[0] = offre.getId() + "";
		offreWS[1] = offre.getTitre();
		offreWS[2] = offre.getEntreprise().getNom();
		offreWS[3] = offre.getEntreprise().getDescriptif();
		offreWS[4] = offre.getDescriptifMission();
		offreWS[5] = offre.getProfilRecherche();
		offreWS[6] = offre.getEntreprise().getAdressePostale();
		offreWS[7] = offre.getNiveauQualification().getIntitule();
		offreWS[8] = "";
		for(SecteurActivite secteur : offre.getSecteursActivite())
		{
			offreWS[8] += secteur.getIntitule() + " / ";
		}
		offreWS[9] = formatDeDate.format(offre.getDateDepot());

		return offreWS;
  }
	//-----------------------------------------------------------------------------
	@Override
  public OffreEmploi miseAJour(int           idOffre,
  		                         String        titre,
  		                         String        descriptifMission,
  		                         String        profilRecherche,
  		                         int           idNiveauQualification,
  		                         List<Integer> idsSecteursActivite)
  {
		// Récupération de l'offre d'emploi.
		OffreEmploi offreEmploi = getOffreEmploi(idOffre);
		
		// Mise à jour de l'offre avec les nouvelles valeurs
		offreEmploi.setTitre(titre);
		offreEmploi.setDescriptifMission(descriptifMission);
		offreEmploi.setProfilRecherche(profilRecherche);
		offreEmploi.setNiveauQualification(niveauQualificationDAO.findById(idNiveauQualification));
		offreEmploi.setSecteursActivite(new HashSet<SecteurActivite>());
		for(int id : idsSecteursActivite)
		{
			SecteurActivite secteur = secteurActiviteDAO.findById(id);
			secteur.getOffresEmploi().add(offreEmploi);
			offreEmploi.getSecteursActivite().add(secteur);
			secteurActiviteDAO.update(secteur);
		}
		
		// On répercute sur la base de données et on renvoie l'instance modifiée...
	  return offreEmploiDAO.update(offreEmploi);
  }
	//-----------------------------------------------------------------------------
	@Override
  public void effaceOffre(int idOffre)
  {
		OffreEmploi offre = getOffreEmploi(idOffre);
		
		// Suppression des dépendances : suppression des messages envoyés et des messages reçus.
		for(MessageCandidature message : offre.getMessagesCandidature())
		{
			messageCandidatureDAO.remove(message);
		}
		for(MessageOffreEmploi message : offre.getMessagesOffreEmploi())
		{
			messageOffreEmploiDAO.remove(message);
		}
		// Une fois les dépendances supprimées, il est possible de supprimer l'offre.
		offreEmploiDAO.remove(getOffreEmploi(idOffre));
  }
	//-----------------------------------------------------------------------------
	@Override
  public List<OffreEmploi> listeDesOffres()
  {
	  return offreEmploiDAO.findAll();
  }
	//-----------------------------------------------------------------------------
	@Override
  public List<String[]> listeDesOffresWS()
  {
  	List<OffreEmploi> offresEmploi = offreEmploiDAO.findAll();
  	List<String[]>    offresEmploiWS = new ArrayList<String[]>();
  	for(OffreEmploi offre : offresEmploi)
  	{
  		String[] offreWS = new String[5];
  		offreWS[0] = offre.getId() + "";
  		offreWS[1] = offre.getTitre();
  		offreWS[2] = offre.getEntreprise().getNom();
  		offreWS[3] = offre.getNiveauQualification().getIntitule();
  		offreWS[4] = formatDeDate.format(offre.getDateDepot());
  		
  		offresEmploiWS.add(offreWS);
  	}
	  return offresEmploiWS;
  }
	//-----------------------------------------------------------------------------
	@Override
  public List<OffreEmploi> listeDesOffresPourUneEntreprise(int idEntreprise)
  {
	  return offreEmploiDAO.findByEntreprise(idEntreprise);
  }
	//-----------------------------------------------------------------------------
	@Override
  public List<OffreEmploi> listeDesOffresPourUneCandidature(int idCandidature)
  {
		Candidature candidature = candidatureDAO.findById(idCandidature);
		// Récupération des métadonnées (niveau de qualif + secteurs d'activité)
		// associées à la candidature
		Set<SecteurActivite> secteurs = candidature.getSecteursActivite();
		NiveauQualification niveau = candidature.getNiveauQualification();
		List<OffreEmploi> listeDesOffresQuiMatchent = new ArrayList<OffreEmploi>();
		for(SecteurActivite secteur : secteurs)
		{
			List<OffreEmploi> listeDesOffresParSecteur = offreEmploiDAO.findBySecteurActiviteAndNiveauQualification(secteur.getId(), niveau.getId());
			for(OffreEmploi offre : listeDesOffresParSecteur)
			{
				if(!listeDesOffresQuiMatchent.contains(offre))
					listeDesOffresQuiMatchent.add(offre);
			}
		}

	  return listeDesOffresQuiMatchent;
  }
	//-----------------------------------------------------------------------------
}
