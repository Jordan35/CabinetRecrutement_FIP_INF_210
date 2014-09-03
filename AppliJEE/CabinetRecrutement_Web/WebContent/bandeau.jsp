<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>

<%
  Object utilisateur = session.getAttribute("utilisateur");
%>

<h1>
	<%
	  if(utilisateur == null)
	  {
	    %>
	    Non connecté
	    <%
	  }
	  else
	  {
	  	if(utilisateur instanceof Entreprise)
	  	{
	  		Entreprise e = (Entreprise) utilisateur;
        %>
	  		Entreprise : <i><%=e.getNom()%></i>
        <%
	  	}
	  	else if(utilisateur instanceof Candidature)
	  	{
	  		Candidature c = (Candidature) utilisateur;
	      %>
	      Candidature : <i><%=c.getNom()%> <%=c.getPrenom()%></i>
	      <%
	  	}
	  }
	%>
</h1>