<%-- 
    Document   : calls
    Created on : 05-04-2018, 10:36:13 PM
    Author     : kevin
--%>

<%@page import="com.sv.udb.models.User"%>
<%@page import="com.sv.udb.controllers.ComplaintTypeController"%>
<%@page import="com.sv.udb.controllers.SchoolController"%>
<%@page import="com.sv.udb.controllers.CallController"%>
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
        <title>Lista de denuncias</title>
        <jsp:include page="../WEB-INF/jspf/head.jsp"></jsp:include>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/navpersonal.jsp"></jsp:include>
        <div class="wrapper">
            <div class="row">
                <div class="col-md-12 content">
                    <h1>Lista de denuncias</h1>
                </div>
            </div>
            <hr>
            <div class="content">
                <form method="POST" id="filterForm" name="filter">
                    <div class="row" style="margin-bottom: 5px;">
                        <div class="col-md-3 text-right">Buscar por:</div>
                        <div class="col-md-3">
                            <select class="form-control" name="filterType" id="filterType" onchange="filterTable();">
                                <option value="0">N/A</option>
                                <option value="1">Sin procesar</option>
                                <option value="2">Código</option>
                                <option value="3">Escuela</option>
                                <option value="4">Tipo</option>
                                <option value="5">Descripción</option>
                                <option value="6">Viable</option>
                                <option value="7">Registradas por mí</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <div id="filterSelect" class="form-group">
                                <!--Aquí se imprimen los controles de argumento de filtros-->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 text-right">Fecha:</div>
                        <div class="col-md-3">
                            <input type="date" class="form-control" name="filterFrom" id="filterFrom"/>
                        </div>
                        <div class="col-md-3">
                            <input type="date" class="form-control" name="filterTo" id="filterArg"/>
                        </div>
                        <div class="col-md-3">
                            <input type="submit" class="btn" name="filterBtn" value="Buscar"/>
                        </div>
                    </div>
                </form>
                <br>
                <form method="POST" action="${pageContext.request.contextPath}/CallsServlet" name="Tabl">
                    <div class="row">
                        <div class="col-md-12">
                            <display:table id="tblMain" name="<%= new CallController().getAll()%>">
                                <display:column title="Ver detalle">
                                    <input type="radio" name="callId" value="${tblMain.id}" onchange="this.form.submit();"/>
                                </display:column>
                                <display:column property="code" title="Código" sortable="true" />
                                <display:column property="school" title="Escuela" sortable="true" />
                                <display:column property="complaint_type" title="Tipo" sortable="true" />
                                <display:column property="description" title="Descripción" sortable="true" />
                                <display:column title="Viable" sortable="true">
                                    <c:choose>
                                        <c:when test="${tblMain.user.id == 1}">
                                            Sin procesar
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose><c:when test="${tblMain.viable}">Es viable</c:when><c:otherwise>No es viable</c:otherwise></c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </display:column>
                                <display:column property="call_date" title="Fecha" sortable="true" format="{0,date,dd/MM/yyyy}" />
                            </display:table>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <script>
            $(document).ready(function() {
                $('select').select2();
                
                $("#callsItem").addClass("active");
            });
            
            //Al elegir un tipo de filtro
            function filterTable() {
                var select = $("#filterType");
                $("#filterSelect").empty();
                
                //Al elegir un tipo de busqueda
                switch(select.val()){
                    //Por escuelas
                    case "3":
                        var markupToAppend = "<select class='form-control' name='filterArg' id='filterArg'>";
                        <c:forEach var="schoolItem" items="<%=new SchoolController().getAll(true)%>">
                            markupToAppend += "<option value='${schoolItem.getId()}'>${schoolItem}</option>";
                        </c:forEach>
                        markupToAppend += "</select>";
                        $("#filterSelect").append(markupToAppend); 
                        break;
                    //Por tipo de denuncia
                    case "4":
                        var markupToAppend = "<select class='form-control' name='filterArg' id='filterArg'>";
                        <c:forEach var="typeItem" items="<%=new ComplaintTypeController().getAll(true)%>">
                            markupToAppend += "<option value='${typeItem.getId()}'>${typeItem}</option>";
                        </c:forEach>
                        markupToAppend += "</select>";
                        $("#filterSelect").append(markupToAppend);  
                        break;
                    //Por código o descripción
                    case "2":
                    case "5":
                        $("#filterSelect").append("<input type='text' class='form-control' name='filterArg' id='filterArg'/>");
                        break;
                    //Por viabilidad
                    case "6":
                        $("#filterSelect").append("<select class='form-control' name='filterArg' id='filterArg'>" +
                                                        "<option value='1'>Es viable</option>" +
                                                        "<option value='0'>No es viable</option>" +
                                                    "</select>");  
                        break;
                    //Los que no necesitan otro argumento
                    default:
                        break;
                }
                
                $('select').select2();
            };
            
            //Al filtrar
            $("#filterForm").submit(function (e) {
                e.preventDefault();
                
                $.ajax({
                    method: 'POST',
                    data: $("#filterForm").serialize() + "&formSubmit=Buscar",
                    url: "${pageContext.request.contextPath}/CallsServlet",
                    success: function(result){
                        $('#tblMain > tbody').html(result);
                    }
                });
            });
        </script>
    </body>
</html>
