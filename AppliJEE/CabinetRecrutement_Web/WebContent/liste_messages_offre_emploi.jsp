<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature,
                java.util.List"%>

<%
	Object utilisateur = session.getAttribute("utilisateur");
	if(utilisateur instanceof Candidature)
	{
    IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");

    Candidature candidature = (Candidature) utilisateur;
	  %>
		<h2>Liste des messages reçus :</h2>
		
		<table id="affichage">
		  <tr>
		    <th>Id</th>
		    <th>Offre</th>
		    <th>Date envoi</th>
		    <th>Message</th>
		  </tr>
		  <%
		  for(MessageOffreEmploi message : serviceCandidature.listeDesMessagesRecus(candidature.getId()))
		  {
		    %>
		    <tr>
		     <td><%=message.getId()%></td>
		     <td>Offre n° <%=message.getOffreEmploi().getId()%> -> <a href="template.jsp?action=infos_offre&id=<%=message.getOffreEmploi().getId()%>"><%=message.getOffreEmploi().getTitre()%> (<%=message.getOffreEmploi().getEntreprise().getNom()%>)</a></td>
		     <td><%=Utils.date2String(message.getDateEnvoi())%></td>
		     <td><%=Utils.text2HTML(message.getCorps())%></td>
		    </tr>
		    <%
		  }
		  %>
		</table>
	  <%
	}
	else if(utilisateur instanceof Entreprise)
	{
		IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
		
		Entreprise entreprise = (Entreprise) utilisateur;
    %>
    <h2>Liste des messages envoyés :</h2>
    
    <table id="affichage">
      <tr>
        <th>Id</th>
        <th>Candidature</th>
        <th>Offre</th>
        <th>Date envoi</th>
        <th>Message</th>
      </tr>
      <%
      for(MessageOffreEmploi message : serviceEntreprise.listeDesMessagesEnvoyes(entreprise.getId()))
      {
        %>
        <tr>
         <td><%=message.getId()%></td>
         <td><a href="template.jsp?action=infos_candidature&id=<%=message.getCandidature().getId()%>"><%=message.getCandidature().getNom()%> <%=message.getCandidature().getPrenom()%> (CAND_<%=message.getCandidature().getId()%>)</a></td>
         <td>Offre n° <%=message.getOffreEmploi().getId()%> -> <a href="template.jsp?action=infos_offre&id=<%=message.getOffreEmploi().getId()%>"><%=message.getOffreEmploi().getTitre()%></a></td>
         <td><%=Utils.date2String(message.getDateEnvoi())%></td>
         <td><%=Utils.text2HTML(message.getCorps())%></td>
        </tr>
        <%
      }
      %>
    </table>
    <%
	}
%>
