<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="java.util.Date,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature"%>

<%
  int idOffre = Integer.parseInt(request.getParameter("id_offre"));
  String action2 = request.getParameter("action2");

  IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
  OffreEmploi offre = serviceOffreEmploi.getOffreEmploi(idOffre);


  if(action2 == null) // Pas de paramètre "action2" => affichage du formulaire
  {
  	%>
    <h2>Demande d'entretien</h2>
    
    <p>
      Offre concernée :
      <ul>
        <li>Entreprise : <%=offre.getEntreprise().getNom()%></li>
        <li>Titre : <%=offre.getTitre()%></li>
      </ul>
    </p>
    
    <form action="template.jsp" method="get">
      <input type="hidden" name="action" value="nouveau_message_candidature" />
      <input type="hidden" name="action2" value="enregistrer" />
      <input type="hidden" name="id_offre" value="<%=idOffre%>" />
	  	<table id="affichage">
	      <tr>
          <th>Message :</th>
	        <td>
	          <textarea rows="7" cols="70" name="corps_message"></textarea>
	        </td>
	      </tr>
	  	</table>
		  <p>
		    <input type="submit" value="Envoyer"/>
		  </p>
		</form>
  	<%
  }
  else                    // Paramètre "action2" existant => stockage des données du message et affichage du résultat
  {
		// Récupération des autres paramètres
		String corpsMessage = request.getParameter("corps_message");
		
    Object utilisateur = session.getAttribute("utilisateur");
    Candidature candidature = null;
    if(utilisateur instanceof Candidature)
    {
      candidature = (Candidature) utilisateur;
    }

		IServiceMessageCandidature serviceMessageCandidature = (IServiceMessageCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageCandidature");
		MessageCandidature message = serviceMessageCandidature.nouveauMessageCandidature(candidature.getId(),
				                                                                             idOffre,
				                                                                             new Date(),
				                                                                             corpsMessage);
		%>
		<h2>Nouveau message enregistré :</h2>
		
		<table id="affichage">
		  <tr>
		    <th style="width: 170px;">Id :</th>
		    <td><%=message.getId()%></td>
		  </tr>
      <tr>
        <th>Candidature :</th>
        <td><%=message.getCandidature().getNom()%> <%=message.getCandidature().getPrenom()%> (CAND_<%=message.getCandidature().getId()%>)</td>
      </tr>
      <tr>
        <th>Offre emploi concernée :</th>
        <td><%=message.getOffreEmploi().getTitre()%> (<%=message.getOffreEmploi().getEntreprise().getNom()%>)</td>
      </tr>
      <tr>
        <th>Date d'envoi :</th>
        <td><%=Utils.date2String(message.getDateEnvoi())%></td>
      </tr>
		  <tr>
		    <th>Corps du message :</th>
		    <td>
		      <%=Utils.text2HTML(message.getCorps())%>
		    </td>
		  </tr>
		</table>
		<%
		}
%>
