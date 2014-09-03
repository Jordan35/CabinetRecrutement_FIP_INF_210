<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi,
                eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi"%>

<%
	IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
  int idOffre = Integer.parseInt(request.getParameter("id_offre"));
  OffreEmploi offre = serviceOffreEmploi.getOffreEmploi(idOffre);
  serviceOffreEmploi.effaceOffre(idOffre);
%>

<h2>L'offre "<%=offre.getTitre()%>" (id=<%=offre.getId()%>) a été effacée.</h2>