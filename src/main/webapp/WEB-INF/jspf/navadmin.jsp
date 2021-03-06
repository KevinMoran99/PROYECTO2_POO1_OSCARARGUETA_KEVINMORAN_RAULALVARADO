
<%@page import="com.sv.udb.models.User"%>
<div class="nav-side-menu">
    <div class="brand"><%=(session.getAttribute("session") != null ? 
                    ((User)(session.getAttribute("session"))).getName() : "Username..") %></div>
    <i class="fa fa-bars fa-2x toggle-btn" data-toggle="collapse" data-target="#menu-content"></i>
  
        <div class="menu-list">
  
            <ul id="menu-content" class="menu-content collapse out">
                <li id="usersItem">
                  <a href="${pageContext.request.contextPath}/admin/users.jsp">
                      <i class="material-icons">person outline</i> Usuarios
                  </a>
                </li>

                <li id="complaintsItem">
                    <a href="${pageContext.request.contextPath}/admin/complaint_types.jsp"><i class="material-icons">phone in talk</i> Tipos de denuncias </a>
                </li>

                <li id="schoolsItem">
                    <a href="${pageContext.request.contextPath}/admin/schools.jsp"><i class="material-icons">school</i> Escuelas </a>
                </li>  


                <li id="authsItem">
                    <a href="${pageContext.request.contextPath}/admin/authorities.jsp"><i class="material-icons">warning</i> Autoridades </a>
                </li>


                 <li id="provsItem">
                  <a href="${pageContext.request.contextPath}/admin/providers.jsp"><i class="material-icons">wifi</i> Proveedores</a>
                  </li>
                  <li>
                      <form id="logoutF" method="post" action="${pageContext.request.contextPath}/Helper/SessionServlet">
                          <a id="logout" onclick="this.form.submit();"><i class="material-icons">keyboard_arrow_left</i>Cerrar sesion</a>
                      </form>
                  </li>

            </ul>
     </div>
</div>
                  <script>
                      document.getElementById("logout").onclick = function() {
                        document.getElementById("logoutF").submit();
                      };
                  </script>
