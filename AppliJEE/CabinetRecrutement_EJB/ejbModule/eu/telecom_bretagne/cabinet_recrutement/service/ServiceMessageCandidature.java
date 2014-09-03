package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.Date;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageCandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;

/**
 * Session Bean implementation class ServiceMessageCandidature
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceMessageCandidature implements IServiceMessageCandidature
{
	//-----------------------------------------------------------------------------
	@EJB private OffreEmploiDAO        offreEmploiDAO;
	@EJB private CandidatureDAO        candidatureDAO;
	@EJB private MessageCandidatureDAO messageCandidatureDAO;
	//-----------------------------------------------------------------------------
	/**
	 * Default constructor.
	 */
	public ServiceMessageCandidature()
	{
	}
	//-----------------------------------------------------------------------------
	@Override
	public MessageCandidature nouveauMessageCandidature(int idCandidature, int idOffre, Date dateEnvoi, String corpsMessage)
	{
		MessageCandidature message = new MessageCandidature();
		message.setCandidature(candidatureDAO.findById(idCandidature));
		message.setOffreEmploi(offreEmploiDAO.findById(idOffre));
		message.setDateEnvoi(dateEnvoi);
		message.setCorps(corpsMessage);
		
		return messageCandidatureDAO.persist(message);
	}
	//-----------------------------------------------------------------------------
}
