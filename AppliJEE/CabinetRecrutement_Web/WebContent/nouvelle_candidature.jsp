<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="java.util.List,
                java.util.Set,
                java.util.ArrayList,
                java.util.Date,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceIndexation,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.NiveauQualification,
                eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite"%>

<%
  IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  IServiceIndexation serviceIndexation = (IServiceIndexation) ServicesLocator.getInstance().getRemoteInterface("ServiceIndexation");
  List<NiveauQualification> niveaux = serviceIndexation.listeNiveauxQualification();
  List<SecteurActivite> secteurs = serviceIndexation.listeSecteursActivite();
  

  String nom = request.getParameter("nom");
  if(nom == null) // Pas de paramètre "nom" => affichage du formulaire
  {
  	%>
    <h2>Référencer une nouvelle candidature</h2>
    
    <form action="template.jsp" method="get">
      <input type="hidden" name="action" value="nouvelle_candidature" />
	  	<table id="affichage">
	  	  <tr>
          <th style="width: 170px">Nom :</th>
	        <td>
	          <input type="text" name="nom" size="20" maxlength="50">
	        </td>
	  	  </tr>
        <tr>
          <th>Prénom :</th>
          <td>
            <input type="text" name="prenom" size="20" maxlength="50">
          </td>
        </tr>
        <tr>
          <th>Date de naissance<br/>(format jj/mm/aaaa) :</th>
          <td>
            <input type="text" name="date_naissance" size="10" maxlength="10">
          </td>
        </tr>
        <tr>
          <th>Adresse postale (ville) :</th>
          <td>
            <input type="text" name="adresse_postale" size="20" maxlength="30">
          </td>
        </tr>
        <tr>
          <th>Adresse email :</th>
          <td>
            <input type="text" name="adresse_email" size="30" maxlength="100">
          </td>
        </tr>
        <tr>
          <th>Curriculum vitæ :</th>
          <td>
            <textarea rows="7" cols="70" name="cv"></textarea>
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
  	if(nom.equals(""))
  	{
  		%>
  		<p class="erreur">Impossible de référencer une candidature sans saisir le nom</p>
  		<%
  	}
  	else
  	{
      // Récupération des autres paramètres
      String   prenom         = request.getParameter("prenom");
      Date     dateNaissance  = Utils.string2Date(request.getParameter("date_naissance"));
      String   adressePostale = request.getParameter("adresse_postale");
      String   adresseEmail   = request.getParameter("adresse_email");
      String   cv             = request.getParameter("cv");
      int      idNiveau       = Integer.parseInt(request.getParameter("niveau"));
      String[] idsSecteur     = request.getParameterValues("secteur");
      
      List<Integer> idsSecteur2 = new ArrayList<Integer>();
      for(String id : idsSecteur)
      {
      	idsSecteur2.add(Integer.parseInt(id));
      }
      
      Candidature candidature = serviceCandidature.nouvelleCandidature(nom, prenom,dateNaissance,
      		                                                             adressePostale, adresseEmail,
      		                                                             cv, new Date(),
      		                                                             idNiveau,
      		                                                             idsSecteur2);
      %>
      <h2>Nouvelle candidature référencée :</h2>
      
      <table id="affichage">
        <tr>
          <th style="width: 170px;">Identifiant :</th>
          <td>
            CAND_<%=candidature.getId()%>
          </td>
        </tr>
        <tr>
          <th>Nom :</th>
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
