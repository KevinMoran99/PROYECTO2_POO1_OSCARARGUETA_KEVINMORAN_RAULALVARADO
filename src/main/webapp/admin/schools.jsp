<%-- 
    Document   : users
    Created on : 05-03-2018, 02:23:28 PM
    Author     : kevin
--%>

<%@page import="com.sv.udb.models.User"%>
<%@page import="com.sv.udb.controllers.SchoolController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>

<%
    User p =(User)(request.getSession().getAttribute("session"));
    if(p==null){
        response.sendRedirect("/PROYECTO2_POO1_OSCARARGUETA_KEVINMORAN_RAULALVARADO");
    }else{
        if(p.getUser_type().getId() !=1){
            response.sendRedirect("/PROYECTO2_POO1_OSCARARGUETA_KEVINMORAN_RAULALVARADO/personal/calls.jsp");
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Escuelas</title>
        <jsp:include page="../WEB-INF/jspf/head.jsp"></jsp:include>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/navadmin.jsp"></jsp:include>
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 content">
                    <h1>Escuelas</h1>
                </div>
            </div>
            <hr>
            <div class="content">
                <div class="row">
                    <div class="col-md-12 content">
                        <form method="POST" action="PrestamoServlet" name="filter">
                            <div class="row">
                                <div class="col-md-3 text-right">Buscar por:</div>
                                <div class="col-md-3">
                                    <select class="form-control" name="filterType" id="filterType">
                                        <option value="0">N/A</option>
                                        <option value="1">Nombre</option>
                                        <option value="2">Dirección</option>
                                        <option value="3">Estado</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                    <c:choose>
                                        <c:when test="true">
                                            <!--Mostrar con Nombre y Dirección-->
                                            <input type="text" class="form-control" name="filterArg" id="filterArg" value="Esto se muestra al elegir Nombre o Dirección"/>
                                        </c:when>
                                        <c:otherwise>
                                            <!--Mostrar con Acción tomada y estado-->
                                            <select class="form-control" name="filterArg" id="filterArg">
                                                <option value="0">Activo</option>
                                                <option value="1">Inactivo</option>
                                            </select>
                                        </c:otherwise>
                                    </c:choose>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <input type="submit" class="btn" name="filterBtn" value="Buscar"/>
                                </div>
                            </div>
                        </form>
                        <form method="POST" action="PrestamoServlet" name="Tabl">
                            <div class="row">
                                <div class="col-md-12" style="height: 195px; overflow-y: auto;">
                                    <display:table id="tblMain" name="<%= new SchoolController().getAll(false)%>">
                                        <display:column title="Cons">
                                            <input type="radio" name="userId" value="${tblMain.id}" onchange="this.form.submit();"/>
                                        </display:column>
                                        <display:column property="name" title="Nombre" sortable="true" />
                                        <display:column property="address" title="Dirección" sortable="true" />
                                        <display:column title="Estado" sortable="true">
                                            <c:choose><c:when test="${tblMain.state}">Activo</c:when><c:otherwise>Inactivo</c:otherwise></c:choose>
                                        </display:column>
                                    </display:table>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <form method="POST" action="WarehouseServ" name="Demo">
                    <input type="hidden" name="id" id="id" value=""/>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="true">
                                        <label for="name">Nombre:</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="name" class="text-danger">Error</label>
                                    </c:otherwise>
                                </c:choose>
                                <input type="text" class="form-control" name="name" id="name" value=""/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="true">
                                        <label for="state">Estado</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="state" class="text-danger">Error</label>
                                    </c:otherwise>
                                </c:choose>
                                <select class="form-control" name="state" id="state">
                                    <option value="0">Activo</option>
                                    <option value="1">Inactivo</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="true">
                                        <label for="address">Dirección</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="address" class="text-danger">Error</label>
                                    </c:otherwise>
                                </c:choose>
                                <textarea rows="4" cols="50" class="form-control" name="address" id="address" value=""></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="pull-right">
                        <input type="submit" class="btn" name="formSubmit" value="Limpiar"/>
                        <c:choose>
                            <c:when test="true">
                                <input type="submit" class="btn btn-primary" name="formSubmit" value="Añadir"/>
                            </c:when>
                            <c:otherwise>
                                <input type="submit" class="btn btn-primary" name="formSubmit" value="Modificar"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
