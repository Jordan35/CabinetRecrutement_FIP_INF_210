package eu.telecom_bretagne.cabinet_recrutement.front.rest;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocatorException;
import eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature;
import eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise;
import eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi;

@Path("/entreprise")
public class EntrepriseREST
{
	//-----------------------------------------------------------------------------
	private static IServiceEntreprise  serviceEntreprise;
	
	static
	{
    try
    {
	    serviceEntreprise  = (IServiceEntreprise)  ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
    }
    catch (ServicesLocatorException e)
    {
    	e.printStackTrace();
    }
	}
	//-----------------------------------------------------------------------------
	@GET
	@Produces(MediaType.TEXT_PLAIN)
	@Path("/text")
	public String getEntreprises_TEXT()
	{
		String separateur = "\n---------------------------------------------------------\n";
		String s = separateur;
		
		for(Entreprise e : serviceEntreprise.listeDesEntreprises())
		{
			s += e + separateur;
		}
		
    return s;
	}
	//-----------------------------------------------------------------------------
	@GET
	@Produces(MediaType.TEXT_PLAIN)
	@Path("/text/{id}")
	public String getEntrepriseById_TEXT(@PathParam("id") int id)
	{
		Entreprise e = serviceEntreprise.getEntreprise(id);
		return 
				
				"NOM DE L'ENTREPRISE :\n" +
				"-------------------\n" +
				"(" + e.getId() + ") " + e.getNom() + "\n\n" +
				"DESCRIPTIF :\n" +
				"----------\n" +
				e.getDescriptif() + "\n\n" +
				"ADRESSE POSTALE :\n" +
				"---------------\n" +
				e.getAdressePostale() + "\n\n" +
				"NOMBRE D'OFFRES D'EMPLOI RÉFÉRENCÉES :\n" +
				"------------------------------------\n" +
				e.getOffresEmploi().size();
	}
	//-----------------------------------------------------------------------------
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<Entreprise> getEntreprises_JSON()
	{
		List<Entreprise> entreprises1 = serviceEntreprise.listeDesEntreprises();
		List<Entreprise> entreprisesResultat = new ArrayList<Entreprise>();
		for(Entreprise e : entreprises1)
		{
			e.setOffresEmploi(null);
			entreprisesResultat.add(e);
		}
		
		return entreprisesResultat;
	}
	//-----------------------------------------------------------------------------
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Path("{id}")
	public Entreprise getEntrepriseById_JSON(@PathParam("id") int id)
	{
		Entreprise entreprise = serviceEntreprise.getEntreprise(id);
		entreprise.setOffresEmploi(new HashSet<OffreEmploi>());
		return entreprise;
//		return serviceEntreprise.getEntreprise(id);
	}
	//-----------------------------------------------------------------------------
  // This method is called if XML is request
	@GET
	@Produces(MediaType.TEXT_XML)
	@Path("/xml")
	public String sayXMLHello()
	{
		String xml = "<?xml version=\"1.0\"?>" +
				         "<entreprises>";
		for(Entreprise e : serviceEntreprise.listeDesEntreprises())
		{
			xml += "<entreprise>" +
					   "<id>"+e.getId()+"</id>" +
					   "<nom>"+e.getNom()+"</nom>" +
					   "<descriptif>"+e.getDescriptif().replace("&", "&amp;")+"</descriptif>" +
					   	"<adresse>"+e.getAdressePostale()+"</adresse>" +
					   	"</entreprise>";
		}
		xml += "</entreprises>";
		return xml;
	}
  //-----------------------------------------------------------------------------
	// This method is called if HTML is request
	@GET
	@Produces(MediaType.TEXT_HTML)
	@Path("/html")
	public String sayHtmlHello()
	{
		return "<html> " + "<title>" + "Hello Jersey" + "</title>" + "<body><h1>"
		    + "Hello Jersey" + "</body></h1>" + "</html> ";
	}
  //-----------------------------------------------------------------------------
}
