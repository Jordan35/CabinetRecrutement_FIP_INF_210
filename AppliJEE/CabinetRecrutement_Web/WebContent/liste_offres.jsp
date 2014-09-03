<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite,
                java.util.Set,
                java.util.List"%>

<%
	IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
  IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");

  String idEntreprise  = request.getParameter("id_entreprise");
  String idCandidature = request.getParameter("id_candidature");

  List<OffreEmploi> offres;
  if(idEntreprise != null)
    offres = serviceOffreEmploi.listeDesOffresPourUneEntreprise(Integer.parseInt(idEntreprise));
  else if(idCandidature != null)
    offres = serviceOffreEmploi.listeDesOffresPourUneCandidature(Integer.parseInt(idCandidature));
  else
  	offres = serviceOffreEmploi.listeDesOffres();
  	
	
%>

<h2>Liste des offres d'emploi référencées :</h2>

<table id="affichage">
  <tr>
    <th>Numéro</th>
    <th>Titre</th>
    <%
    if(idEntreprise != null)  // Pour l'affichage d'un lien permettant la mise à jour
    {                         // de l'offre et d'un lien permettant son effacement.
      %>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
      <%
    }
    %>
    <th>Entreprise</th>
    <th>Niveau de qualification</th>
    <th>Date de dépôt</th>
    <%
    if(idEntreprise != null)  // On demande la liste des offres pour une entreprise
    {                         // donnée -> on affiche alors le nombre de candidtures potentielles.
    	%>
    	<th style="text-align: left;">Candidatures potentielles</th>
    	<%
    }
    %>
  </tr>
  <%
  if(offres == null)
  {
  	%>
  	</table>
  	<p>Aucune offre...</p>
  	<%
  }
  else
  {
    for(OffreEmploi offre : offres)
    {
      %>
      <tr>
       <td><%=offre.getId()%></td>
       <td><a href="template.jsp?action=infos_offre&id=<%=offre.getId()%>"><%=offre.getTitre()%></a></td>
       <%
       if(idEntreprise != null)  // On demande la liste des offres pour une entreprise
       {                         // donnée -> on affiche alors le nombre de candidtures potentielles.
         %>
         <td>
           <a href="template.jsp?action=maj_offre&id_offre=<%=offre.getId()%>"><img src="images/mise_a_jour.png" border="0" alt="Mise à jour de l'offre d'emploi"/></a><br/>
         </td>
         <td>
           <a href="template.jsp?action=efface_offre&id_offre=<%=offre.getId()%>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette offre d\'emploi ?\n\nAttention, cette opération n\'est pas réversible !\n\n');"><img src="images/effacement.png" border="0" alt="Effacement de l'offre d'emploi" /></a><br/>
         </td>
         <%
       }
       %>
       <td><%=offre.getEntreprise().getNom()%></td>
       <td><%=offre.getNiveauQualification().getIntitule()%></td>
       <td><%=Utils.date2String(offre.getDateDepot())%></td>
	     <%
	     if(idEntreprise != null)  // On demande la liste des offres pour une entreprise
	     {                         // donnée -> on affiche alors le nombre de candidtures potentielles.
	       %>
	       <td>
	         <%
	         List<Candidature> candidaturesPotentielle = serviceCandidature.listeDesCandidaturesPourUneOffre(offre.getId());
	         if(candidaturesPotentielle.size() == 0)
	         {
	        	 %>-<%
	         }
	         else
	         {
	        	 for(Candidature c : candidaturesPotentielle)
	        	 {
	             %><a href="template.jsp?action=infos_candidature&id=<%=c.getId()%>"><%=c.getNom()%> <%=c.getPrenom()%> (CAND_<%=c.getId()%>)</a><br/><%
	        	 }
	         }
	         %>
	       </td>
	       <%
	     }
	     %>
      </tr>
      <%
    }
  }
  %>
</table>

<%
  if(idCandidature==null && idEntreprise==null) // on affiche le lien RSS uniquement pour la liste complète des offres d'emploi.
  {
  	%>
    <p align="center"><a href="cabinet_recrutement_offres_rss.jsp"><img src="images/icone_rss.png" alt="" border="0"/></a></p>
  	<%
  }
%>
