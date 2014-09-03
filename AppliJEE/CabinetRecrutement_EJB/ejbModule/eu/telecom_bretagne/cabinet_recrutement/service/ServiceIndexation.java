package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.NiveauQualificationDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.SecteurActiviteDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification;
import eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite;

/**
 * Session Bean implementation class ServiceIndexation
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceIndexation implements IServiceIndexation
{
	//-----------------------------------------------------------------------------
	@EJB private SecteurActiviteDAO     secteurActiviteDAO;
	@EJB private NiveauQualificationDAO niveauQualificationDAO;
	//-----------------------------------------------------------------------------
	/**
	 * Default constructor.
	 */
	public ServiceIndexation()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	public List<SecteurActivite> listeSecteursActivite()
	{
		return secteurActiviteDAO.findAll();
	}
	//-----------------------------------------------------------------------------
	public List<NiveauQualification> listeNiveauxQualification()
	{
		return niveauQualificationDAO.findAll();
	}
	//-----------------------------------------------------------------------------
}
