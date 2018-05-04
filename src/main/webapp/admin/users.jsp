<%-- 
    Document   : users
    Created on : 05-03-2018, 02:23:28 PM
    Author     : kevin
--%>

<%@page import="com.sv.udb.controllers.UserController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuarios</title>
        <jsp:include page="../WEB-INF/jspf/head.jspf"></jsp:include>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/navadmin.jspf"></jsp:include>
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 content">
                    <h1>Usuarios</h1>
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
                                        <option value="2">Apellido</option>
                                        <option value="3">Email</option>
                                        <option value="4">Tipo de usuario</option>
                                        <option value="5">Estado</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                    <c:choose>
                                        <c:when test="true">
                                            <!--Mostrar con Nombre, Apellido e Email-->
                                            <input type="text" class="form-control" name="filterArg" id="filterArg" value="Esto se muestra al elegir Nombre, Apellido e Email"/>
                                        </c:when>
                                        <c:otherwise>
                                            <!--Mostrar con Tipo de usuario y estado-->
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
                                <div class="col-md-12" style="height: 180px; overflow-y: auto;">
                                    <display:table id="tblMain" name="<%= new UserController().getAll(false)%>">
                                        <display:column title="Cons">
                                            <input type="radio" name="userId" value="${tblMain.id}" onchange="this.form.submit();"/>
                                        </display:column>
                                        <display:column property="name" title="Nombre" sortable="true" />
                                        <display:column property="lastname" title="Apellido" sortable="true" />
                                        <display:column property="email" title="Email" sortable="true" />
                                        <display:column property="user_type" title="Tipo" sortable="true" />
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
                                        <label for="lastname">Apellido</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="lastname" class="text-danger">Error</label>
                                    </c:otherwise>
                                </c:choose>
                                <input type="text" class="form-control" name="lastname" id="lastname" value=""/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="true">
                                        <label for="email">Email:</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="email" class="text-danger">Error</label>
                                    </c:otherwise>
                                </c:choose>
                                <input type="email" class="form-control" name="email" id="email" value=""/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="true">
                                        <label for="pass">Contraseña</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="pass" class="text-danger">Error</label>
                                    </c:otherwise>
                                </c:choose>
                                <input type="password" class="form-control" name="pass" id="pass" value=""/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="true">
                                        <label for="user_type">Tipo de usuario:</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="user_type" class="text-danger">Error</label>
                                    </c:otherwise>
                                </c:choose>
                                <select class="form-control" name="user_type" id="user_type">
                                    <option value="0">Administrador</option>
                                    <option value="1">Personal</option>
                                </select>
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
