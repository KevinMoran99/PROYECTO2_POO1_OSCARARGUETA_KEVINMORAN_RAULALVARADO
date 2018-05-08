<%@page import="com.sv.udb.controllers.ComplaintTypeController"%>
<%@page import="com.sv.udb.controllers.SchoolController"%>
<%@page import="com.sv.udb.controllers.UserController"%>
<%@page import="com.sv.udb.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel='stylesheet' type="text/css" href='${pageContext.request.contextPath}/webjars/bootstrap/3.2.0/css/bootstrap.min.css'>
        <link rel='stylesheet' href='resources/lib/css/login.css'>
        <link rel='stylesheet' type="text/css" href='${pageContext.request.contextPath}/webjars/select2/4.0.3/css/select2.min.css'>
        <link rel='stylesheet' type="text/css" href="${pageContext.request.contextPath}/webjars/sweetalert/1.0.0/sweetalert.css">
        <script type="text/javascript" src="${pageContext.request.contextPath}/webjars/jquery/2.1.1/jquery.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/webjars/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/webjars/select2/4.0.3/js/select2.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/webjars/sweetalert/1.0.0/sweetalert.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/pdfjs/build/pdf.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/js/pdfobject.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/js/report.js"></script>
    </head>
    <body>
        <div class="container">
            <jsp:useBean id="objeUsua" class="com.sv.udb.models.User" scope="request">
                        <jsp:setProperty name="objeUsua" property="*"/>
            </jsp:useBean>
            
                <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                    <li class="nav-item text-white">
                      <a class="nav-link active text-white" id="pills-login-tab" data-toggle="pill" href="#pills-login" role="tab" aria-controls="pills-home" aria-selected="true">Iniciar sesion</a>
                    </li>
                    <li class="nav-item text-white">
                      <a class="nav-link text-white" id="pills-newcall-tab" data-toggle="pill" href="#pills-newcall" role="tab" aria-controls="pills-profile" aria-selected="false">Nueva denuncia</a>
                    </li>
                    <li class="nav-item text-white">
                      <a class="nav-link text-white" id="pills-viewcall-tab" data-toggle="pill" href="#pills-viewcall" role="tab" aria-controls="pills-contact" aria-selected="false">Ver denuncia</a>
                    </li>
                </ul>
            <div class="card card-container">
                <div class="tab-content" id="pills-tabContent">
                    <div class="tab-pane fade in active" id="pills-login" role="tabpanel" aria-labelledby="pills-login-tab">

                            <!-- <img class="profile-img-card" src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120" alt="" /> -->
                            <img style="width: 100%;" src="resources/lib/img/logoMined.png" />
                            <p id="profile-name" class="profile-name-card"></p>
                            <form class="form-signin">
                                <input type="email" id="inputEmail" class="form-control" name="email" placeholder="Email" required autofocus>
                                <input type="password" id="inputPassword" class="form-control" name="pass" placeholder="Contraseña" required>
                                <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">Iniciar sesión</button>
                            </form><!-- /form -->

                    </div>
                    <div class="tab-pane fade" id="pills-newcall" role="tabpanel" aria-labelledby="pills-newcall-tab">
                        <h3>Nueva denuncia</h3>
                        <br>
                        <button class="btn"  data-toggle="modal" data-target="#modalAdd">Enviar denuncia de manera anonima</button>
                        <c:if test='${sessionScope.callCode != null}'>
                            <br><br>
                            <div class="text-center">
                                <a href="#" onclick="showCode()">Ver código de última denuncia hecha</a>
                            </div>
                        </c:if>
                        <!-- Modal -->
                        <div id="modalAdd" class="modal fade" role="dialog">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Nueva denuncia</h4>
                              </div>
                              <form id="newCallForm" method="POST" action="${pageContext.request.contextPath}/NewCallServlet" name="add">
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label for="school">Escuela desde la que se reporta:</label><br>
                                            <select class="form-control" name="school" id="school">
                                                <c:forEach var="schoolItem" items="<%=new SchoolController().getAll(true)%>">
                                                    <option value="${schoolItem.getId()}">${schoolItem}</option>
                                                </c:forEach>
                                            </select>
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
                                                <textarea style="resize: none;" rows="4" cols="50" class="form-control" name="description" id="description" value="" ></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label for="complaint_type">Tipo de denuncia:</label>
                                            <select class="form-control" name="complaint_type" id="complaint_type">
                                                <c:forEach var="complaintItem" items="<%=new ComplaintTypeController().getAll(true)%>">
                                                    <option value="${complaintItem.getId()}">${complaintItem}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <br>
                                    <br>
                                    <div class="pull-right">

                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal" onclick="clearForm();">Cerrar</button>
                                    <input type="submit" class="btn btn-primary" name="formSubmit" value="Guardar denuncia anonima"/>
                                </div>
                              </form>
                            </div>
                          </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="pills-viewcall" role="tabpanel" aria-labelledby="pills-viewcall-tab">
                        <h3>Ver denuncia</h3>
                        <br>
                        <div class="row">
                            <form id='reportCode' method="post">
                                <div class="col-md-9">
                                        <input type="text" class="form-control" id="param" name="param" value="" required/>
                                </div>
                                <div class="col-md-3">
                                        <input type="submit" id="btnSearch" class="btn" name="formSubmit" value="Buscar"/>
                                </div>
                            </form>
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
                    </div>
                </div>
            </div><!-- /card-container -->
        </div><!-- /container -->
        <script>
            $(document).ready(function() {
                //Si hay mensajes, los muestra
                if("${message}" !== "") {
                    var title = "";
                    title = "${status}" == "success" ? "Operación exitosa" : "Operación denegada";
                    
                    swal(title, "${message}", "${status}");
                }
                
                $('select').select2();
                
                  
            });
            
            function clearForm() {
                $("#school").val($("#school option:first").val());
                $("#description").val("");
                $("#complaint_type").val($("#complaint_type option:first").val());
                $('select').select2();
            }
            
            function showCode() {
                if (${sessionScope.callCode != null}) {
                    swal("${sessionScope.callCode}", "Por favor, mantenga guardado este código en otro lugar, pues, si cierra su navegador o hace otra denuncia, ya no podrá acceder a él.");
                }
                else {
                    swal("No se han hecho denuncias");
                }
            }
            
            var ctxt = "${pageContext.request.contextPath}";
            
            //Al solicitar un reporte por codigo
            $("#reportCode").submit(function(e) {
                e.preventDefault();
                
                
                //Verificando que la denuncia sea valida
                $.ajax({
                    method: 'POST',
                    data: $("#reportCode").serialize(),
                    url: "${pageContext.request.contextPath}/CodeVerifyServlet",
                    success: function(result) {
                        console.log(result);
                        if ($.trim(result) != "Denuncia válida") {
                            swal("Operación denegada", result, "warning");
                        }
                        else {
                            //Si la denuncia es válida, carga su reporte
                            showReport(ctxt, $("#param").val());
                        }
                    }
                });
                
                
            });
        </script>
        <%
                Object usua = request.getAttribute("objeUsua");
                User usuaLoge = usua != null ? (User)usua : null;
                if(usuaLoge != null){
                    User temp = new UserController().login(usuaLoge.getEmail(), usuaLoge.getPass());
                    if(temp != null){
                        session.setAttribute("session", temp);
                        if(temp.getUser_type().getId()==1){
                            response.sendRedirect("admin/users.jsp");
                        }else{
                            response.sendRedirect("personal/calls.jsp");
                        }
                    }
                }
            %>
    </body>
</html>
