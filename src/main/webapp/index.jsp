<%@page import="com.sv.udb.controllers.UserController"%>
<%@page import="com.sv.udb.models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel='stylesheet' href='webjars/bootstrap/3.2.0/css/bootstrap.min.css'>
        <link rel='stylesheet' href='resources/lib/css/login.css'>
        <script type="text/javascript" src="webjars/jquery/2.1.1/jquery.min.js"></script>
        <script type="text/javascript" src="webjars/bootstrap/3.2.0/js/bootstrap.min.js"></script>
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
                        <!-- Modal -->
                        <div id="modalAdd" class="modal fade" role="dialog">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Nueva denuncia</h4>
                              </div>
                              <div class="modal-body">
                                <p>contenido</p>
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                              </div>
                            </div>
                          </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="pills-viewcall" role="tabpanel" aria-labelledby="pills-viewcall-tab">
                        <h3>Ver denuncia</h3>
                        <br>
                        <div class="row">
                            <form method="post">
                                <div class="col-md-9">
                                        <input type="text" class="form-control" id="param" name="param" value=""/>
                                </div>
                                <div class="col-md-3">
                                        <input type="submit" id="btnSearch" class="btn" name="formSubmit" value="Buscar"/>
                                </div>
                            </form>
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
