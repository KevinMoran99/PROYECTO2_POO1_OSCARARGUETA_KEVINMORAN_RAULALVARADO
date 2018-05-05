<%-- 
    Document   : users
    Created on : 05-03-2018, 02:23:28 PM
    Author     : kevin
--%>

<%@page import="com.sv.udb.controllers.ComplaintTypeController"%>
<%@page import="com.sv.udb.controllers.AuthorityController"%>
<%@page import="com.sv.udb.controllers.ProviderController"%>
<%@page import="com.sv.udb.controllers.SchoolController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nueva denuncia</title>
        <jsp:include page="../WEB-INF/jspf/head.jspf"></jsp:include>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/navpersonal.jspf"></jsp:include>
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 content">
                    <h1>Nueva denuncia</h1>
                </div>
            </div>
            <hr>
            <div class="content">
                <form method="POST" action="PrestamoServlet" name="filter">
                    <div class="row">
                        <div class="col-md-6">
                            <label for="school">Escuela desde la que se reporta:</label>
                            <select class="form-control" name="school" id="school">
                                <c:forEach var="schoolItem" items="<%=new SchoolController().getAll(true)%>">
                                    <option value="${schoolItem.getId()}">${schoolItem}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <br>
                            <div class="form-check text-center">
                                <input class="form-check-input big-checkbox" type="checkbox" value="" id="viable" checked>
                                <label class="form-check-label" for="viable">
                                    La denuncia es viable
                                </label>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="true">
                                        <label for="description">Descripción</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="description" class="text-danger">Error</label>
                                    </c:otherwise>
                                </c:choose>
                                <textarea rows="4" cols="50" class="form-control" name="description" id="description" value=""></textarea>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-12">
                            <label for="complaint_type">Tipo de denuncia:</label>
                            <select class="form-control" name="complaint_type" id="complaint_type">
                                <c:forEach var="complaintItem" items="<%=new ComplaintTypeController().getAll(true)%>">
                                    <option value="${complaintItem.getId()}">${complaintItem}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-12">
                            <c:choose>
                                <c:when test="true">
                                    <label for="authority">Autoridades a notificar:</label>
                                    <select class="form-control" name="authority[]" id="authority" multiple="multiple">
                                        <c:forEach var="authorityItem" items="<%=new AuthorityController().getAll(true)%>">
                                            <option value="${authorityItem.getId()}">${authorityItem}</option>
                                        </c:forEach>
                                    </select>
                                </c:when>
                                <c:otherwise>
                                    <label for="provider">Proveedores a notificar:</label>
                                    <select class="form-control" name="provider[]" id="provider" multiple="multiple">
                                        <c:forEach var="providerItem" items="<%=new ProviderController().getAll(true)%>">
                                            <option value="${providerItem.getId()}">${providerItem}</option>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <br>
                    <div class="pull-right">
                        <input type="submit" class="btn" name="formSubmit" value="Limpiar"/>
                        <input type="submit" class="btn btn-primary" name="formSubmit" value="Añadir"/>
                    </div>
                </form>
            </div>
        </div>
        <script>
            $(document).ready(function() {
                $('select').select2();
            });
        </script>
    </body>
</html>
