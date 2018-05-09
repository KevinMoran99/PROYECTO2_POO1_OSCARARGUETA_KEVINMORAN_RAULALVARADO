/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.servlets;

import com.sv.udb.controllers.CallController;
import com.sv.udb.controllers.ProvAsignController;
import com.sv.udb.models.Call;
import com.sv.udb.models.Provider_asign;
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
@WebServlet(name = "CallDetailServlet", urlPatterns = {"/CallDetailServlet"})
public class CallDetailServlet extends HttpServlet {

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
                //Acción solicitada
                String action = request.getParameter("formSubmit");
                
                if (action.equals("Guardar cambios")) {
                    
                    //Variables de output. Su valor por defecto indica que no se han especificado cambios.
                    //Si el usuario no hizo cambios al hacer el submit, los valores por defecto prevaleceran
                    String message = "No se han especificado cambios sobre la denuncia", status = "warning";
                    
                    //Denuncia actual, guardada en sesión
                    Call call = (Call)request.getSession().getAttribute("call");
                    
                    //Si se ha especificado que la charla ha sido dada, se hace la actualización
                    Boolean talk_given = request.getParameter("talk_given") != null;
                    if (talk_given) {
                        if(new CallController().updateCall(call.getId(), true)) {
                            message = "Los cambios fueron guardados";
                            status = "success";
                        }
                        else {
                            message = "No se pudo actualizar el estado de charla de la denuncia";
                            status = "error";
                        }
                    }
                    
                    //Por cada proveedor al que se le haya especificado que ha removido el contenido, se hace la actualización
                    for (Provider_asign asign : new ProvAsignController().getAsigns(call)) {
                        Boolean content_removed = request.getParameter("content_removed" + asign.getId()) != null;
                        if (content_removed) {
                            if(new ProvAsignController().updateProvAsign(asign.getId(), true)) {
                                message = "Los cambios fueron guardados";
                                status = "success";
                            }
                            else {
                                message = "No se pudo actualizar el estado de contenido de proveedores";
                                status = "error";
                            }
                        }
                    }
                    
                    //Reestableciendo parámetros con los que se inicializó la vista
                    call = new CallController().getOne(call.getId()); //Se vuelve a hacer la consulta para que se actualize el campo talk_given
                    request.setAttribute("id", call.getId());
                    request.setAttribute("school", call.getSchool());
                    request.setAttribute("viable", call.getViable());
                    request.setAttribute("complaint_type",call.getComplaint_type());
                    request.setAttribute("user",call.getUser().getName() + " " + call.getUser().getLastname());
                    request.setAttribute("description", call.getDescription());
                    request.setAttribute("call_date",call.getCall_date());
                    request.setAttribute("taken_action",call.getComplaint_type().getTaken_action());
                    request.setAttribute("talk_given",call.isTalk_given());
                    request.setAttribute("code",call.getCode());
                    request.getSession().setAttribute("call", call);
                    
                    //Añadiendo parámetros de output
                    request.setAttribute("message", message);
                    request.setAttribute("status", status);
                    
                    //Redireccionando
                    request.getRequestDispatcher("/personal/calldetail.jsp").forward(request, response);
                }
                
                else {
                    request.getRequestDispatcher("/personal/calldetail.jsp").forward(request, response);
                }
            }
        }
        catch(Exception e) {
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
