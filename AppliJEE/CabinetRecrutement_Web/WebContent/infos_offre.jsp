<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite,
                java.util.Set,
                java.util.List"%>

<%
  String idString = request.getParameter("id");
  if(idString == null)
  {
    %>
    <p class="erreur">Erreur : il n'y a aucune offre d'emploi qui corresponde à cette recherche.</p>
    <%
  }
  else
  {
    IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
    int id = Integer.parseInt(idString);
    OffreEmploi offre = serviceOffreEmploi.getOffreEmploi(id);
    
    Object utilisateur = session.getAttribute("utilisateur");
    Candidature candidature = null;
    if(utilisateur instanceof Candidature)
    {
      candidature = (Candidature) utilisateur;
    }
    Entreprise entreprise = null;
    if(utilisateur instanceof Entreprise)
    {
    	entreprise = (Entreprise) utilisateur;
    }

    %>
    <h2>Infos offre d'emploi :</h2>
    
    <%
    if(candidature != null)
    {
    	%>
    	<p>Intéressé par cette offre d'emploi ? <a href="template.jsp?action=nouveau_message_candidature&id_offre=<%=offre.getId()%>">Demande d'entretien</a></p>
    	<%
    }
    if(entreprise != null)
    {
      IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
    	List<Candidature> candidaturesPotentielles = serviceCandidature.listeDesCandidaturesPourUneOffre(offre.getId());
    	if(candidaturesPotentielles.size() > 0)
    	{
        %>
        <p>
          Intéressé par cette(ces) candidature(s) potentielle(s) ?
          <ul>
            <%
            for(Candidature c : candidaturesPotentielles)
            {
            	%>
            	<li>
            	  Demande d'entretien à 
            	  <a href="template.jsp?action=nouveau_message_offre_emploi&id_offre=<%=offre.getId()%>&id_candidature=<%=c.getId()%>">
            	    <%=c.getNom()%> <%=c.getPrenom()%> (CAND_<%=c.getId()%>)
            	  </a>
            	</li>
            	<%
            }
            %>
          </ul>
        </p>
        <%
    	}
    }
    %>
    
    <%
    if(offre == null)
    {
      %>
      <p class="erreur">Erreur : l'offre numéro <%=idString%> n'est pas (<i>plus ?</i>) référencée dans la base.</p>
      <%
    }
    else
    {
      %>
      <table id="affichage">
        <tr>
          <th style="width: 170px;">Numéro de l'offre :</th>
          <td>
            <%=offre.getId()%>
          </td>
        </tr>
        <tr>
          <th>Titre :</th>
          <td>
            <%=offre.getTitre()%>
          </td>
        </tr>
        <tr>
          <th>Entreprise :</th>
          <td>
            <u><%=offre.getEntreprise().getNom()%></u><br/><br/>
            <%=Utils.text2HTML(offre.getEntreprise().getDescriptif())%>
          </td>
        </tr>
        <tr>
          <th>Descriptif de la mission :</th>
          <td>
            <%=Utils.text2HTML(offre.getDescriptifMission())%>
          </td>
        </tr>
        <tr>
          <th>Profil recherché :</th>
          <td>
            <%=Utils.text2HTML(offre.getProfilRecherche())%>
          </td>
        </tr>
        <tr>
          <th>Lieu de la mission :</th>
          <td>
            <%=offre.getEntreprise().getAdressePostale()%>
          </td>
        </tr>
        <tr>
          <th>Niveau de qualification :</th>
          <td>
            <%=offre.getNiveauQualification().getIntitule()%>
          </td>
        </tr>
        <tr>
          <th>Secteur(s) d'activité :</th>
          <td>
            <ul>
             <%
             Set<SecteurActivite> secteursActivite = offre.getSecteursActivite();
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
            <%=Utils.date2String(offre.getDateDepot())%>
          </td>
        </tr>
      </table>
      <%
    }
  }
%>
