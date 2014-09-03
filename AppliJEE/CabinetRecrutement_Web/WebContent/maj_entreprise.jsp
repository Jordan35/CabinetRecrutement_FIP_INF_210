<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise"%>

<%
  IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");

  int idEntreprise = Integer.parseInt(request.getParameter("id_entreprise"));
  Entreprise entreprise = serviceEntreprise.getEntreprise(idEntreprise);

  String nom = request.getParameter("nom");
  if(nom == null) // Pas de param�tre "nom" => affichage du formulaire
  {
  	%>
    <h2>Mettre � jour les informations de l'entreprise</h2>
    
    <form action="template.jsp" method="get">
      <input type="hidden" name="action" value="maj_entreprise" />
      <input type="hidden" name="id_entreprise" value="<%=idEntreprise%>" />
	  	<table id="affichage">
        <tr>
          <th style="width: 170px;">Identifiant :</th>
          <td>
            <input type="text" size="20" value="ENT_<%=entreprise.getId()%>" disabled="disabled">
          </td>
        </tr>
	  	  <tr>
          <th>Nom :</th>
	        <td>
	          <input type="text" name="nom" size="20" maxlength="50" value="<%=entreprise.getNom()%>">
	        </td>
	  	  </tr>
	      <tr>
          <th>Descriptif :</th>
	        <td>
	          <textarea rows="7" cols="70" name="descriptif"><%=entreprise.getDescriptif()%></textarea>
	        </td>
	      </tr>
	      <tr>
          <th>Adresse postale (ville) :</th>
	        <td>
	          <input type="text" name="adresse_postale" size="20" maxlength="30" value="<%=entreprise.getAdressePostale()%>">
	        </td>
	      </tr>
	  	</table>
		  <p>
		    <input type="submit" value="Mettre � jour"/>
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
      
      // R�percution de la mise � jour sur le serveur.
      entreprise = serviceEntreprise.miseAJour(idEntreprise, nom, descriptif, adressePostale);
      
      // Affichage des informations mises � jour.
      %>
      <h2>Informations mises � jour sur l'entreprise :</h2>
      
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
