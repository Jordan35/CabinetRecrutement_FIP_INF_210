<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite,
                java.util.Set,
                java.util.List"%>

<%
	IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  List<Candidature> candidatures = serviceCandidature.listeDesCandidatures();
%>

<h2>Liste des candidatures référencées :</h2>

<table id="affichage">
  <tr>
    <th>Identifiant</th>
    <th>Nom/prénom</th>
    <th>Adresse postale</th>
    <th>Adresse email</th>
    <th>Niveau de qualification</th>
    <th>Date de dépôt</th>
  </tr>
  <%
  for(Candidature candidature  : candidatures)
  {
  	%>
  	<tr>
     <td>CAND_<%=candidature.getId()%></td>
     <td><a href="template.jsp?action=infos_candidature&id=<%=candidature.getId()%>"><%=candidature.getNom()%> <%=candidature.getPrenom()%></a></td>
     <td><%=candidature.getAdressePostale()%></td>
     <td><a href="mailto:<%=candidature.getAdresseEmail()%>"><%=candidature.getAdresseEmail()%></a></td>
     <td><%=candidature.getNiveauQualification().getIntitule()%></td>
     <td><%=Utils.date2String(candidature.getDateDepot())%></td>
  	</tr>
  	<%
  }
  %>
</table>

<p align="center"><a href="cabinet_recrutement_candidatures_rss.jsp"><img src="images/icone_rss.png" alt="" border="0"/></a></p>
