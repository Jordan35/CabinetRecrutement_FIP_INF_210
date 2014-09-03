<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise"%>

<%
  String idString = request.getParameter("id");
  if(idString == null)
  {
    %>
    <p class="erreur">Erreur : il n'y a aucune entreprise qui corresponde à cette recherche.</p>
    <%
  }
  else
  {
    IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
    int id = Integer.parseInt(idString);
    Entreprise entreprise = serviceEntreprise.getEntreprise(id);
    %>
    <h2>Infos entreprise :</h2>
    
    <table id="affichage">
      <tr>
        <th style="width: 170px;">Identifiant :</th>
        <td>
          ENT_<%=entreprise.getId()%>
        </td>
      </tr>
      <tr>
        <th>Nom :</th>
        <td>
          <%=entreprise.getNom()%>
        </td>
      </tr>
      <tr>
        <th>Descriptif :</th>
        <td>
          <%=Utils.text2HTML(entreprise.getDescriptif())%>
        </td>
      </tr>
      <tr>
        <th>Adresse postale (ville) :</th>
        <td>
          <%=entreprise.getAdressePostale()%>
        </td>
      </tr>
    </table>
    <%
  }
%>
