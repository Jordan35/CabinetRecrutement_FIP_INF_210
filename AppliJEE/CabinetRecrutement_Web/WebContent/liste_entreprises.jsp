<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                java.util.List"%>

<%
	IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
	List<Entreprise> entreprises = serviceEntreprise.listeDesEntreprises();
%>

<h2>Liste des entreprises référencées :</h2>

<table id="affichage">
  <tr>
    <th>Identifiant</th>
    <th>Nom</th>
    <th>Adresse postale (ville)</th>
    <th>Nombre d'offres d'emploi déposées</th>
  </tr>
  <%
  for(Entreprise entreprise : entreprises)
  {
  	%>
  	<tr>
     <td>ENT_<%=entreprise.getId()%></td>
     <td><a href="template.jsp?action=infos_entreprise&id=<%=entreprise.getId()%>"><%=entreprise.getNom()%></a></td>
     <td><%=entreprise.getAdressePostale()%></td>
     <td>
       <%int nb = entreprise.getOffresEmploi().size();%>
       <%=(nb==0?"-":nb)%>
     </td>
  	</tr>
  	<%
  }
  %>
</table>
