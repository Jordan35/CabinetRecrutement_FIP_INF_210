<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreEmploi"%>
<%@page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageOffreEmploi"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="java.util.Date,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceMessageCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature"%>

<%
  int    idOffre       = Integer.parseInt(request.getParameter("id_offre"));
  int    idCandidature = Integer.parseInt(request.getParameter("id_candidature"));
  String action2       = request.getParameter("action2");

  IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  Candidature candidature = serviceCandidature.getCandidature(idCandidature);

  if(action2 == null) // Pas de paramètre "action2" => affichage du formulaire
  {
  	%>
    <h2>Demande d'entretien</h2>
    
    <p>
      Candidature concernée :
      <ul>
        <li>Nom : <%=candidature.getNom()%> <%=candidature.getNom()%></li>
      </ul>
    </p>
    
    <form action="template.jsp" method="get">
      <input type="hidden" name="action" value="nouveau_message_offre_emploi" />
      <input type="hidden" name="action2" value="enregistrer" />
      <input type="hidden" name="id_offre" value="<%=idOffre%>" />
      <input type="hidden" name="id_candidature" value="<%=idCandidature%>" />
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
		
		IServiceMessageOffreEmploi serviceMessageOffreEmploi = (IServiceMessageOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceMessageOffreEmploi");
		MessageOffreEmploi message = serviceMessageOffreEmploi.nouveauMessageOffreEmploi(idOffre,
				                                                                             idCandidature,
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
        <th>Offre emploi concernée :</th>
        <td><%=message.getOffreEmploi().getTitre()%> (<%=message.getOffreEmploi().getEntreprise().getNom()%>)</td>
      </tr>
      <tr>
        <th>Candidature :</th>
        <td><%=message.getCandidature().getNom()%> <%=message.getCandidature().getPrenom()%> (CAND_<%=message.getCandidature().getId()%>)</td>
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
