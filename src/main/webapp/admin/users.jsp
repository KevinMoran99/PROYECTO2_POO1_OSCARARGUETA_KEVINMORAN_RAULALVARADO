<%-- 
    Document   : users
    Created on : 05-03-2018, 02:23:28 PM
    Author     : kevin
--%>

<%@page import="com.sv.udb.models.User"%>
<%@page import="com.sv.udb.controllers.UserController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
    User p =(User)(request.getSession().getAttribute("session"));
    if(p==null){
        response.sendRedirect("/PROYECTO2_POO1_OSCARARGUETA_KEVINMORAN_RAULALVARADO");
    }else{
        if(p.getUser_type().getId() !=1){
            response.sendRedirect("/PROYECTO2_POO1_OSCARARGUETA_KEVINMORAN_RAULALVARADO/personal/calls.jsp");
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuarios</title>
        <jsp:include page="../WEB-INF/jspf/head.jsp"></jsp:include>
    </head>
    <body>
        <jsp:include page="../WEB-INF/jspf/navadmin.jsp"></jsp:include>
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
                        <form method="POST" action="${pageContext.request.contextPath}/admin/AdminUsersServlet" name="filter">
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
                                        <!--Mostrar con Nombre, Apellido e Email-->
                                        <input type="text" class="form-control" name="filterArg" id="filterArg" value="" placeholder="Texto de busqueda"/>
                                        
                                        <div id="select2Container">
                                            <!--Mostrar con Tipo de usuario y estado-->
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
                        <form method="POST" action="${pageContext.request.contextPath}/admin/AdminUsersServlet" name="Tabl">
                            <div class="row">
                                <div class="col-md-12" style="height: 180px; overflow-y: auto;">
                                    <c:choose>
                                        <c:when test="${filtered==null}">
                                            <display:table id="tblMain" name="<%=new UserController().getAll(false)%>">
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
                                        </c:when>
                                        <c:otherwise>
                                            <display:table id="tblMain" name="${table}">
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
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                        <form method="POST" autocomplete="off" action="${pageContext.request.contextPath}/admin/AdminUsersServlet" name="Demo">
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
                            <c:when test="${mode == 'mod'}">
                                <input type="submit" class="btn btn-primary" name="formSubmit" value="Modificar"/>
                            </c:when>
                            <c:otherwise>
                                <input type="submit" class="btn btn-primary" name="formSubmit" value="Agregar"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </form>
                            <form method="POST" action="${pageContext.request.contextPath}/admin/AdminUsersServlet">
                                <div class="pill-right">
                                    <input type="submit" class="btn" name="formSubmit" value="Limpiar"/>
                                </div>
                            </form>
            </div>
        </div>
        <script>
            $(document).ready(function() {
                $('select').select2();
                $("#usersItem").addClass("active");
                $('#select2Container').hide();
                $('#filterArg').hide();
                $("#btnSearch").hide();
                //Si hay mensajes, los muestra
                if("${message}" !== "") {
                    var title = "";
                    title = "${status}" == "success" ? "Operación exitosa" : "Operación denegada";
                    
                    swal(title, "${message}", "${status}");
                }
            });
            $("#filterType").change(function(){
                var select = $("#filterType");
                 $("#filterSelect").empty();
                
                if(select.val()>=4){
                    $("#btnSearch").show();
                    $("#filterArg").hide();
                    $("#select2Container").show();
                    if(select.val()==="5"){
                        $("#filterSelect").append("<option value='1'>Activo</option>").trigger("change");
                        $("#filterSelect").append("<option value='0'>Inactivo</option>").trigger("change");
                    }else{
                        $("#filterSelect").append("<option value='1'>Administrador</option>").trigger("change");
                        $("#filterSelect").append("<option value='2'>Personal</option>").trigger("change");
                    }
                }else{
                    if(select.val()==="0"){
                        $("#btnSearch").hide();
                        $('#select2Container').hide();
                        $('#filterArg').hide();
                    }else{
                        $("#btnSearch").show();
                        $("#filterArg").show();
                        $("#select2Container").hide();
                    }
                }
            })  ;
        </script>
    </body>
</html>
