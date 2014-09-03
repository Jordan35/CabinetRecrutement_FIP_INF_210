package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi;

/**
 * Session Bean implementation class MessageCandidatureDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class MessageOffreEmploiDAO
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
	public MessageOffreEmploiDAO()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	public MessageOffreEmploi persist(MessageOffreEmploi messageOffreEmploi)
	{
		entityManager.persist(messageOffreEmploi);
		return messageOffreEmploi;
	}
	//----------------------------------------------------------------------------
	public void remove(MessageOffreEmploi messageOffreEmploi)
	{
		if(!entityManager.contains(messageOffreEmploi))                 // Si l'entité n'est pas dans un état "géré" (managed),
		{                                                               // il est impossible de la supprimer directement, erreur "Entity must be managed to call remove"
			messageOffreEmploi = entityManager.merge(messageOffreEmploi);	// Il faut la "rattacher" au contexte de persistance par l'appel		
		}                                                               // de la méthode merge de l'ENtityManager.
		
		// L'entité était déjà attachée ou a été rattachée, on peut donc la supprimer...
		entityManager.remove(messageOffreEmploi);
	}
	//----------------------------------------------------------------------------
	public MessageOffreEmploi findById(Integer id)
	{
		return entityManager.find(MessageOffreEmploi.class, id);
	}
	//----------------------------------------------------------------------------
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<MessageOffreEmploi> findByOffreEmploi(Integer idOffreEmploi)
	{
		Query query = entityManager.createQuery("select message from MessageOffreEmploi message where message.offreEmploi.id = :idOE order by message.id desc");
		query.setParameter("idOE", idOffreEmploi);
    List l = query.getResultList(); 
		
		return (List<MessageOffreEmploi>)l;
	}
	//----------------------------------------------------------------------------
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<MessageOffreEmploi> findByCandidature(Integer idCandidature)
	{
		Query query = entityManager.createQuery("select message from MessageOffreEmploi message where message.candidature.id = :idC order by message.id desc");
		query.setParameter("idC", idCandidature);
    List l = query.getResultList(); 
		
		return (List<MessageOffreEmploi>)l;
	}
	//----------------------------------------------------------------------------
  @SuppressWarnings({ "rawtypes", "unchecked" })
  public List<MessageOffreEmploi> findAll()
	{
		Query query = entityManager.createQuery("select message from MessageOffreEmploi message order by message.id desc");
    List l = query.getResultList(); 
		
		return (List<MessageOffreEmploi>)l;
	}
	//-----------------------------------------------------------------------------
}
