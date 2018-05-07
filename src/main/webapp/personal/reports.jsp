<%-- 
    Document   : reports
    Created on : 05-05-2018, 12:11:32 AM
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
                    <h1>Reportes</h1>
                </div>
            </div>
            <hr>
            <div class="content text-center">
                <form  id="reportForm" data-ctxt="${pageContext.request.contextPath}">
                    <div class="row">
                        <div class="col-md-3 text-right">Fecha:</div>
                        <div class="col-md-3">
                            <input type="date" class="form-control" name="reportFrom" id="reportFrom" required/>
                        </div>
                        <div class="col-md-3">
                            <input type="date" class="form-control" name="reportTo" id="reportTo" required/>
                        </div>
                    </div>
                    <br><br>
                    <input type="submit" name="reportName" class="btn btn-report" style="background-color: rgb(100,189,244);" value="Denuncias por tipo"><br><br>
                    <input type="submit" name="reportName" class="btn btn-report" style="background-color: rgb(0,119,198);" value="Denuncias por viabilidad"><br><br>
                    <input type="submit" name="reportName" class="btn btn-report" style="background-color: rgb(8,80,127);" value="Top 10 instituciones con mas denuncias">
                </form>
            </div>
        </div>
                    
        <!-- Modal -->
        <div class="modal fade" id="modalReport" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title" id="myModalLabel">Visor de reportes</h4>
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
    </body>
</html>
