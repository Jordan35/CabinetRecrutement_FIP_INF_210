<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="java.util.List,
                java.util.Set,
                java.util.ArrayList,
                java.util.Date,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceIndexation,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>

<%
	IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
  IServiceIndexation serviceIndexation = (IServiceIndexation) ServicesLocator.getInstance().getRemoteInterface("ServiceIndexation");
  List<NiveauQualification> niveaux = serviceIndexation.listeNiveauxQualification();
  List<SecteurActivite> secteurs = serviceIndexation.listeSecteursActivite();
  

  String titre = request.getParameter("titre");
  if(titre == null) // Pas de paramètre "nom" => affichage du formulaire
  {
%>
    <h2>Référencer une nouvelle offre d'emploi</h2>
    
    <form action="template.jsp" method="get">
      <input type="hidden" name="action" value="nouvelle_offre" />
	  	<table id="affichage">
	  	  <tr>
          <th style="width: 170px">Titre de l'offre :</th>
	        <td>
	          <input type="text" name="titre" size="20" maxlength="50">
	        </td>
	  	  </tr>
	      <tr>
          <th>Descriptif de la mission :</th>
	        <td>
	          <textarea rows="7" cols="70" name="descriptif_mission"></textarea>
	        </td>
	      </tr>
        <tr>
          <th>Profil recherché :</th>
          <td>
            <textarea rows="7" cols="70" name="profil_recherche"></textarea>
          </td>
        </tr>
        <tr>
          <th>Niveau de qualification :</th>
          <td>
            <table id="tab_interne"><tr><td>
	            <%
	            	for(NiveauQualification niveau : niveaux)
	            	{
	                %>
	            	  <input type="radio" name="niveau" value="<%=niveau.getId()%>"><%=niveau.getIntitule()%><br/>
	            	  <%
	            	}
	            	%>
            </td></tr></table>
          </td>
        </tr>
        <tr>
          <th>Secteur(s) d'activité :</th>
          <td>
            <table id="tab_interne">
              <tr>
                <%
                	for(int i=0; i<3; i++)
                  {
                	  SecteurActivite secteur = secteurs.get(i);
                    %>
                  <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>"><%=secteur.getIntitule()%></td>
                  <%
                  	}
                  %>
              </tr>
              <tr>
                <%
                	for(int i=3; i<6; i++)
                                {
                                  SecteurActivite secteur = secteurs.get(i);
                %>
                  <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>"><%=secteur.getIntitule()%></td>
                  <%
                  	}
                  %>
              </tr>
              <tr>
                <%
                	for(int i=6; i<9; i++)
                                {
                                  SecteurActivite secteur = secteurs.get(i);
                %>
                  <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>"><%=secteur.getIntitule()%></td>
                  <%
                  	}
                  %>
              </tr>
              <tr>
                <%
                	for(int i=9; i<12; i++)
                                {
                                  SecteurActivite secteur = secteurs.get(i);
                %>
                  <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>"><%=secteur.getIntitule()%></td>
                  <%
                  	}
                  %>
              </tr>
              <tr>
                <%
                	for(int i=12; i<15; i++)
                                {
                                  SecteurActivite secteur = secteurs.get(i);
                %>
                  <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>"><%=secteur.getIntitule()%></td>
                  <%
                  	}
                  %>
              </tr>
              <tr>
                <%
                	for(int i=15; i<18; i++)
                                {
                                  SecteurActivite secteur = secteurs.get(i);
                %>
                  <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>"><%=secteur.getIntitule()%></td>
                  <%
                  	}
                  %>
              </tr>
              <tr>
                <%
                	for(int i=18; i<21; i++)
                                {
                                  SecteurActivite secteur = secteurs.get(i);
                %>
                  <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>"><%=secteur.getIntitule()%></td>
                  <%
                  	}
                  %>
              </tr>
              <tr>
                <%
                	for(int i=21; i<24; i++)
                                {
                                  SecteurActivite secteur = secteurs.get(i);
                %>
                  <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>"><%=secteur.getIntitule()%></td>
                  <%
                  	}
                  %>
              </tr>
              <tr>
                <%
                	for(int i=24; i<25; i++)
                                {
                                  SecteurActivite secteur = secteurs.get(i);
                %>
                  <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>"><%=secteur.getIntitule()%></td>
                  <%
                  	}
                  %>
              </tr>
            </table>
          </td>
        </tr>
	  	</table>
		  <p>
		    <input type="submit" value="Enregistrer"/>
		  </p>
		</form>
  	<%
  		}
  	  else                    // Paramètre "titre" existant => stockage des données et affichage du résultat
  	  {
  	  	if(titre.equals(""))
  	  	{
  	%>
  		<p class="erreur">Impossible de référencer une offre d'emploi sans saisir le titre</p>
  		<%
  			}
  		  	else
  		  	{
  		      // Récupération des autres paramètres
  		      String   descriptifMission = request.getParameter("descriptif_mission");
  		      String   profilRecherche   = request.getParameter("profil_recherche");
  		      int      idNiveau          = Integer.parseInt(request.getParameter("niveau"));
  		      String[] idsSecteur        = request.getParameterValues("secteur");
  		      
  		      List<Integer> idsSecteur2 = new ArrayList<Integer>();
  		      for(String id : idsSecteur)
  		      {
  		      	idsSecteur2.add(Integer.parseInt(id));
  		      }

  		      OffreEmploi offre = serviceOffreEmploi.nouvelleOffre(titre,
  		      		                                                 descriptifMission,
  		      		                                                 profilRecherche,
  		      		                                                 new Date(),
  		      		                                                 ((Entreprise) session.getAttribute("utilisateur")).getId(),
  		      		                                                 idNiveau,
  		      		                                                 idsSecteur2);
  		%>
      <h2>Nouvelle offre d'emploi référencée :</h2>
      
      <table id="affichage">
        <tr>
          <th style="width: 170px">Numéro de l'offre :</th>
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
