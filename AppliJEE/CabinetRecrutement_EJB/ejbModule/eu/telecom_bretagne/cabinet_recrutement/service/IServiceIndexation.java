package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.Remote;

import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Interface du service gérant l'indexation. L'indexation concerne à la fois
 * les offres d'emploi et les candidatures. Cette classe permet de récupérer
 * les éléments d'indexation stockés dans la base.
 * 
 * @author Philippe TANGUY
 */
@Remote
public interface IServiceIndexation
{
	//-----------------------------------------------------------------------------
	/**
	 * Obtention de la liste des secteurs d'activité.
	 * 
	 * @return la liste des secteurs d'activité dans une {@code List<SecteurActivite>}.
	 */
	public List<SecteurActivite>     listeSecteursActivite();
	/**
	 * Obtention de la liste des niveaux de qualification.
	 * 
	 * @return la liste des niveaux de qualification dans une {@code List<NiveauQualification>}.
	 */
	public List<NiveauQualification> listeNiveauxQualification();
	//-----------------------------------------------------------------------------
}
