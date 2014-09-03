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
  
  int idOffre = Integer.parseInt(request.getParameter("id_offre"));
  OffreEmploi offre = serviceOffreEmploi.getOffreEmploi(idOffre);

  String titre = request.getParameter("titre");
  if(titre == null) // Pas de param�tre "nom" => affichage du formulaire
  {
%>
    <h2>Mettre � jour les informations de l'offre d'emploi</h2>
    
    <form action="template.jsp" method="get">
      <input type="hidden" name="action" value="maj_offre" />
      <input type="hidden" name="id_offre" value="<%=idOffre%>" />
	  	<table id="affichage">
        <tr>
          <th style="width: 170px;">Id :</th>
          <td>
            <input type="text" size="20" value="<%=offre.getId()%>" disabled="disabled">
          </td>
        </tr>
	  	  <tr>
          <th>Titre de l'offre :</th>
	        <td>
	          <input type="text" name="titre" size="20" maxlength="50" value="<%=offre.getTitre()%>">
	        </td>
	  	  </tr>
	      <tr>
          <th>Descriptif de la mission :</th>
	        <td>
	          <textarea rows="7" cols="70" name="descriptif_mission"><%=offre.getDescriptifMission()%></textarea>
	        </td>
	      </tr>
        <tr>
          <th>Profil recherch� :</th>
          <td>
            <textarea rows="7" cols="70" name="profil_recherche"><%=offre.getProfilRecherche()%></textarea>
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
	            	  <input type="radio" name="niveau" value="<%=niveau.getId()%>" <%=(offre.getNiveauQualification().getId().equals(niveau.getId())?"checked=\"checked\"":"")%>><%=niveau.getIntitule()%><br/>
	            	  <%
	            	}
	            	%>
            </td></tr></table>
          </td>
        </tr>
        <tr>
          <th>Secteur(s) d'activit� :</th>
          <td>
            <table id="tab_interne">
              <tr>
                <%
                Set<SecteurActivite> secteursEnregistres = offre.getSecteursActivite();
                List<Integer> idSecteursEnregistres = new ArrayList<Integer>();
                for(SecteurActivite s : offre.getSecteursActivite())
                {
                	idSecteursEnregistres.add(s.getId());
                }

                	for(int i=0; i<3; i++)
                  {
                	  SecteurActivite secteur = secteurs.get(i);
                    %>
                    <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>" <%=(idSecteursEnregistres.contains(secteur.getId())?"checked=\"checked\"":"")%>><%=secteur.getIntitule()%></td>
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
                    <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>" <%=(idSecteursEnregistres.contains(secteur.getId())?"checked=\"checked\"":"")%>><%=secteur.getIntitule()%></td>
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
                    <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>" <%=(idSecteursEnregistres.contains(secteur.getId())?"checked=\"checked\"":"")%>><%=secteur.getIntitule()%></td>
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
                    <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>" <%=(idSecteursEnregistres.contains(secteur.getId())?"checked=\"checked\"":"")%>><%=secteur.getIntitule()%></td>
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
                    <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>" <%=(idSecteursEnregistres.contains(secteur.getId())?"checked=\"checked\"":"")%>><%=secteur.getIntitule()%></td>
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
                    <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>" <%=(idSecteursEnregistres.contains(secteur.getId())?"checked=\"checked\"":"")%>><%=secteur.getIntitule()%></td>
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
                    <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>" <%=(idSecteursEnregistres.contains(secteur.getId())?"checked=\"checked\"":"")%>><%=secteur.getIntitule()%></td>
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
                    <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>" <%=(idSecteursEnregistres.contains(secteur.getId())?"checked=\"checked\"":"")%>><%=secteur.getIntitule()%></td>
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
                    <td><input type="checkbox" name="secteur" value="<%=secteur.getId()%>" <%=(idSecteursEnregistres.contains(secteur.getId())?"checked=\"checked\"":"")%>><%=secteur.getIntitule()%></td>
                    <%
                  }
                  %>
              </tr>
            </table>
          </td>
        </tr>
	  	</table>
		  <p>
		    <input type="submit" value="Mettre � jour"/>
		  </p>
		</form>
  	<%
  		}
  	  else                    // Param�tre "titre" existant => stockage des donn�es et affichage du r�sultat
  	  {
  	  	if(titre.equals(""))
  	  	{
  	%>
  		<p class="erreur">Impossible de r�f�rencer une offre d'emploi sans saisir le titre</p>
  		<%
  			}
  		  	else
  		  	{
  		      // R�cup�ration des autres param�tres
  		      String   descriptifMission = request.getParameter("descriptif_mission");
  		      String   profilRecherche   = request.getParameter("profil_recherche");
  		      int      idNiveau          = Integer.parseInt(request.getParameter("niveau"));
  		      String[] idsSecteur        = request.getParameterValues("secteur");
            List<Integer> idsSecteur2 = new ArrayList<Integer>();
            for(String id : idsSecteur)
            {
              idsSecteur2.add(Integer.parseInt(id));
            }
  		      
            // R�percution de la mise � jour sur le serveur.
            offre = serviceOffreEmploi.miseAJour(idOffre, titre, descriptifMission, profilRecherche, idNiveau, idsSecteur2);
            
            // Affichage des informations mises � jour.
  		%>
      <h2>Informations mises � jour sur l'offre d'emploi :</h2>
      
      <table id="affichage">
        <tr>
          <th style="width: 170px">Num�ro de l'offre :</th>
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
          <th>Profil recherch� :</th>
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
          <th>Secteur(s) d'activit� :</th>
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
          <th>Date de d�p�t :</th>
          <td>
            <%=Utils.date2String(offre.getDateDepot())%>
          </td>
        </tr>
      </table>
      <%
  	}
  }
%>
