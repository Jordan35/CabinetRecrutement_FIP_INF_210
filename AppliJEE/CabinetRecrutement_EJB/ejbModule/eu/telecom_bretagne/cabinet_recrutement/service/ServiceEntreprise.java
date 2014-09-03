package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.jws.WebService;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.EntrepriseDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageCandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageOffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
@WebService
public class ServiceEntreprise implements IServiceEntreprise
{
	//-----------------------------------------------------------------------------
	@EJB private EntrepriseDAO         entrepriseDAO;
	@EJB private OffreEmploiDAO        offreEmploiDAO;
	@EJB private MessageOffreEmploiDAO messageOffreEmploiDAO;
	@EJB private MessageCandidatureDAO messageCandidatureDAO;
	//-----------------------------------------------------------------------------
	/**
	 * Default constructor.
	 */
	public ServiceEntreprise()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	@Override
  public Entreprise nouvelleEntreprise(String nom, String descriptif, String adressePostale)
  {
		Entreprise entreprise = new Entreprise();
		entreprise.setNom(nom);
		entreprise.setDescriptif(descriptif);
		entreprise.setAdressePostale(adressePostale);
		
	  return entrepriseDAO.persist(entreprise);
  }
	//-----------------------------------------------------------------------------
	@Override
  public Entreprise getEntreprise(int id)
  {
		return entrepriseDAO.findById(id);
  }
	//-----------------------------------------------------------------------------
	@Override
  public Entreprise miseAJour(int    idEntreprise,
                              String nom,
                              String descriptif,
                              String adressePostale)
  {
		// Récupération de l'entreprise.
		Entreprise entreprise = getEntreprise(idEntreprise);
		
		// Mise à jour de l'entreprise avec les nouvelles valeurs
		entreprise.setNom(nom);
		entreprise.setDescriptif(descriptif);
		entreprise.setAdressePostale(adressePostale);
		
		// On répercute sur la base de données et on renvoie l'instance modifiée...
	  return entrepriseDAO.update(entreprise);
  }
	//-----------------------------------------------------------------------------
	@Override
  public void effaceEntreprise(int idEntreprise)
  {
		Entreprise entreprise = getEntreprise(idEntreprise);
		// Suppression des dépendances : suppression des offres d'emploi.
		// De manière transitive, les dépendances vers les messages envoyés et reçus
		// sont supprimés avant d'effacer chacune des offres.
		for(OffreEmploi offre : entreprise.getOffresEmploi())
		{
			for(MessageCandidature message : offre.getMessagesCandidature())
			{
				messageCandidatureDAO.remove(message);
			}
			for(MessageOffreEmploi message : offre.getMessagesOffreEmploi())
			{
				messageOffreEmploiDAO.remove(message);
			}
			offreEmploiDAO.remove(offre);
		}
		// Une fois les dépendances supprimées, il est possible de supprimer l'entreprise.
		entrepriseDAO.remove(entreprise);
  }
	//-----------------------------------------------------------------------------
	@Override
  public List<Entreprise> listeDesEntreprises()
  {
	  return entrepriseDAO.findAll();
  }
	//-----------------------------------------------------------------------------
	@Override
  public List<MessageCandidature> listeDesMessagesRecus(int idEntreprise)
  {
		List<MessageCandidature> messages = new ArrayList<MessageCandidature>();
		List<OffreEmploi> offres = offreEmploiDAO.findByEntreprise(idEntreprise);
		for(OffreEmploi offre : offres)
		{
			messages.addAll(messageCandidatureDAO.findByOffreEmploi(offre.getId()));
		}
		return messages;
  }
	//-----------------------------------------------------------------------------
	@Override
  public List<MessageOffreEmploi> listeDesMessagesEnvoyes(int idEntreprise)
  {
		List<MessageOffreEmploi> messages = new ArrayList<MessageOffreEmploi>();
		List<OffreEmploi> offres = offreEmploiDAO.findByEntreprise(idEntreprise);
		for(OffreEmploi offre : offres)
		{
			messages.addAll(messageOffreEmploiDAO.findByOffreEmploi(offre.getId()));
		}
		return messages;

//		List<MessageOffreEmploi> messages1 = new ArrayList<MessageOffreEmploi>();
//		List<MessageOffreEmploi> messages2 = new ArrayList<MessageOffreEmploi>();
//		List<OffreEmploi> offres = offreEmploiDAO.findByEntreprise(idEntreprise+"");
//		for(OffreEmploi offre : offres)
//		{
//			messages1.addAll(messageOffreEmploiDAO.findByOffreEmploi(offre.getId()));
//		}
//		boolean fini = false;
//		MessageOffreEmploi messagePlusPetit = null;
//		while(!fini)
//		{
//			for(MessageOffreEmploi m : messages1)
//			{
//				if(messagePlusPetit == null)
//					messagePlusPetit = m;
//				else
//				{
//					if(m.getId()<messagePlusPetit.getId())
//					{
//						messagePlusPetit = m;
//						messages1.remove(m);
//					}
//				}
//			}
//			messages2.add(messagePlusPetit);
//			messagePlusPetit = null;
//			if(messages1.size() == 0)
//				fini = true;
//		}
//		return messages2;
  }
	//-----------------------------------------------------------------------------
}
