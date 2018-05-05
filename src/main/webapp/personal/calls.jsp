<%-- 
    Document   : calls
    Created on : 05-04-2018, 10:36:13 PM
    Author     : kevin
--%>

<%@page import="com.sv.udb.controllers.CallController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de denuncias</title>
        <jsp:include page="../WEB-INF/jspf/head.jspf"></jsp:include>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/navpersonal.jspf"></jsp:include>
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 content">
                    <h1>Lista de denuncias</h1>
                </div>
            </div>
            <hr>
            <div class="content">
                <form method="POST" action="PrestamoServlet" name="filter">
                    <div class="row">
                        <div class="col-md-3 text-right">Buscar por:</div>
                        <div class="col-md-3">
                            <select class="form-control" name="filterType" id="filterType">
                                <option value="0">N/A</option>
                                <option value="1">Escuela</option>
                                <option value="2">Tipo</option>
                                <option value="3">Descripción</option>
                                <option value="4">Viable</option>
                                <option value="5">Registradas por mí</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                            <c:choose>
                                <c:when test="true">
                                    <!--Mostrar con Descripción-->
                                    <input type="text" class="form-control" name="filterArg" id="filterArg"/>
                                </c:when>
                                <c:otherwise>
                                    <!--Mostrar con Escuela, Tipo y Viable-->
                                    <select class="form-control" name="filterArg" id="filterArg">
                                        <option value="0">Es viable</option>
                                        <option value="1">No es viable</option>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 text-right">Fecha:</div>
                        <div class="col-md-3">
                            <input type="date" class="form-control" name="filterFrom" id="filterFrom"/>
                        </div>
                        <div class="col-md-3">
                            <input type="date" class="form-control" name="filterTo" id="filterArg"/>
                        </div>
                        <div class="col-md-3">
                            <input type="submit" class="btn" name="filterBtn" value="Buscar"/>
                        </div>
                    </div>
                </form>
                <br>
                <form method="POST" action="PrestamoServlet" name="Tabl">
                    <div class="row">
                        <div class="col-md-12" style="height: 180px; overflow-y: auto;">
                            <display:table id="tblMain" name="<%= new CallController().getAll()%>">
                                <display:column title="Ver detalle">
                                    <input type="radio" name="callId" value="${tblMain.id}" onchange="this.form.submit();"/>
                                </display:column>
                                <display:column property="school" title="Escuela" sortable="true" />
                                <display:column property="complaint_type" title="Tipo" sortable="true" />
                                <display:column property="description" title="Descripción" sortable="true" />
                                <display:column title="Viable" sortable="true">
                                    <c:choose><c:when test="${tblMain.viable}">Es viable</c:when><c:otherwise>No es viable</c:otherwise></c:choose>
                                </display:column>
                                <display:column property="call_date" title="Fecha" sortable="true" format="{0,date,dd/MM/yyyy}" />
                            </display:table>
                        </div>
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
