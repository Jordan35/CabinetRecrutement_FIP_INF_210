package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;

/**
 * Session Bean implementation class CandidatureDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class CandidatureDAO
{
	//-----------------------------------------------------------------------------
	/**
	 * Référence vers le gestionnaire de persistance.
	 */
	@PersistenceContext
	EntityManager entityManager;
	//-----------------------------------------------------------------------------
	/**
	 * Default constructor.
	 */
	public CandidatureDAO()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	/**
	 * Rend persistante l'instance (bean entity) de l'offre d'emploi.
	 * @param offreEmploi bean entity représentant l'instance.
	 * @return l'instance de l'offre d'emploi une fois persistée dans la base de données.
	 */
	public Candidature persist(Candidature candidature)
	{
		entityManager.persist(candidature);
		return candidature;
	}
	//----------------------------------------------------------------------------
	/**
	 * Obtention d'une instance de {@link Candidature} par son id.
	 * @param id id de la candidature à obtenir.
	 * @return l'instance de l'entité trouvée ou {@code null} si l'id ne correspond
	 *         à aucune entrée dans la base.
	 */
	public Candidature findById(Integer id)
	{
		//return entityManager.find(Candidature.class, id);
		
    // 23/09/2014 : voir commentaire de OffreEmploiDAO, findById(Integer id).
    Candidature candidature = entityManager.find(Candidature.class, id);
    entityManager.refresh(candidature);
    return candidature;
	}
	//----------------------------------------------------------------------------
  /**
   * Obtention de la liste des candidatures correspondant à un secteur d'activité
   * et un niveau de qualification.
   * @param idSecteurActivite le secteur d'activité.
   * @param idNiveauQualification le niveau de qualification.
	 * @return la liste des candidatures dans une {@code List<Candidature>}.
   */
  @SuppressWarnings("unchecked")
  public List<Candidature> findBySecteurActiviteAndNiveauQualification(int idSecteurActivite, int idNiveauQualification)
	{
  	Query query = entityManager.createQuery("select c from Candidature c join c.secteursActivite secteur where secteur.id = :idSA and c.niveauQualification.id = :idNQ order by c.id desc");
  	query.setParameter("idSA", idSecteurActivite);
  	query.setParameter("idNQ", idNiveauQualification);
    List<Candidature> l = query.getResultList();
		return l;
	}
  //----------------------------------------------------------------------------
	/**
	 * Obtention de la liste de toutes les candidatures référencées dans le système.<br/>
	 * <u>Note</u> : les candidatures sont triées par id descendant (les plus récentes
	 * en premier). 
	 * @return la liste des candidatures dans une {@code List<Candidature>}.
	 */
  @SuppressWarnings({ "unchecked", "rawtypes" })
  public List<Candidature> findAll()
	{
		Query query = entityManager.createQuery("select candidature from Candidature candidature order by candidature.id desc");
    List l = query.getResultList(); 
		
		return (List<Candidature>)l;
	}
	//-----------------------------------------------------------------------------
	/**
	 * Répercution dans la base de la modification d'une instance de {@code Candidature}.<br/>
	 * <u>Note</u> : avant l'appel de la méthode, les modifications apportées à l'instance
	 * n'existent qu'en mémoire. Après l'appel, les modifications sont rendues persistantes.
	 * @param l'instance de la {@code Candidature} à mettre à jour.
	 * @return L'instance de la {@code Candidature} une fois les modifications persistées
	 *         dans la base.
	 */
	public Candidature update(Candidature candidature)
	{
		return entityManager.merge(candidature);
	}
	//-----------------------------------------------------------------------------
	/**
	 * Suppression d'une {@code Candidature} dans la base.
	 * @param candidature l'instance de la {@code Candidature} à supprimer.
	 */
	public void remove(Candidature candidature)
	{
		if(!entityManager.contains(candidature))         // Si l'entité n'est pas dans un état "géré" (managed),
		{                                               // il est impossible de la supprimer directement, erreur "Entity must be managed to call remove"
			candidature = entityManager.merge(candidature);	// Il faut la "rattacher" au contexte de persistance par l'appel		
		}                                               // de la méthode merge de l'ENtityManager.
		
		// L'entité était déjà attachée ou a été rattachée, on peut donc la supprimer...
		entityManager.remove(candidature);
	}
	//-----------------------------------------------------------------------------
}
