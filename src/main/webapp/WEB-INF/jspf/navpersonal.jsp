
<%@page import="com.sv.udb.models.User"%>
<div class="nav-side-menu">
    <div class="brand"><%=(session.getAttribute("session") != null ? 
                    ((User)(session.getAttribute("session"))).getName() : "Username..") %></div>
    <i class="fa fa-bars fa-2x toggle-btn" data-toggle="collapse" data-target="#menu-content"></i>
  
        <div class="menu-list">
  
            <ul id="menu-content" class="menu-content collapse out">
                <li id="callsItem">
                  <a href="${pageContext.request.contextPath}/personal/calls.jsp">
                      <i class="material-icons">assignment</i> Lista de denuncias
                  </a>
                </li>

                <li id="newCallItem">
                    <a href="${pageContext.request.contextPath}/personal/newcall.jsp"><i class="material-icons">phone in talk</i> Nueva denuncia </a>
                </li>


                <li id="reportsItem">
                    <a href="${pageContext.request.contextPath}/personal/reports.jsp"><i class="material-icons">picture_as_pdf</i> Reportes </a>
                </li>


                 <li id="profileItem">
                  <a href="${pageContext.request.contextPath}/personal/profile.jsp"><i class="material-icons">person outline</i> Mi perfil </a>
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

