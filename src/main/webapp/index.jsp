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
            <div class="card card-container">
                <!-- <img class="profile-img-card" src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120" alt="" /> -->
                <img style="width: 100%;" src="resources/lib/img/logoMined.png" />
                <p id="profile-name" class="profile-name-card"></p>
                <form class="form-signin">
                    <input type="email" id="inputEmail" class="form-control" placeholder="Email" required autofocus>
                    <input type="password" id="inputPassword" class="form-control" placeholder="Contraseña" required>
                    <button class="btn btn-lg btn-primary btn-block btn-signin" type="submit">Iniciar sesión</button>
                </form><!-- /form -->
            </div><!-- /card-container -->
        </div><!-- /container -->
    </body>
</html>
