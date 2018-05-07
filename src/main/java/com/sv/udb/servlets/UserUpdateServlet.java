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

/**
 *
 * @author oscar
 */
@WebServlet(name = "UserUpdateServlet", urlPatterns = {"/personal/UserUpdateServlet"})
public class UserUpdateServlet extends HttpServlet {

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
        boolean esValido = request.getMethod().equals("POST");
        String message = "", status = "success";

        if(!esValido)
        {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
        else
        {
            try{
                String crud = request.getParameter("formSubmit");
                if(crud.equals("Guardar cambios")){
                    User u = (User)(request.getSession().getAttribute("session"));
                    String name,lastname,email,password;
                    if(!request.getParameter("name").trim().equals("")){
                        name = request.getParameter("name");
                    }else{
                        name = u.getName();
                    }
                    if(!request.getParameter("lastname").trim().equals("")){
                        lastname = request.getParameter("lastname");
                    }else{
                        lastname=u.getLastname();
                    }

                    if(!request.getParameter("email").trim().equals("")){
                        email=request.getParameter("email");
                    }else{
                        email = u.getEmail();
                    }

                    if(!request.getParameter("pass").trim().equals("")){
                        password=request.getParameter("pass");
                    }else{
                        password="";
                    }

                    if(new UserController().updateUser(u.getId(), name, lastname, email, password, u.getUser_type().getId(), u.isState())){
                        u.setName(name);
                        u.setLastname(lastname);
                        u.setEmail(email);
                        request.getSession().setAttribute("session", u);
                        message = "Accion completada";
                    }else{
                        message = "No se pudo actualizar";
                        status = "error";
                    }
                }
            }catch(Exception ex){
                message="Error inesperado en el servidor";
                status="error";
            }
            request.setAttribute("message", message);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/personal/profile.jsp").forward(request, response);
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
