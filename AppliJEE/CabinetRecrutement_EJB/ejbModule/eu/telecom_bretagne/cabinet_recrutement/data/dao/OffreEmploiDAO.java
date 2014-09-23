package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;

/**
 * Session Bean implementation class OffreEmploiDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class OffreEmploiDAO
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
	public OffreEmploiDAO()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	/**
	 * Rend persistante l'instance (bean entity) de l'offre d'emploi.
	 * @param offreEmploi bean entity représentant l'instance.
	 * @return l'instance de l'offre d'emploi une fois persistée dans la base de données.
	 */
	public OffreEmploi persist(OffreEmploi offreEmploi)
	{
		entityManager.persist(offreEmploi);
		return offreEmploi;
	}
	//----------------------------------------------------------------------------
	public OffreEmploi findById(Integer id)
	{
		//return entityManager.find(OffreEmploi.class, id);
	  
	  // 23/09/2014 return entityManager.find(OffreEmploi.class, id); fonctionne mais
	  // après une insertion ne renvoie pas correctement la liste des secteurs d'activité
	  // associée : la méthode refresh met à jour les données managées avec les données
	  // de la base.
	  OffreEmploi offreEmploi = entityManager.find(OffreEmploi.class, id);
		entityManager.refresh(offreEmploi);
	  return offreEmploi;
	}
	//----------------------------------------------------------------------------
  @SuppressWarnings("unchecked")
  public List<OffreEmploi> findByEntreprise(int idEntreprise)
	{
		Query query = entityManager.createQuery("select offreEmploi from OffreEmploi offreEmploi where offreEmploi.entreprise.id = :idE order by offreEmploi.id desc");
		query.setParameter("idE", idEntreprise);
    List<OffreEmploi> l = query.getResultList();
		return l;
	}
	//----------------------------------------------------------------------------
  @SuppressWarnings("unchecked")
  public List<OffreEmploi> findBySecteurActiviteAndNiveauQualification(int idSecteurActivite, int idNiveauQualification)
	{
  	Query query = entityManager.createQuery("select oe from OffreEmploi oe join oe.secteursActivite secteurs where secteurs.id = :idSA and oe.niveauQualification.id = :idNQ order by oe.id desc");
		query.setParameter("idSA", idSecteurActivite);
		query.setParameter("idNQ", idNiveauQualification);
    List<OffreEmploi> l = query.getResultList();
		return l;
	}
  //----------------------------------------------------------------------------
  @SuppressWarnings({ "unchecked", "rawtypes" })
  public List<OffreEmploi> findAll()
	{
		Query query = entityManager.createQuery("select offreEmploi from OffreEmploi offreEmploi order by offreEmploi.id desc");
    List l = query.getResultList(); 
		
		return (List<OffreEmploi>)l;
	}
	//-----------------------------------------------------------------------------
	public OffreEmploi update(OffreEmploi offreEmploi)
	{
		return entityManager.merge(offreEmploi);
	}
	//-----------------------------------------------------------------------------
	public void remove(OffreEmploi offreEmploi)
	{
		if(!entityManager.contains(offreEmploi))          // Si l'entité n'est pas dans un état "géré" (managed),
		{                                                 // il est impossible de la supprimer directement, erreur "Entity must be managed to call remove"
			offreEmploi = entityManager.merge(offreEmploi);	// Il faut la "rattacher" au contexte de persistance par l'appel		
		}                                                 // de la méthode merge de l'ENtityManager.
		
		// L'entité était déjà attachée ou a été rattachée, on peut donc la supprimer...
		entityManager.remove(offreEmploi);
	}
	//-----------------------------------------------------------------------------
}
