/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.servlets;

import com.sv.udb.controllers.CallController;
import com.sv.udb.models.Call;
import com.sv.udb.utilities.Utils;
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
@WebServlet(name = "CallsServlet", urlPatterns = {"/CallsServlet"})
public class CallsServlet extends HttpServlet {

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
        try {
            boolean isPost = request.getMethod().equals("POST");
            
            if(isPost) {
                //Acción solicitada
                String action = request.getParameter("formSubmit");
                
                if (action.equals("Buscar")) {
                    //Obteniendo parámetros
                    int filterType = Integer.parseInt(request.getParameter("filterType"));
                    String param = String.valueOf(request.getParameter("filterArg"));
                    String from = String.valueOf(request.getParameter("filterFrom"));
                    String to = String.valueOf(request.getParameter("filterTo"));
                    
                    //Si se eligió "registradas por mí", se tomará el id del usuario logeado
                    if (filterType == CallController.BY_USER){
                        /*AAAAA*/param = "2";
                    }
                    
                    //Permite imprimir en el cliente
                    PrintWriter out = response.getWriter();
                    
                    for (Call call : new CallController().search(filterType, param, from, to)) {
                        out.println("<tr class=\"odd\">");
                        out.println("<td><input type=\"radio\" name=\"callId\" value=\"" + call.getId() + "\" onchange=\"this.form.submit();\"/></td>");
                        out.println("<td>" + call.getSchool() + "</td>");
                        out.println("<td>" + call.getComplaint_type() + "</td>");
                        out.println("<td>" + call.getDescription() + "</td>");
                        out.println("<td>" + (call.getViable() ? "Es viable" : "No es viable") + "</td>");
                        out.println("<td>" + Utils.formatDate(call.getCall_date(), Utils.DATE_UI) + "</td>");
                        out.println("</tr>");
                    }

                }
            }
            else {
                request.getRequestDispatcher("/personal/newcall.jsp").forward(request, response);
            }
        }
        catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.println("Error: " + e.getMessage());
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
