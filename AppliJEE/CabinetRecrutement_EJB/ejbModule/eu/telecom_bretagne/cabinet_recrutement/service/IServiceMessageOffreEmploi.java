package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.Date;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;

/**
 * Interface du service gérant les messages expédiés par une entreprise pour une offre d'emploi vers une candidature.
 * @author Philippe TANGUY
 */
@Remote
public interface IServiceMessageOffreEmploi
{
	//-----------------------------------------------------------------------------
	/**
	 * Création d'un message émis par une entreprise au sujet d'une offre d'emploi à
	 * destination d'un candidat.
	 * 
	 * @param idOffre
	 * @param idCandidature
	 * @param dateEnvoi
	 * @param corpsMessage
	 * @return l'instance de {@link MessageOffreEmploi} une fois qu'elle a été rendue
	 *         persistante dans la base.
	 */
	public MessageOffreEmploi nouveauMessageOffreEmploi(int idOffre, int idCandidature, Date dateEnvoi, String corpsMessage);
	//-----------------------------------------------------------------------------
}
