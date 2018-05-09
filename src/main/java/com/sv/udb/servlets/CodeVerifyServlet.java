/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.servlets;

import com.sv.udb.controllers.CallController;
import com.sv.udb.models.Call;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author kevin
 */
@WebServlet(name = "CodeVerifyServlet", urlPatterns = {"/CodeVerifyServlet"})
public class CodeVerifyServlet extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        try {
            boolean isPost = request.getMethod().equals("POST");
            
            if(isPost) {
                
                String code = request.getParameter("param");

                //Permite imprimir en el cliente
                PrintWriter out = response.getWriter();

                //Buscando denuncia con codigo proporcionado
                Call call = new CallController().getOneByCode(code);
                
                //Si la denuncia no existe
                if (call == null) {
                    out.println("No existe ninguna denuncia vinculada al código ingresado");
                }
                //Si la denuncia esta vinculada a root, osea, no ha sido procesada
                else if (call.getUser().getId() == 1) {
                    out.println("Su denuncia aún no ha sido procesada");
                }
                //Si la denuncia ya fue procesada
                else {
                    out.println("Denuncia válida");
                }

            }
            else {
                request.getRequestDispatcher("/").forward(request, response);
            }
        }
        catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.println("Error: " + e.toString());
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
