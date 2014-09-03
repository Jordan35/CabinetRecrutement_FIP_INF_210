<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>

<%
  Object utilisateur = session.getAttribute("utilisateur");
%>

<h2>Menu administration</h2>
<ul>
  <li>
    Gestion des entreprises
    <ul>
		  <li class="menu"><a href="template.jsp?action=nouvelle_entreprise">Nouvelle entreprise</a></li>
      <li class="menu"><a href="template.jsp?action=liste_entreprises">Liste des entreprises</a></li>
      <li class="menu"><a href="template.jsp?action=liste_offres">Liste de toutes les offres d'emploi</a></li>
    </ul>
  </li>
  <li>
    Gestion des candidatures
    <ul>
      <li class="menu"><a href="template.jsp?action=nouvelle_candidature">Nouvelle candidature</a></li>
      <li class="menu"><a href="template.jsp?action=liste_candidatures">Liste des candidatures</a></li>
    </ul>
  </li>
</ul>

	<%
	  if(session.getAttribute("utilisateur") == null)
	  {
	  	%>
			<hr/>
			<ul>
  	  	<li class="menu"><a href="template.jsp?action=connexion">Connexion</a></li>
  	  </ul>
	  	<%
	  }
	  else
	  {
	    %>
      <hr/>
	    <%
      IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
      if(utilisateur instanceof Entreprise)
      {
      	IServiceEntreprise  serviceEntreprise  = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");

      	Entreprise e = (Entreprise) utilisateur;
        %>
        <h2>Menu entreprise</h2>
	      <ul>
          <li class="menu"><a href="template.jsp?action=maj_entreprise&id_entreprise=<%=e.getId()%>">Mettre à jour les informations de l'entreprise</a></li>
          <li class="menu"><a href="template.jsp?action=nouvelle_offre">Nouvelle offre d'emploi</a></li>
	        <li class="menu"><a href="template.jsp?action=liste_offres&id_entreprise=<%=e.getId()%>">Liste de mes offres d'emploi</a> (<%=serviceOffreEmploi.listeDesOffresPourUneEntreprise(e.getId()).size()%>)</li>
        </ul>
        <ul>
          <li style="list-style-image: url(images/effacement.png)" class="menu"><a href="template.jsp?action=efface_entreprise&id_entreprise=<%=e.getId()%>" onclick="return confirm('Êtes-vous sûr de vouloir retirer votre entreprise et toutes vos offres d\'emploi?\n\nAttention, cette opération n\'est pas réversible !\n\n');">Retirer mon entreprise et toutes mes offres d'emploi</a></li>
        </ul>
	      <hr/>
	      <h2>Menu messages</h2>
	      <ul>
	        <li class="menu"><a href="template.jsp?action=liste_messages_candidature">Messages reçus (<%=serviceEntreprise.listeDesMessagesRecus(e.getId()).size()%>)</a></li>
	        <li class="menu"><a href="template.jsp?action=liste_messages_offre_emploi">Messages envoyés (<%=serviceEntreprise.listeDesMessagesEnvoyes(e.getId()).size()%>)</a></li>
	      </ul>
        <%
      }
      else if(utilisateur instanceof Candidature)
      {
      	IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
      	
        Candidature c = (Candidature) utilisateur;
        %>
        <h2>Menu candidature</h2>
        <ul>
          <li class="menu"><a href="template.jsp?action=maj_candidature&id_candidature=<%=c.getId()%>">Mettre à jour les informations de la candidature</a></li>
	        <li class="menu"><a href="template.jsp?action=liste_offres&id_candidature=<%=c.getId()%>">Lister les offres d'emploi qui correspondent à ma candidature</a> (<%=serviceOffreEmploi.listeDesOffresPourUneCandidature(c.getId()).size()%>)</li>
        </ul>
        <ul>
	        <li style="list-style-image: url(images/effacement.png)" class="menu"><a href="template.jsp?action=efface_candidature&id_candidature=<%=c.getId()%>" onclick="return confirm('Êtes-vous sûr de vouloir retirer votre candidature ?\n\nAttention, cette opération n\'est pas réversible !\n\n');">Retirer ma candidature</a></li>
        </ul>
        <hr/>
        <h2>Menu messages</h2>
        <ul>
          <li class="menu"><a href="template.jsp?action=liste_messages_offre_emploi">Messages reçus (<%=serviceCandidature.listeDesMessagesRecus(c.getId()).size()%>)</a></li>
          <li class="menu"><a href="template.jsp?action=liste_messages_candidature">Messages envoyés (<%=serviceCandidature.listeDesMessagesEnvoyes(c.getId()).size()%>)</a></li>
        </ul>
        <%
      }
	    %>
      <hr/>
	    <ul>
        <li class="menu"><a href="deconnexion.jsp">Déconnexion</a></li>
      </ul>
	    
	    <%
	  }
	%>
<hr/>
