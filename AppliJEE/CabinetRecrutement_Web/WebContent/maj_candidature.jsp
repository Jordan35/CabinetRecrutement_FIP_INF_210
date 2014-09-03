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
  
  int idCandidature = Integer.parseInt(request.getParameter("id_candidature"));
  Candidature candidature = serviceCandidature.getCandidature(idCandidature);


  String nom = request.getParameter("nom");
  if(nom == null) // Pas de param�tre "nom" => affichage du formulaire
  {
  	%>
    <h2>Mettre � jour les informations de la candidature</h2>
    
    <form action="template.jsp" method="get">
      <input type="hidden" name="action" value="maj_candidature" />
      <input type="hidden" name="id_candidature" value="<%=idCandidature%>" />
	  	<table id="affichage">
        <tr>
          <th style="width: 170px;">Identifiant :</th>
          <td>
            <input type="text" size="20" value="CAND_<%=candidature.getId()%>" disabled="disabled">
          </td>
        </tr>
	  	  <tr>
          <th style="width: 170px">Nom :</th>
	        <td>
	          <input type="text" name="nom" size="20" maxlength="50" value="<%=candidature.getNom()%>">
	        </td>
	  	  </tr>
        <tr>
          <th>Pr�nom :</th>
          <td>
            <input type="text" name="prenom" size="20" maxlength="50" value="<%=candidature.getPrenom()%>">
          </td>
        </tr>
        <tr>
          <th>Date de naissance<br/>(format jj/mm/aaaa) :</th>
          <td>
            <input type="text" name="date_naissance" size="10" maxlength="10" value="<%=Utils.date2String(candidature.getDateNaissance())%>">
          </td>
        </tr>
        <tr>
          <th>Adresse postale (ville) :</th>
          <td>
            <input type="text" name="adresse_postale" size="20" maxlength="30"  value="<%=candidature.getAdressePostale()%>">
          </td>
        </tr>
        <tr>
          <th>Adresse email :</th>
          <td>
            <input type="text" name="adresse_email" size="30" maxlength="100"  value="<%=candidature.getAdresseEmail()%>">
          </td>
        </tr>
        <tr>
          <th>Curriculum vit� :</th>
          <td>
            <textarea rows="7" cols="70" name="cv"><%=candidature.getCv()%></textarea>
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
                <input type="radio" name="niveau" value="<%=niveau.getId()%>" <%=(candidature.getNiveauQualification().getId().equals(niveau.getId())?"checked=\"checked\"":"")%>><%=niveau.getIntitule()%><br/>
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
                Set<SecteurActivite> secteursEnregistres = candidature.getSecteursActivite();
                List<Integer> idSecteursEnregistres = new ArrayList<Integer>();
                for(SecteurActivite s : candidature.getSecteursActivite())
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
  	if(nom.equals(""))
  	{
  		%>
  		<p class="erreur">Impossible de r�f�rencer une candidature sans saisir le nom</p>
  		<%
  	}
  	else
  	{
      // R�cup�ration des autres param�tres
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
      
      // R�percution de la mise � jour sur le serveur.
      candidature = serviceCandidature.miseAJour(idCandidature, nom, prenom, dateNaissance, adressePostale, adresseEmail, cv, idNiveau, idsSecteur2);
      
      // Affichage des informations mises � jour.
      %>
      <h2>Informations mises � jour sur la candidature :</h2>
      
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
          <th>Pr�nom :</th>
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
          <th>Curriculum vit� :</th>
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
          <th>Secteur(s) d'activit� :</th>
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
          <th>Date de d�p�t :</th>
          <td>
            <%=Utils.date2String(candidature.getDateDepot())%>
          </td>
        </tr>
      </table>
      <%
  	}
  }
%>
