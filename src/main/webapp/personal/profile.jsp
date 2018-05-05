<%-- 
    Document   : profile
    Created on : 05-05-2018, 12:32:21 AM
    Author     : kevin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reportes</title>
        <jsp:include page="../WEB-INF/jspf/head.jspf"></jsp:include>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/navpersonal.jspf"></jsp:include>
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 content">
                    <h1>Mi perfil</h1>
                </div>
            </div>
            <hr>
            <div class="content">
                <div class="panel panel-primary">
                    <div class="panel-heading">Editar información</div>
                    <div class="panel-body">
                        <form method="POST" action="PrestamoServlet" name="profile">
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
                                </div>
                                <div class="row">
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
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <c:choose>
                                                <c:when test="true">
                                                    <label for="passConfirm">Repetir contraseña</label>
                                                </c:when>
                                                <c:otherwise>
                                                    <label for="passConfirm" class="text-danger">Error</label>
                                                </c:otherwise>
                                            </c:choose>
                                            <input type="password" class="form-control" name="passConfirm" id="passConfirm" value=""/>
                                        </div>
                                    </div>
                                </div>
                            <div class="pull-right">
                                <input type="submit" class="btn" value="Limpiar">
                                <input type="submit" class="btn btn-primary" value="Guardar cambios">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

