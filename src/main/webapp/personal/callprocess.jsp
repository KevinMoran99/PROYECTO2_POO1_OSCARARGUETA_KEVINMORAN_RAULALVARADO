<%-- 
    Document   : users
    Created on : 05-03-2018, 02:23:28 PM
    Author     : kevin
--%>

<%@page import="com.sv.udb.models.User"%>
<%@page import="com.sv.udb.controllers.ComplaintTypeController"%>
<%@page import="com.sv.udb.controllers.AuthorityController"%>
<%@page import="com.sv.udb.controllers.ProviderController"%>
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
        if(p.getUser_type().getId() !=2){
            response.sendRedirect("/PROYECTO2_POO1_OSCARARGUETA_KEVINMORAN_RAULALVARADO/admin/users.jsp");
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Procesar denuncia</title>
        <jsp:include page="../WEB-INF/jspf/head.jsp"></jsp:include>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/navpersonal.jsp"></jsp:include>
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 content">
                    <h1>Procesar denuncia</h1>
                </div>
            </div>
            <hr>
            <div class="content">
                <form id="newCallForm" method="POST" action="${pageContext.request.contextPath}/NewCallServlet" name="add">
                    <div class="row">
                        <div class="col-md-6">
                            <label for="school">Escuela desde la que se reporta:</label>
                            <p id="school">${school}</p>
                        </div>
                        <div class="col-md-6">
                            <br>
                            <div class="form-check text-center">
                                <input class="form-check-input big-checkbox" type="checkbox" value="1" id="viable" name="viable" onchange="toggleViable();">
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
                                <label for="description">Descripción:</label>
                                <p id="description">${description}</p>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-12">
                            <label for="complaint_type">Tipo de denuncia:</label>
                            <p id="complaint_type">${complaint_type}</p>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <c:if test="${authprovE != null}">
                            <label for="description" class="text-danger">${authprovE}</label>
                        </c:if>
                        <div id="AuthProv" style="height: 120px; overflow-y: auto;" class="col-md-12">
                            <c:choose>
                                <c:when test='${taken_action.equals("Tomar contacto con ISP y colegio")}'>
                                    <label for="provider">Proveedores a notificar:</label>
                                    <select class="form-control" name="provider[]" id="provider" multiple="multiple">
                                        <c:forEach var="provItem" items="<%=new ProviderController().getAll(true)%>">
                                            <option value="${provItem.getId()}">${provItem}</option>
                                        </c:forEach>
                                    </select>
                                </c:when>
                                <c:otherwise>
                                    <label for="authority">Autoridades a notificar:</label>
                                    <select class="form-control" name="authority[]" id="authority" multiple="multiple">
                                        <c:forEach var="authItem" items="<%=new AuthorityController().getAll(true)%>">
                                            <option value="${authItem.getId()}">${authItem}</option>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <br>
                    <div class="pull-right">
                        <input type="submit" class="btn btn-primary" name="formSubmit" value="Procesar"/>
                    </div>
                </form>
            </div>
        </div>
                    
        
        <script>
            $(document).ready(function() {
                $('select').select2();
                
                $("#AuthProv").children().hide();
                
                //Si hay mensajes, los muestra
                if("${message}" !== "") {
                    var title = "";
                    title = "${status}" == "success" ? "Operación exitosa" : "Operación denegada";
                    
                    swal(title, "${message}", "${status}");
                }
                
            });
            
            function toggleViable() {
                $("#AuthProv").children().toggle();
            }
            
        </script>
    </body>
</html>
