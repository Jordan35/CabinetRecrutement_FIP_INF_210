<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise"%>

<%
	IServiceEntreprise serviceEntreprise = (IServiceEntreprise) ServicesLocator.getInstance().getRemoteInterface("ServiceEntreprise");
  int idEntreprise = Integer.parseInt(request.getParameter("id_entreprise"));
  Entreprise entreprise = serviceEntreprise.getEntreprise(idEntreprise);
  serviceEntreprise.effaceEntreprise(idEntreprise);
  session.invalidate();
%>

<h2>L'entreprise "<%=entreprise.getNom()%>" (identifiant=ENT_<%=entreprise.getId()%>) a été effacée.</h2>