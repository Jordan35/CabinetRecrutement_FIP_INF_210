package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.Date;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;

/**
 * Interface du service gérant les messages expédiés d'une candidature vers une offre d'emploi.
 * @author Philippe TANGUY
 */
@Remote
public interface IServiceMessageCandidature
{
	//-----------------------------------------------------------------------------
	/**
	 * Création d'un message émis par un candidat au sujet d'une offre d'emploi à
	 * destination d'un entreprise.
	 * 
	 * @param idCandidature
	 * @param idOffre
	 * @param dateEnvoi
	 * @param corpsMessage
	 * @return l'instance de {@link MessageCandidature} une fois qu'elle a été rendue
	 *         persistante dans la base.
	 */
	public MessageCandidature nouveauMessageCandidature(int idCandidature, int idOffre, Date dateEnvoi, String corpsMessage);
	//-----------------------------------------------------------------------------
}
