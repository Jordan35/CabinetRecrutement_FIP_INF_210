package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
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
 * Session Bean implementation class ServiceCandidature
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceCandidature implements IServiceCandidature
{
	//-----------------------------------------------------------------------------
	@EJB private CandidatureDAO         candidatureDAO;
	@EJB private OffreEmploiDAO         offreEmploiDAO;
	@EJB private SecteurActiviteDAO     secteurActiviteDAO;
	@EJB private NiveauQualificationDAO niveauQualificationDAO;
	@EJB private MessageOffreEmploiDAO  messageOffreEmploiDAO;
	@EJB private MessageCandidatureDAO  messageCandidatureDAO;
	//-----------------------------------------------------------------------------
	/**
	 * Default constructor.
	 */
	public ServiceCandidature()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	@Override
	public Candidature nouvelleCandidature(String nom, String prenom, Date dateNaissance,
	                                       String adressePostale, String adresseEmail,
	                                       String cv, Date dateDepot,
	                                       int idNiveauQualification,
	                                       List<Integer> idsSecteursActivite)
	{
		Candidature candidature = new Candidature();
		candidature.setNom(nom);
		candidature.setPrenom(prenom);
		candidature.setDateNaissance(dateNaissance);
		candidature.setAdressePostale(adressePostale);
		candidature.setAdresseEmail(adresseEmail);
		candidature.setCv(cv);
		candidature.setDateDepot(dateDepot);
		candidature.setNiveauQualification(niveauQualificationDAO.findById(idNiveauQualification));
		candidature.setSecteursActivite(new HashSet<SecteurActivite>());
		for(int id : idsSecteursActivite)
		{
			SecteurActivite secteur = secteurActiviteDAO.findById(id);
			secteur.getCandidatures().add(candidature);
			candidature.getSecteursActivite().add(secteur);
			secteurActiviteDAO.update(secteur);
		}
		candidatureDAO.persist(candidature);

		return candidature;
	}
	//-----------------------------------------------------------------------------
	@Override
	public Candidature getCandidature(int id)
	{
	  return candidatureDAO.findById(id);
	}
	//-----------------------------------------------------------------------------
	@Override
  public Candidature miseAJour(int idCandidature,
  		                         String nom,
  		                         String prenom,
  		                         Date dateNaissance,
  		                         String adressePostale,
  		                         String adresseEmail,
  		                         String cv,
  		                         int idNiveauQualification,
  		                         List<Integer> idsSecteursActivite)	// liste modifiée
  {
		// Récupération de la candidature.
		Candidature candidature = getCandidature(idCandidature);
		
		// ATTENTION : en cas de suppression d'un secteur d'activité, il faut
		// aussi mettre à jour ce secteur d'activité.
		Set<SecteurActivite> anciensSecteursActivite = candidature.getSecteursActivite();	// Il n'y a pas encore de MAJ faite...
		for(SecteurActivite secteur : anciensSecteursActivite)
		{
			Integer id = secteur.getId();
			if(!idsSecteursActivite.contains(id))
			{
				secteur.getCandidatures().remove(candidature);
				secteurActiviteDAO.update(secteur);	// table d'association mise à jour derrière
			}
		}
		
		// Mise à jour de la candidature avec les nouvelles valeurs
		candidature.setNom(nom);
		candidature.setPrenom(prenom);
		candidature.setDateNaissance(dateNaissance);
		candidature.setAdressePostale(adressePostale);
		candidature.setAdresseEmail(adresseEmail);
		candidature.setCv(cv);
		candidature.setNiveauQualification(niveauQualificationDAO.findById(idNiveauQualification));
		candidature.setSecteursActivite(new HashSet<SecteurActivite>());
		for(int id : idsSecteursActivite)
		{
			SecteurActivite secteur = secteurActiviteDAO.findById(id);
			secteur.getCandidatures().add(candidature);
			candidature.getSecteursActivite().add(secteur);
			secteurActiviteDAO.update(secteur);
		}

		// On répercute sur la base de données et on renvoie l'instance modifiée...
	  return candidatureDAO.update(candidature);
  }
	//-----------------------------------------------------------------------------
	@Override
  public void effaceCandidature(int idCandidature)
  {
		Candidature candidature = getCandidature(idCandidature);
		
		// Suppression des dépendances : suppression des messages envoyés et des messages reçus.
		for(MessageCandidature message : candidature.getMessagesCandidature())
		{
			messageCandidatureDAO.remove(message);
		}
		for(MessageOffreEmploi message : candidature.getMessagesOffreEmploi())
		{
			messageOffreEmploiDAO.remove(message);
		}
		// Une fois les dépendances supprimées, il est possible de supprimer la candidature.
		candidatureDAO.remove(candidature);
  }
	//-----------------------------------------------------------------------------
	@Override
	public List<Candidature> listeDesCandidatures()
	{
		return candidatureDAO.findAll();
	}
	//-----------------------------------------------------------------------------
	@Override
  public List<Candidature> listeDesCandidaturesPourUneOffre(int idOffreEmploi)
  {
		OffreEmploi offre = offreEmploiDAO.findById(idOffreEmploi);
		// Récupération des métadonnées (niveau de qualif + secteurs d'activité)
		// associées à l'offre d'emploi
		Set<SecteurActivite> secteurs = offre.getSecteursActivite();            // Plusieurs SA
		NiveauQualification niveau = offre.getNiveauQualification();           // 1 seul NQ 
		List<Candidature> listeDesCandidaturesQuiMatchent = new ArrayList<Candidature>();
		for(SecteurActivite secteur : secteurs)
		{
			List<Candidature> listeDesCandidaturesParSecteur = candidatureDAO.findBySecteurActiviteAndNiveauQualification(secteur.getId(), niveau.getId());
			for(Candidature candidature : listeDesCandidaturesParSecteur)
			{
				if(!listeDesCandidaturesQuiMatchent.contains(candidature))
					listeDesCandidaturesQuiMatchent.add(candidature);
			}
		}

	  return listeDesCandidaturesQuiMatchent;
  }
	//-----------------------------------------------------------------------------
	@Override
  public List<MessageOffreEmploi> listeDesMessagesRecus(int idCandidature)
  {
		return messageOffreEmploiDAO.findByCandidature(idCandidature);
  }
	//-----------------------------------------------------------------------------
	@Override
  public List<MessageCandidature> listeDesMessagesEnvoyes(int idCandidature)
  {
	  return messageCandidatureDAO.findByCandidature(idCandidature);
  }
	//-----------------------------------------------------------------------------
}
