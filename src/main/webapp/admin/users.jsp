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
                        <form method="POST" action="AdminUsersServlet" name="Tabl">
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
                <form method="POST" action="AdminUsersServlet" name="Demo">
                    <input type="hidden" name="id" id="id" value="${id}"/>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="${nameE == null}">
                                        <label for="name">Nombre:</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="name" class="text-danger">${nameE}</label>
                                    </c:otherwise>
                                </c:choose>
                                     <input type="text" required class="form-control" name="name" id="name" value="${name}" minlength="2"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="${lastnameE == null}">
                                        <label for="lastname">Apellidos</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="lastname" class="text-danger">${lastnameE}</label>
                                    </c:otherwise>
                                </c:choose>
                                <input type="text" required class="form-control" name="lastname" id="lastname" value="${lastname}" minlength="2"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="${emailE == null}">
                                        <label for="email">Email:</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="email" class="text-danger">${emailE}</label>
                                    </c:otherwise>
                                </c:choose>
                                        <input type="email" class="form-control" name="email" id="email" value="${email}" required minlength="7"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="${passE == null}">
                                        <label for="pass">Contraseña</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="pass" class="text-danger">${passE}</label>
                                    </c:otherwise>
                                </c:choose>
                                    <c:choose>
                                        <c:when test="${mode == 'add'}">
                                            <input type="password" class="form-control" name="pass" id="pass" value="" required minlength="7"/>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="password" class="form-control" name="pass" id="pass" value="" minlength="7"/>
                                        </c:otherwise>
                                    </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="${typeE == null}">
                                        <label for="user_type">Tipo de usuario:</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="user_type" class="text-danger">${typeE}</label>
                                    </c:otherwise>
                                </c:choose>
                                <select class="form-control" name="user_type" id="user_type" required>
                                    <c:choose>
                                        <c:when test="${user_type == 1}">
                                            <option value="1" selected>Administrador</option>
                                            <option value="2">Personal</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="1">Administrador</option>
                                            <option value="2" selected>Personal</option>
                                        </c:otherwise>    
                                    </c:choose>
                                    
                                    
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="${stateE == null}">
                                        <label for="state">Estado</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="state" class="text-danger">${stateE}</label>
                                    </c:otherwise>
                                </c:choose>
                                <select class="form-control" name="state" id="state" required>
                                    <c:choose>
                                        <c:when test="${state == 0}">
                                            <option value="0" selected>Inactivo</option>
                                            <option value="1">Activo</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0">Inactivo</option>
                                            <option value="1" selected>Activo</option>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="pull-right">
                        <c:choose>
                            <c:when test="${mode == 'add'}">
                                <input type="submit" class="btn btn-primary" name="formSubmit" value="Agregar"/>
                            </c:when>
                            <c:otherwise>
                                <input type="submit" class="btn btn-primary" name="formSubmit" value="Modificar"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </form>
                            <form method="POST" action="AdminUsersServlet">
                                <div class="pill-right">
                                    <input type="submit" class="btn" name="formSubmit" value="Limpiar"/>
                                </div>
                            </form>
            </div>
        </div>
    </body>
</html>
