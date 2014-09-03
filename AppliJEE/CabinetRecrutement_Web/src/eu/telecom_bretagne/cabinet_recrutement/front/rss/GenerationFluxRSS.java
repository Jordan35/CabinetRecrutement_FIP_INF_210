package eu.telecom_bretagne.cabinet_recrutement.front.rss;

import java.io.Writer;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.servlet.jsp.JspWriter;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature;
import eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocatorException;
import eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils;
import eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature;
import eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi;

/**
 * Classe permettant la gestion des flux RSS publiant la liste des offres
 * d'emploi et la liste des candidatures. La classe contient deux méthodes
 * statiques :
 * <ul>
 * 		<li>{@code GenerationFluxRSS.offresEmploi (Writer writer, String urlBase)}</li>
 * 		<li>{@code GenerationFluxRSS.candidatures(Writer writer, String urlBase)}</li>
 * </ul>
 * @author Philippe TANGUY
 */
public class GenerationFluxRSS
{
	//-----------------------------------------------------------------------------
	private static ObjectFactory fabrique = new ObjectFactory();
	private static Marshaller marshaller; 
	//-----------------------------------------------------------------------------
	/**
	 * Méthode privée qui construit la base du flux RSS. Les éléments du flux présents
	 * à ce stade sont les élements factorisés communs aux deux flux (liste des offres
	 * d'emploi et liste des candidatures).
	 * @param urlBase l'URL de base (une chaîne de caractères) permettant la récupération des éléments du flux.
	 * @return l'élément de base du flux RSS : {@link Rss }
	 * @throws JAXBException
	 */
	private static Rss getRss(String urlBase) throws JAXBException
	{
		JAXBContext jc = JAXBContext.newInstance("eu.telecom_bretagne.cabinet_recrutement.front.rss");
		marshaller = jc.createMarshaller();
		marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		
		Rss rss = fabrique.createRss();
		rss.setVersion(new BigDecimal(2));
		
		Channel channel = fabrique.createChannel();
		channel.setLink(urlBase + "/CabinetRecrutement_WEB/template.jsp");
		channel.setPubDate(Utils.date2StringRSS(new Date()));
		
		Image logo = fabrique.createImage();
		
		logo.setUrl(urlBase + "/CabinetRecrutement_WEB/images/petite_loupe.png");
		logo.setLink(urlBase + "/CabinetRecrutement_WEB/template.jsp");
		channel.setImage(logo);
		
		rss.setChannel(channel);
		
		return rss;
	}
	//-----------------------------------------------------------------------------
	/**
	 * Construction du flux RSS de la liste des offres d'emploi. La méthode construit
	 * le flux en y ajoutant d'abord les éléments génériques par l'appel de la méthode
	 * privée {@code getRss} puis les éléments spécifiques. Ceux-ci sont obtenus par
	 * l'appel de la méthode {@code listeDesOffres()}, voir : {@link IServiceOffreEmploi}.
	 * @param writer  l'instance du {@link Writer} sur lequel sera écrit le flux RSS.
	 *                La méthode étant appelée au sein d'un JSP, celui-ci est l'instance
	 *                de l'objet prédéfini {@code out}, instance de {@link JspWriter}.
	 * @param urlBase l'URL de base (une chaîne de caractères) permettant la récupération
	 *                des éléments du flux.
	 * @throws JAXBException
	 * @throws ServicesLocatorException
	 */
	public static void offresEmploi(Writer writer, String urlBase) throws JAXBException, ServicesLocatorException
	{
		IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
		List<OffreEmploi> offres = serviceOffreEmploi.listeDesOffres();
		
		String title = "Cabinet de recrutement : les offres d'emploi";
		Rss rss = getRss(urlBase);
		rss.getChannel().setTitle(title);
		rss.getChannel().setDescription("Fil rouge : gestion d'un cabinet de recrutement. Flux RSS listant les offres d'emploi.");
		rss.getChannel().getImage().setTitle(title);

		for(OffreEmploi offre : offres)
		{
			Item item = fabrique.createItem();
			item.setTitle(offre.getTitre() + " (" + offre.getEntreprise().getNom() + ")");
			item.setLink(urlBase + "/CabinetRecrutement_WEB/template.jsp?action=infos_offre&id=" + offre.getId());
			item.setDescription(Utils.text2HTML(offre.getDescriptifMission()));
			Enclosure enclosure = fabrique.createEnclosure();
			enclosure.setUrl(urlBase + "/CabinetRecrutement_WEB/images/icone_offre_emploi.png");
			enclosure.setType("image/png");
			item.setEnclosure(enclosure);
			item.setPubDate(Utils.date2StringRSS(offre.getDateDepot()));
			
			rss.getChannel().getItem().add(item);
		}
		
		marshaller.marshal(rss, writer);
	}
	//-----------------------------------------------------------------------------
	/**
	 * Construction du flux RSS de la liste des candidature. La méthode construit
	 * le flux en y ajoutant d'abord les éléments génériques par l'appel de la méthode
	 * privée {@code getRss} puis les éléments spécifiques. Ceux-ci sont obtenus par
	 * l'appel de la méthode {@code listeDesCandidatures()}, voir : {@link IServiceCandidature}.
	 * @param writer  l'instance du {@link Writer} sur lequel sera écrit le flux RSS.
	 *                La méthode étant appelée au sein d'un JSP, celui-ci est l'instance
	 *                de l'objet prédéfini {@code out}, instance de {@link JspWriter}.
	 * @param urlBase l'URL de base (une chaîne de caractères) permettant la récupération
	 *                des éléments du flux.
	 * @throws JAXBException
	 * @throws ServicesLocatorException
	 */
	public static void candidatures(Writer writer, String urlBase) throws JAXBException, ServicesLocatorException
	{
		IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
		List<Candidature> candidatures = serviceCandidature.listeDesCandidatures();
		
		String title = "Cabinet de recrutement : les candidatures";
		Rss rss = getRss(urlBase);
		rss.getChannel().setTitle(title);
		rss.getChannel().setDescription("Fil rouge : gestion d'un cabinet de recrutement. Flux RSS listant les candidatures.");
		rss.getChannel().getImage().setTitle(title);

		for(Candidature candidature : candidatures)
		{
			Item item = fabrique.createItem();
			item.setTitle(candidature.getNom() + " " + candidature.getPrenom());
			item.setLink(urlBase + "/CabinetRecrutement_WEB/template.jsp?action=infos_candidature&id=" + candidature.getId());
			item.setDescription(Utils.text2HTML(candidature.getAdresseEmail() + "\n" + candidature.getCv()));
			Enclosure enclosure = fabrique.createEnclosure();
			enclosure.setUrl(urlBase + "/CabinetRecrutement_WEB/images/icone_candidature.png");
			enclosure.setType("image/png");
			item.setEnclosure(enclosure);
			item.setPubDate(Utils.date2StringRSS(candidature.getDateDepot()));
			
			rss.getChannel().getItem().add(item);
		}
		
		marshaller.marshal(rss, writer);
	}
	//-----------------------------------------------------------------------------
}
