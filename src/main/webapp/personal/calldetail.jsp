<%-- 
    Document   : calldetail
    Created on : 05-04-2018, 11:23:44 PM
    Author     : kevin
--%>

<%@page import="com.sv.udb.models.User"%>
<%@page import="com.sv.udb.controllers.CallController"%>
<%@page import="com.sv.udb.controllers.ProvAsignController"%>
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
        <title>Detalle de denuncia</title>
        <jsp:include page="../WEB-INF/jspf/head.jsp"></jsp:include>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/navpersonal.jsp"></jsp:include>
        <div class="wrapper">
            <div class="row">
                <div class="col-md-8 content">
                    <h1>Detalle de denuncia: ${code}</h1>
                </div>
                <c:if test="${!viable}">
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
                        <p id="user">${user}</p>
                    </div>
                    <div class="col-md-3">
                        <label for="date">Fecha de registro:</label>
                        <p id="date"><fmt:formatDate pattern = "dd/MM/yyyy" value = "${call_date}" /></p>
                    </div>
                    <div class="col-md-3">
                        <label for="school">Escuela desde la que se reporta:</label>
                        <p id="school">${school}</p>
                    </div>
                    <div class="col-md-3">
                        <label for="complaint_type">Tipo de denuncia:</label>
                        <p id="complaint_type">${complaint_type}</p>
                    </div>
                </div>
                <label for="description">Descripción:</label>
                <p id="description">${description}</p>
                <br>
                <form method="POST" action="${pageContext.request.contextPath}/CallDetailServlet" name="filter">
                    <c:if test='${viable && taken_action.equals("Tomar contacto con ISP y colegio")}'>
                        <div class="row">
                            <div class="col-md-12">
                                <display:table id="tblProv" name='<%= new ProvAsignController().getAsigns(new CallController().getOne((Integer)request.getAttribute("id")))%>'>
                                    <display:column property="provider" title="Proveedor" sortable="true" />
                                    <display:column title="Contenido removido">
                                        <c:choose>
                                            <c:when test="${tblProv.content_removed}">
                                                <img style="width: 25px; height: 25px;" src="${pageContext.request.contextPath}/resources/lib/img/check.jpg">
                                            </c:when>
                                            <c:otherwise>
                                                <input type="checkbox" name="content_removed${tblProv.id}" value="1"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </display:column>
                                </display:table>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-check text-center">
                                    <c:choose>
                                        <c:when test="${talk_given}">
                                            <p style="font-size: 25px;">Las charlas para prevenir fenómenos similares en el centro escolar ya han sido impartidas.</p>
                                        </c:when>
                                        <c:otherwise>
                                            <input class="form-check-input big-checkbox" type="checkbox" value="1" name="talk_given" id="talk_given">
                                            <label class="form-check-label"  for="talk_given">
                                                Se impartieron charlas en el centro escolar para prevenir fenómenos similares
                                            </label>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <br>
                    <div class="pull-left">
                        <input type="button" class="btn" value="Volver" onclick="window.location='${pageContext.request.contextPath}/personal/calls.jsp';"/>
                    </div>
                    <div class="pull-right">
                        <c:if test='${viable && taken_action.equals("Tomar contacto con ISP y colegio")}'>
                            <input type="submit" class="btn btn-primary" name="formSubmit" value="Guardar cambios"/>
                        </c:if>
                    </div>
                </form>
                <div class="pull-right">
                    <form id="reportForm" data-ctxt="${pageContext.request.contextPath}">
                        <input type="hidden" id="reportId" value="${id}"/>
                        <input type="submit" class="btn" name="reportName" value="Generar reporte"/>
                    </form>
                </div>
            </div>
        </div>
                        
        <!-- Modal -->
        <div class="modal fade" id="modalReport" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title" id="myModalLabel">Reporte de denuncia</h4>
                        </div>
                    <div class="modal-body">
                        <div id="pdfViewer"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Salir</button>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            $(document).ready(function() {
                $("#callsItem").addClass("active");
                
                //Si hay mensajes, los muestra
                if("${message}" !== "") {
                    var title = "";
                    title = "${status}" == "success" ? "Operación exitosa" : "${status}" == "warning" ? "No hay cambios" : "Operación denegada";
                    
                    swal(title, "${message}", "${status}");
                }
            });
        </script>
    </body>
</html>

