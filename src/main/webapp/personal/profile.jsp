<%-- 
    Document   : profile
    Created on : 05-05-2018, 12:32:21 AM
    Author     : kevin
--%>

<%@page import="com.sv.udb.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
    User p =(User)(request.getSession().getAttribute("session"));
    if(p==null){
        response.sendRedirect("/PROYECTO2_POO1_OSCARARGUETA_KEVINMORAN_RAULALVARADO");
    }else{
        if(p.getUser_type().getId() !=2){
            response.sendRedirect("/PROYECTO2_POO1_OSCARARGUETA_KEVINMORAN_RAULALVARADO/admin/users.jsp");
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reportes</title>
        <jsp:include page="../WEB-INF/jspf/head.jsp"></jsp:include>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/navpersonal.jsp"></jsp:include>
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
                        <form method="POST" action="UserUpdateServlet" name="profile" id="formUpdate">
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
                                                    <input type="text" class="form-control" name="name" id="name" value="<%= p.getName() %>"/>
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
                                            <input type="text" class="form-control" name="lastname" id="lastname" value="<%= p.getLastname() %>"/>
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
                                            <input type="email" class="form-control" name="email" id="email" value="<%= p.getEmail() %>"/>
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
                                                    <input type="password" class="form-control" name="pass" id="pass" value="" minlength="7"/>
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
                                                    <input type="password" class="form-control" name="passConfirm" id="passConfirm" value="" minlength="7"/>
                                        </div>
                                    </div>
                                </div>
                            <div class="pull-right">
                                <input type="submit" class="btn btn-primary" name="formSubmit" value="Guardar cambios">
                            </div>
                        </form>
                        <form method="POST" action="UserUpdateServlet">
                                    <div class="pill-right">
                                        <input type="submit" class="btn" name="formSubmit" value="Limpiar campos"/>
                                    </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function() {
                //Si hay mensajes, los muestra
                if("${message}" !== "") {
                    var title = "";
                    title = "${status}" == "success" ? "Operación exitosa" : "Operación denegada";
                    
                    swal(title, "${message}", "${status}");
                }
            });
            
            $("#formUpdate").submit(function(e){
                if($("#pass").val().trim() !== "" || $("#passConfirm").val().trim() !==""){
                    if($("#pass").val() !== $("#passConfirm").val()){
                       swal("Error", "Las claves no coinciden", "error");
                       e.preventDefault();
                    }
                }
            });
        </script>
    </body>
</html>

