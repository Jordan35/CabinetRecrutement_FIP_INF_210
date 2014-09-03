package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.Date;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageOffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;

/**
 * Session Bean implementation class ServiceMessageOffreEmploi
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceMessageOffreEmploi implements IServiceMessageOffreEmploi
{
	//-----------------------------------------------------------------------------
	@EJB private OffreEmploiDAO        offreEmploiDAO;
	@EJB private CandidatureDAO        candidatureDAO;
	@EJB private MessageOffreEmploiDAO messageOffreEmploiDAO;
	//-----------------------------------------------------------------------------
	/**
	 * Default constructor.
	 */
	public ServiceMessageOffreEmploi()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	@Override
  public MessageOffreEmploi nouveauMessageOffreEmploi(int idOffre, int idCandidature, Date dateEnvoi, String corpsMessage)
  {
		MessageOffreEmploi message = new MessageOffreEmploi();
		message.setOffreEmploi(offreEmploiDAO.findById(idOffre));
		message.setCandidature(candidatureDAO.findById(idCandidature));
		message.setDateEnvoi(dateEnvoi);
		message.setCorps(corpsMessage);
		
		return messageOffreEmploiDAO.persist(message);
  }
	//-----------------------------------------------------------------------------
}
