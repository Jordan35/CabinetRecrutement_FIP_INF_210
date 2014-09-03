<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidature,
                eu.telecom_bretagne.cabinet_recrutement.data.model.Candidature"%>

<%
	IServiceCandidature serviceCandidature = (IServiceCandidature) ServicesLocator.getInstance().getRemoteInterface("ServiceCandidature");
  int idCandidature = Integer.parseInt(request.getParameter("id_candidature"));
  Candidature candidature = serviceCandidature.getCandidature(idCandidature);
  serviceCandidature.effaceCandidature(idCandidature);
  session.invalidate();
%>

<h2>La candidature de "<%=candidature.getNom()%> <%=candidature.getPrenom()%>" (identifiant=CAND_<%=candidature.getId()%>) a été effacée.</h2>