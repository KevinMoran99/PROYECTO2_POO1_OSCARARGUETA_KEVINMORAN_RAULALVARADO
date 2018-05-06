<%-- 
    Document   : calldetail
    Created on : 05-04-2018, 11:23:44 PM
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
        <title>Detalle de denuncia</title>
        <jsp:include page="../WEB-INF/jspf/head.jsp"></jsp:include>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/navpersonal.jsp"></jsp:include>
        <div class="wrapper">
            <div class="row">
                <div class="col-md-8 content">
                    <h1>Detalle de denuncia</h1>
                </div>
                <c:if test="true">
                    <div class="col-md-4 content">
                        <h2 class="pull-right text-danger">ARCHIVADA</h2>
                    </div>
                </c:if>
            </div>
            <hr>
            <div class="content">
                <div class="row">
                    <div class="col-md-3">
                        <label for="user">Registrada por usuario:</label>
                        <p id="user">Mariano</p>
                    </div>
                    <div class="col-md-3">
                        <label for="date">Fecha de registro:</label>
                        <p id="date">Mariano</p>
                    </div>
                    <div class="col-md-3">
                        <label for="school">Escuela desde la que se reporta:</label>
                        <p id="school">Instituto Superpoderoso de los Majes Bien Maletas</p>
                    </div>
                    <div class="col-md-3">
                        <label for="complaint_type">Tipo de denuncia:</label>
                        <p id="complaint_type">Mariano</p>
                    </div>
                </div>
                <label for="description">Descripción:</label>
                <p id="description">Mariano</p>
                <br>
                <form method="POST" action="PrestamoServlet" name="filter">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-check text-center">
                                <input class="form-check-input big-checkbox" type="checkbox" value="" id="viable" checked>
                                <label class="form-check-label" for="viable">
                                    La denuncia es viable
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-check text-center">
                                <input class="form-check-input big-checkbox" type="checkbox" value="" id="talk_given">
                                <label class="form-check-label"  for="talk_given">
                                    Se impartieron charlas en el centro escolar para prevenir fenómenos similares
                                </label>
                            </div>
                        </div>
                    </div>
                    <h4>INSERTAR AQUÍ COSO DE PROVEEDORES</h4>
                    <div class="pull-left">
                        <input type="button" class="btn" value="Volver"/>
                    </div>
                    <div class="pull-right">
                        <input type="submit" class="btn" name="report" value="Generar reporte"/>
                        <input type="submit" class="btn btn-primary" name="formSubmit" value="Guardar cambios"/>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>

