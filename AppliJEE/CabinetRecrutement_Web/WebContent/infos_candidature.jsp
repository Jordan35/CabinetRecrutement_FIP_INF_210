<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite,
                java.util.Set"%>

<%
  String idString = request.getParameter("id");
  if(idString == null)
  {
    %>
    <p class="erreur">Erreur : il n'y a aucune candidature qui corresponde à cette recherche.</p>
    <%
  }
  else
  {
    IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
    int id = Integer.parseInt(idString);
    Candidature candidature = serviceCandidature.getCandidature(id);
    %>
    <h2>Infos candidature :</h2>
    
    <%
    if(candidature == null)
    {
      %>
      <p class="erreur">Erreur : la candidature numéro <%=idString%> n'est pas (<i>plus ?</i>) référencée dans la base.</p>
      <%
    }
    else
    {
    	%>
	     <table id="affichage">
	      <tr>
	        <th style="width: 170px;">Identifiant :</th>
	        <td>
	          CAND_<%=candidature.getId()%>
	        </td>
	      </tr>
	       <tr>
	         <th>nom :</th>
	         <td>
	           <%=candidature.getNom()%>
	         </td>
	       </tr>
	       <tr>
	         <th>Prénom :</th>
	         <td>
	           <%=candidature.getPrenom()%>
	         </td>
	       </tr>
	       <tr>
	         <th>Date de naissance :</th>
	         <td>
	           <%=Utils.date2String(candidature.getDateNaissance())%>
	         </td>
	       </tr>
	      <tr>
	        <th>Adresse postale (ville) :</th>
	        <td>
	          <%=candidature.getAdressePostale()%>
	        </td>
	      </tr>
	      <tr>
	        <th>Adresse email :</th>
	        <td>
	          <a href="mailto:<%=candidature.getAdresseEmail()%>"><%=candidature.getAdresseEmail()%></a>
	        </td>
	      </tr>
	      <tr>
	        <th>Curriculum vitæ :</th>
	        <td>
	          <%=Utils.text2HTML(candidature.getCv())%>
	        </td>
	      </tr>
	      <tr>
	        <th>Niveau de qualification :</th>
	        <td>
	          <%=candidature.getNiveauQualification().getIntitule()%>
	        </td>
	      </tr>
	      <tr>
	        <th>Secteur(s) d'activité :</th>
	        <td>
	          <ul>
	            <%
	            Set<SecteurActivite> secteursActivite = candidature.getSecteursActivite();
	            for(SecteurActivite s : secteursActivite)
	            {
	              %>
	              <li><%=s.getIntitule()%></li>
	              <%
	            }
	            %>
	          </ul>
	        </td>
	      </tr>
	      <tr>
	        <th>Date de dépôt :</th>
	        <td>
	          <%=Utils.date2String(candidature.getDateDepot())%>
	        </td>
	      </tr>
	    </table>
      <%    	
    }
  }
%>
