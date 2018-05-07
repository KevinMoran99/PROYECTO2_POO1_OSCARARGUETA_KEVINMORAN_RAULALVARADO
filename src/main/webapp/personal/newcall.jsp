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
        <title>Nueva denuncia</title>
        <jsp:include page="../WEB-INF/jspf/head.jsp"></jsp:include>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/navpersonal.jsp"></jsp:include>
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 content">
                    <h1>Nueva denuncia</h1>
                </div>
            </div>
            <hr>
            <div class="content">
                <form id="newCallForm" method="POST" action="${pageContext.request.contextPath}/NewCallServlet" name="add">
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
                                <input class="form-check-input big-checkbox" type="checkbox" value="1" id="viable" name="viable" onchange="refreshAuthProv();">
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
                                    <c:when test="${descriptionE == null}">
                                        <label for="description">Descripción</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="description" class="text-danger">${descriptionE}</label>
                                    </c:otherwise>
                                </c:choose>
                                <textarea rows="4" cols="50" class="form-control" name="description" id="description" value="" ></textarea>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-12">
                            <label for="complaint_type">Tipo de denuncia:</label>
                            <select class="form-control" name="complaint_type" id="complaint_type" onchange="refreshAuthProv();">
                                <c:forEach var="complaintItem" items="<%=new ComplaintTypeController().getAll(true)%>">
                                    <option value="${complaintItem.getId()}">${complaintItem}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <c:if test="${authprovE != null}">
                            <label for="description" class="text-danger">${authprovE}</label>
                        </c:if>
                        <div id="AuthProv" style="height: 120px; overflow-y: auto;" class="col-md-12">
                            <!--Aquí se imprime el select de autoridades o de proveedores-->
                        </div>
                    </div>
                    <br>
                    <div class="pull-right">
                        <input type="submit" class="btn" name="formSubmit" value="Limpiar" formnovalidate/>
                        <input type="submit" class="btn btn-primary" name="formSubmit" value="Guardar"/>
                    </div>
                </form>
            </div>
        </div>
        <script>
            $(document).ready(function() {
                $('select').select2();
                
                //Si hay mensajes, los muestra
                if("${message}" !== "") {
                    var title = "";
                    title = "${status}" == "success" ? "Operación exitosa" : "Operación denegada";
                    
                    swal(title, "${message}", "${status}");
                }
            });
            
            function refreshAuthProv() {
                $.ajax({
                    method: "POST",
                    url: "${pageContext.request.contextPath}/NewCallServlet",
                    data: $('#newCallForm').serialize() + "&formSubmit=refreshAuthProv",
                    success: function(result) {
                        $("#AuthProv").html(result);
                        $('select').select2();
                    }
                });
            }
        </script>
    </body>
</html>
