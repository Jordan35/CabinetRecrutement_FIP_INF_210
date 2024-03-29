<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise"%>

<%
  String nom = request.getParameter("nom");
  if(nom == null) // Pas de param�tre "nom" => affichage du formulaire
  {
  	%>
    <h2>R�f�rencer une nouvelle entreprise</h2>
    
    <form action="template.jsp" method="get">
      <input type="hidden" name="action" value="nouvelle_entreprise" />
	  	<table id="affichage">
	  	  <tr>
          <th style="width: 170px;">Nom :</th>
	        <td>
	          <input type="text" name="nom" size="20" maxlength="50">
	        </td>
	  	  </tr>
	      <tr>
          <th>Descriptif :</th>
	        <td>
	          <textarea rows="7" cols="70" name="descriptif"></textarea>
	        </td>
	      </tr>
	      <tr>
          <th>Adresse postale (ville) :</th>
	        <td>
	          <input type="text" name="adresse_postale" size="20" maxlength="30">
	        </td>
	      </tr>
	  	</table>
		  <p>
		    <input type="submit" value="Enregistrer"/>
		  </p>
		</form>
  	<%
  }
  else                    // Param�tre "nom" existant => stockage des donn�es et affichage du r�sultat
  {
  	if(nom.equals(""))
  	{
  		%>
  		<p class="erreur">Impossible de r�f�rencer une entreprise sans saisir le nom</p>
  		<%
  	}
  	else
  	{
      // R�cup�ration des autres param�tres
      String descriptif     = request.getParameter("descriptif");
      String adressePostale = request.getParameter("adresse_postale");

      IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
      Entreprise entreprise = serviceEntreprise.nouvelleEntreprise(nom,descriptif,adressePostale);

      %>
      <h2>Nouvelle entreprise r�f�renc�e :</h2>
      
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
  }
%>
