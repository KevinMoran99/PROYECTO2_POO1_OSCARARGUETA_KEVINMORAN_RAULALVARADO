/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.servlets;

import com.sv.udb.controllers.UserController;
import com.sv.udb.models.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jasypt.util.text.BasicTextEncryptor;

/**
 *
 * @author oscar
 */
@WebServlet(name = "AdminUsersServlet", urlPatterns = {"/admin/AdminUsersServlet"})
public class AdminUsersServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
        //viene de post?
        boolean esValido = request.getMethod().equals("POST");
        String message = "", status = "success";

        if(!esValido)
        {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
        else
        {
            try{
                //trae un id de usuario de la tabla?
                if(request.getParameter("userId") != null){
                    int id = Integer.parseInt(request.getParameter("userId"));
                    User u = new UserController().getOne(id);
                    request.setAttribute("id", u.getId());
                    request.setAttribute("name", u.getName());
                    request.setAttribute("lastname", u.getLastname());
                    request.setAttribute("user_type",u.getUser_type().getId());
                    request.setAttribute("email", u.getEmail());
                    request.setAttribute("state",u.isState()?"1":"0");
                    
                    //es una herramienta magica que nos ayudara mas tarde(cambio de texto de boton)
                    request.setAttribute("mode", "mod");
                }
                
                //si es accion de crud
                String crud = request.getParameter("formSubmit");
                if(crud.equals("Limpiar")){
                    request.setAttribute("mode", "add");
                }
                
                if(crud.equals("Buscar")){
                    int type= Integer.parseInt(request.getParameter("filterType"));
                    if(type>0 && type<4){
                        String param = request.getParameter("filterArg");
                        request.setAttribute("filtered", 1);
                        request.setAttribute("table",new UserController().search(type, param, false));
                    }else{
                        if(type==5){
                            int state = Integer.parseInt(request.getParameter("filterSelect"));
                            String param = state==1 ? "Activo":"Inactivo";
                            request.setAttribute("table",new UserController().search(type, param, false));
                        }else{
                            String param = request.getParameter("filterSelect");
                            request.setAttribute("table",new UserController().search(type, param, false));
                        }
                        request.setAttribute("filtered", 1);
                    }
                    
                }
     
                
                
                //si es agregar
                if(crud.equals("Agregar")){
                        //obteniendo todos los datos
                    String name = request.getParameter("name").trim();
                    String lastname = request.getParameter("lastname").trim();
                    String email  = request.getParameter("email").trim();
                    String pass = request.getParameter("pass").trim();
                    int user_type = Integer.parseInt(request.getParameter("user_type"));
                    int state = Integer.parseInt(request.getParameter("state"));
                    message="Usuario almacenado";
                    boolean flag = true;
                    if(name.isEmpty()){
                        request.setAttribute("nameE","Nombre: no se permiten campos vacios");
                        flag = false;
                    }
                    if(lastname.trim().isEmpty()){
                        request.setAttribute("lastnameE","Apellidos: no se permiten campos vacios");
                        flag = false;
                    }
                    if(email.isEmpty()){
                        request.setAttribute("emailE","Email: no se permiten campos vacios");
                        flag = false;
                    }
                    if(pass.isEmpty() || pass.length()<7){
                        request.setAttribute("passE","Contraseña: no se permiten menos de 7 caracteres");
                        flag = false;
                    }
                    if(flag){
                        boolean temp;
                        temp = state==1;
                        
                        if(!new UserController().addUser(name, lastname, email, pass,user_type,temp)){
                            message = "Error al almacenar usuario";
                            status= "error";
                        }
                    }
                    
                    //estableciendo la accion a agregar
                    request.setAttribute("mode", "add");
                }
                //si es actualizar
                if(crud.equals("Modificar")){
                    message = "Usuario modificado";
                    int id = Integer.parseInt(request.getParameter("id"));
                        //obteniendo todos los datos
                    String name = request.getParameter("name").trim();
                    String lastname = request.getParameter("lastname").trim();
                    String email  = request.getParameter("email").trim();
                    String pass = request.getParameter("pass").trim();
                    int user_type = Integer.parseInt(request.getParameter("user_type"));
                    int state = Integer.parseInt(request.getParameter("state"));
                    boolean flag = true;
                    if(name.isEmpty()){
                        request.setAttribute("nameE","Nombre: no se permiten campos vacios");
                        flag = false;
                    }
                    if(lastname.trim().isEmpty()){
                        request.setAttribute("lastnameE","Apellidos: no se permiten campos vacios");
                        flag = false;
                    }
                    if(email.isEmpty()){
                        request.setAttribute("emailE","Email: no se permiten campos vacios");
                        flag = false;
                    }
                    if(!pass.isEmpty() && pass.length()<7){
                        request.setAttribute("passE","Contraseña: no se permiten menos de 7 caracteres");
                    }
                    if(flag){
                        boolean temp;
                        temp = state==1;
                        
                        if(!new UserController().updateUser(id,name, lastname, email, pass,user_type,temp)){
                            message = "Error al modificar usuario";
                            status= "error";
                        }
                    }
                    //estableciendo la accion a agregar
                    request.setAttribute("mode", "add");
                }
                
            }catch(Exception ex){
                ex.printStackTrace();
            }
            
            //retornando las operaciones
            request.setAttribute("message", message);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
