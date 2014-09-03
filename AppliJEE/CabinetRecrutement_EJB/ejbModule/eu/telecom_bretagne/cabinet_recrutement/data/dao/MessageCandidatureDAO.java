package eu.telecom_bretagne.cabinet_recrutement.data.dao;

import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;

/**
 * Session Bean implementation class MessageCandidatureDAO
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class MessageCandidatureDAO
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
	public MessageCandidatureDAO()
	{
		// TODO Auto-generated constructor stub
	}
	//-----------------------------------------------------------------------------
	public MessageCandidature persist(MessageCandidature messageCandidature)
	{
		entityManager.persist(messageCandidature);
		return messageCandidature;
	}
	//----------------------------------------------------------------------------
	public void remove(MessageCandidature messageCandidature)
	{
		if(!entityManager.contains(messageCandidature))         // Si l'entité n'est pas dans un état "géré" (managed),
		{                                                       // il est impossible de la supprimer directement, erreur "Entity must be managed to call remove"
			messageCandidature = entityManager.merge(messageCandidature);	// Il faut la "rattacher" au contexte de persistance par l'appel		
		}                                                       // de la méthode merge de l'ENtityManager.
		
		// L'entité était déjà attachée ou a été rattachée, on peut donc la supprimer...
		entityManager.remove(messageCandidature);
	}
	//----------------------------------------------------------------------------
	public MessageCandidature findById(Integer id)
	{
		return entityManager.find(MessageCandidature.class, id);
	}
	//----------------------------------------------------------------------------
	@SuppressWarnings({ "unchecked", "rawtypes" })
  public List<MessageCandidature> findByOffreEmploi(Integer idOffreEmploi)
	{
		Query query = entityManager.createQuery("select message from MessageCandidature message where message.offreEmploi.id = :idOE order by message.id desc");
		query.setParameter("idOE", idOffreEmploi);
    List l = query.getResultList(); 
		
		return (List<MessageCandidature>)l;
	}
	//----------------------------------------------------------------------------
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<MessageCandidature> findByCandidature(Integer idCandidature)
	{
		Query query = entityManager.createQuery("select message from MessageCandidature message where message.candidature.id = :idC order by message.id desc");
		query.setParameter("idC", idCandidature);
    List l = query.getResultList(); 
		
		return (List<MessageCandidature>)l;
	}
	//----------------------------------------------------------------------------
	@SuppressWarnings({ "unchecked", "rawtypes" })
  public List<MessageCandidature> findAll()
	{
		Query query = entityManager.createQuery("select message from MessageCandidature message order by message.id desc");
    List l = query.getResultList(); 
		
		return (List<MessageCandidature>)l;
	}
	//-----------------------------------------------------------------------------
}
