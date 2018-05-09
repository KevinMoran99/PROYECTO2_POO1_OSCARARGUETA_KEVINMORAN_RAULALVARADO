    <%-- 
    Document   : users
    Created on : 05-03-2018, 02:23:28 PM
    Author     : kevin
--%>

<%@page import="com.sv.udb.models.User"%>
<%@page import="com.sv.udb.controllers.ComplaintTypeController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
    User p = (User) (request.getSession().getAttribute("session"));
    if (p == null) {
        response.sendRedirect("/PROYECTO2_POO1_OSCARARGUETA_KEVINMORAN_RAULALVARADO");
    } else {
        if (p.getUser_type().getId() != 1) {
            response.sendRedirect("/PROYECTO2_POO1_OSCARARGUETA_KEVINMORAN_RAULALVARADO/personal/calls.jsp");
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tipos de denuncias</title>
        <jsp:include page="../WEB-INF/jspf/head.jsp"></jsp:include>
        </head>
        <body>
        <jsp:include page="../WEB-INF/jspf/navadmin.jsp"></jsp:include>
            <div class="wrapper">
                <div class="row">
                    <div class="col-md-12 content">
                        <h1>Tipos de denuncias</h1>
                    </div>
                </div>
                <hr>
                <div class="content">
                    <div class="row">
                        <div class="col-md-12 content">
                            <form method="POST" action="${pageContext.request.contextPath}/admin/AdminComplaintTypeServlet" name="filter">
                                <div class="row">
                                    <div class="col-md-3 text-right">Buscar por:</div>
                                    <div class="col-md-3">
                                        <select class="form-control" name="filterType" id="filterType">
                                            <option value="0">N/A</option>
                                            <option value="1">Nombre</option>
                                            <option value="2">Acción tomada</option>
                                            <option value="3">Estado</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <!--Mostrar con Nombre-->
                                            <input type="text" class="form-control" name="filterArg" id="filterArg" value=""/>
                                            <!--Mostrar con Acción tomada y estado-->
                                            <div id="select2Container">
                                                <select class="form-control" name="filterSelect" id="filterSelect">
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="submit" id="btnSearch" class="btn" name="formSubmit" value="Buscar"/>
                                    </div>
                                </div>
                            </form>
                            <form method="POST" action="${pageContext.request.contextPath}/admin/AdminComplaintTypeServlet" name="Tabl">
                            <div class="row">
                                <div class="col-md-12" style="height: 250px; overflow-y: auto;">
                                    <c:choose>
                                        <c:when test="${filtered==null}">
                                            <display:table id="tblMain" name="<%= new ComplaintTypeController().getAll(false)%>">
                                                <display:column title="Cons">
                                                    <input type="radio" name="userId" value="${tblMain.id}" onchange="this.form.submit();"/>
                                                </display:column>
                                                <display:column property="name" title="Nombre" sortable="true" />
                                                <display:column property="taken_action" title="Acción tomada" sortable="true" />
                                                <display:column title="Estado" sortable="true">
                                                    <c:choose><c:when test="${tblMain.state}">Activo</c:when><c:otherwise>Inactivo</c:otherwise></c:choose>
                                                </display:column>
                                            </display:table>
                                        </c:when>
                                        <c:otherwise>
                                            <display:table id="tblMain" name="${table}">
                                                <display:column title="Cons">
                                                    <input type="radio" name="userId" value="${tblMain.id}" onchange="this.form.submit();"/>
                                                </display:column>
                                                <display:column property="name" title="Nombre" sortable="true" />
                                                <display:column property="taken_action" title="Acción tomada" sortable="true" />
                                                <display:column title="Estado" sortable="true">
                                                    <c:choose><c:when test="${tblMain.state}">Activo</c:when><c:otherwise>Inactivo</c:otherwise></c:choose>
                                                </display:column>
                                            </display:table>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <form method="POST" action="${pageContext.request.contextPath}/admin/AdminComplaintTypeServlet" name="Demo">
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
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <c:choose>
                                    <c:when test="${taken_actionE == null}">
                                        <label for="taken_action">Accion tomada</label>
                                    </c:when>
                                    <c:otherwise>
                                        <label for="taken_action" class="text-danger">${taken_actionE}</label>
                                    </c:otherwise>
                                </c:choose>
                                <select class="form-control" name="taken_action" id="taken_action" required>
                                    <c:choose>
                                        <c:when test="${taken_action.equals('Remitir con autoridad competente')}">
                                            <option value="Remitir con autoridad competente" selected>Remitir con autoridad competente</option>
                                            <option value="Tomar contacto con ISP y colegio">Tomar contacto con ISP y colegio</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Remitir con autoridad competente">Remitir con autoridad competente</option>
                                            <option value="Tomar contacto con ISP y colegio" selected>Tomar contacto con ISP y colegio</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="pull-right">
                        <c:choose>
                            <c:when test="${mode == 'mod'}">
                                <input type="submit" class="btn btn-primary" name="formSubmit" value="Modificar"/>
                            </c:when>
                            <c:otherwise>
                                <input type="submit" class="btn btn-primary" name="formSubmit" value="Agregar"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </form>
                <form method="POST" action="${pageContext.request.contextPath}/admin/AdminComplaintTypeServlet">
                    <div class="pill-right">
                        <input type="submit" class="btn" name="formSubmit" value="Limpiar"/>
                    </div>
                </form>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $('select').select2();
                $("#complaintsItem").addClass("active");
                $('#select2Container').hide();
                $('#filterArg').hide();
                $("#btnSearch").hide();
                //Si hay mensajes, los muestra
                if ("${message}" !== "") {
                    var title = "";
                    title = "${status}" == "success" ? "Operación exitosa" : "Operación denegada";

                    swal(title, "${message}", "${status}");
                }
            });
            $("#filterType").change(function () {
                var select = $("#filterType");
                $("#filterSelect").empty();

                if (select.val() > 1) {
                    $("#btnSearch").show();
                    $("#filterArg").hide();
                    $("#select2Container").show();
                    if (select.val() === "2") {
                        $("#filterSelect").append("<option value='Remitir con autoridad competente'>Remitir con autoridad competente</option>").trigger("change");
                        $("#filterSelect").append("<option value='Tomar contacto con ISP y colegio'>Tomar contacto con ISP y colegio</option>").trigger("change");
                    } else {
                        $("#filterSelect").append("<option value='1'>Activo</option>").trigger("change");
                        $("#filterSelect").append("<option value='0'>Inactivo</option>").trigger("change");
                    }
                } else {
                    if (select.val() === "0") {
                        $("#btnSearch").hide();
                        $('#select2Container').hide();
                        $('#filterArg').hide();
                    } else {
                        $("#btnSearch").show();
                        $("#filterArg").show();
                        $("#select2Container").hide();
                    }
                }
            });
        </script>
    </body>
</html>
