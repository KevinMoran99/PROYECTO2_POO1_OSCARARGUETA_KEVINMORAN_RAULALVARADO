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
            <div class="card card-container">
                <!-- <img class="profile-img-card" src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120" alt="" /> -->
                <img style="width: 100%;" src="resources/lib/img/logoMined.png" />
                <p id="profile-name" class="profile-name-card"></p>
                <form class="form-signin">
                    <input type="email" id="inputEmail" class="form-control" name="email" placeholder="Email" required autofocus>
                    <input type="password" id="inputPassword" class="form-control" name="pass" placeholder="Contraseña" required>
                    <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">Iniciar sesión</button>
                </form><!-- /form -->
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
                System.err.println("El usuario es: " + usuaLoge.getName());
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
