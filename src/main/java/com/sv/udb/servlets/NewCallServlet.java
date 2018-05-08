/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.servlets;

import com.sv.udb.controllers.AuthAsignController;
import com.sv.udb.controllers.AuthorityController;
import com.sv.udb.controllers.CallController;
import com.sv.udb.controllers.ComplaintTypeController;
import com.sv.udb.controllers.ProvAsignController;
import com.sv.udb.controllers.ProviderController;
import com.sv.udb.controllers.SchoolController;
import com.sv.udb.controllers.UserController;
import com.sv.udb.models.Authority;
import com.sv.udb.models.Call;
import com.sv.udb.models.Complaint_type;
import com.sv.udb.models.Provider;
import com.sv.udb.models.School;
import com.sv.udb.models.User;
import com.sv.udb.utilities.Mailer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.DefaultListModel;

/**
 *
 * @author kevin
 */
@WebServlet(name = "NewCallServlet", urlPatterns = {"/NewCallServlet"})
public class NewCallServlet extends HttpServlet {

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
                
                //Si se solicitó refrescar la lista de autoridades/proveedores via ajax
                if (action.equals("refreshAuthProv")) {
                    //Permite imprimir en el cliente
                    PrintWriter out = response.getWriter();
                    
                    //Si la denuncia está marcada como viable
                    Boolean viable = request.getParameter("viable") != null;
                    if(viable) {
                        //Obteniendo tipo de denuncia
                        int typeId = Integer.parseInt(request.getParameter("complaint_type"));
                        Complaint_type type = new ComplaintTypeController().getOne(typeId);
                        
                        //Si es una denuncia de autoridades
                        if (type.getTaken_action().equals("Remitir con autoridad competente")) {
                            out.println("<label for=\"authority\">Autoridades a notificar:</label>");
                            out.println("<select class=\"form-control\" name=\"authority[]\" id=\"authority\" multiple=\"multiple\" required>");
                            
                            for (Authority authority : new AuthorityController().getAll(true)) {
                                out.println("<option value=" + authority.getId() + ">" + authority + "</option>");
                            }
                            
                            out.println("</select>");
                        }
                        //Si es una denuncia de proveedores
                        else {
                            out.println("<label for=\"provider\">Proveedores a notificar:</label>");
                            out.println("<select class=\"form-control\" name=\"provider[]\" id=\"provider\" multiple=\"multiple\" required>");
                            
                            for (Provider provider : new ProviderController().getAll(true)) {
                                out.println("<option value=" + provider.getId() + ">" + provider + "</option>");
                            }
                            
                            out.println("</select>");
                        }
                    }
                }
                
                //Nueva denuncia registrada por personal
                else if (action.equals("Guardar")){
                    boolean flag = true;
                    String message = "", status = "success";
                    
                    //Obteniendo parámetros
                    School school = new SchoolController().getOne(Integer.parseInt(request.getParameter("school")));
                    Boolean viable = request.getParameter("viable") != null;
                    Complaint_type type = new ComplaintTypeController().getOne(Integer.parseInt(request.getParameter("complaint_type")));
                    User user = (User)(request.getSession().getAttribute("session"));
                    String description = String.valueOf(request.getParameter("description"));
                    String authprov[] = new String[0];
                    if (viable && type.getTaken_action().equals("Remitir con autoridad competente")){
                        authprov = request.getParameterValues("authority[]");
                    }
                    else if (viable && type.getTaken_action().equals("Tomar contacto con ISP y colegio")) {
                        authprov = request.getParameterValues("provider[]");
                    }
                    
                    //Validaciones
                    if (description.isEmpty()) {
                        request.setAttribute("descriptionE","Descripción: no se permiten campos vacíos");
                        flag = false;
                    }
                    if (viable && authprov == null) {
                        request.setAttribute("authprovE","Debe elegir al menos un elemento de la lista");
                        flag = false;
                    }
                    
                    if(flag){
                        boolean temp;
                        
                        //Agregando denuncia
                        if(new CallController().addCall(school, viable, type, user, description)) {
                            message = "Denuncia guardada. El reporte se generará en unos momentos.";
                            
                            //Llamada recién hecha
                            Call call = new CallController().getLast();

                            //Devolviendo id de la denuncia a la vista, usado para generar el reporte
                            request.setAttribute("callId", call.getId());
                            
                            //Si la denuncia es viable, agregar las organizaciones a notificar
                            if(viable) {
                                
                                for (String id : authprov) {
                                    if (type.getTaken_action().equals("Remitir con autoridad competente")) {
                                        if (!(new AuthAsignController().addAuthAsign(call, new AuthorityController().getOne(Integer.parseInt(id))))) {
                                            message = "Error al guardar autoridad relacionada a denuncia";
                                            status = "error";
                                        }
                                    }
                                    else {
                                        if (!(new ProvAsignController().addProvAsign(call, new ProviderController().getOne(Integer.parseInt(id))))) {
                                            message = "Error al guardar proveedor relacionado a denuncia";
                                            status = "error";
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            message = "La denuncia no pudo ser guardada";
                            status = "error";
                        }
                    }
                    
                    request.setAttribute("message", message);
                    request.setAttribute("status", status);
                    request.getRequestDispatcher("/personal/newcall.jsp").forward(request, response);
                }
                
                //Nueva denuncia registrada por anónimo
                else if (action.equals("Guardar denuncia anonima")){
                    boolean flag = true;
                    String message = "", status = "success";
                    
                    //Obteniendo parámetros
                    School school = new SchoolController().getOne(Integer.parseInt(request.getParameter("school")));
                    Boolean viable = false;
                    Complaint_type type = new ComplaintTypeController().getOne(Integer.parseInt(request.getParameter("complaint_type")));
                    User user = new UserController().getOne(1); //La relaciona a root provisionalmente
                    String description = String.valueOf(request.getParameter("description"));
                    
                    //Validaciones
                    if (description.isEmpty()) {
                        request.setAttribute("descriptionE","Descripción: no se permiten campos vacíos");
                        flag = false;
                    }
                    
                    if(flag){
                        boolean temp;
                        
                        //Agregando denuncia
                        if(new CallController().addCall(school, viable, type, user, description)) {
                            
                            //Llamada recién hecha
                            final Call call = new CallController().getLast();
                            
                            //Creando thread para notificar a todo el personal que se ha creado una nueva denuncia
                            ExecutorService emailExecutor = Executors.newCachedThreadPool();

                            // from you getSalesUserData() method
                            emailExecutor.execute(new Runnable() {
                                @Override
                                public void run() {
                                    try {
                                        for (User user : new UserController().getAllPersonal()) {
                                            Mailer.sendMail(call, user);
                                        }
                                    } catch (Exception e) {
                                        System.err.println(e);
                                    }
                                }
                            });
                            
                            message = "Denuncia guardada. Cuando sea procesada, podrá obtener información de la misma "
                                    + "introduciendo el código de denuncia en el apartado Ver Denuncia. Su código es: " + call.getCode();
                            
                            //Guardando código en sesión por si el usuario es majirulo
                            request.getSession().setAttribute("callCode", call.getCode());
                            
                        }
                        else {
                            message = "La denuncia no pudo ser guardada";
                            status = "error";
                        }
                    }
                    
                    request.setAttribute("message", message);
                    request.setAttribute("status", status);
                    request.getRequestDispatcher("/").forward(request, response);
                }
                
                //Procesar denuncia registrada por persona anónima
                else if (action.equals("Procesar")){
                    boolean flag = true;
                    String message = "", status = "success";
                    
                    //Denuncia actual, guardada en sesión
                    Call call = (Call)request.getSession().getAttribute("call");
                    
                    //Obteniendo parámetros
                    Boolean viable = request.getParameter("viable") != null;
                    User user = (User)(request.getSession().getAttribute("session"));
                    String authprov[] = new String[0];
                    if (viable && call.getComplaint_type().getTaken_action().equals("Remitir con autoridad competente")){
                        authprov = request.getParameterValues("authority[]");
                    }
                    else if (viable && call.getComplaint_type().getTaken_action().equals("Tomar contacto con ISP y colegio")) {
                        authprov = request.getParameterValues("provider[]");
                    }
                    
                    //Validaciones
                    if (viable && authprov == null) {
                        request.setAttribute("authprovE","Debe elegir al menos un elemento de la lista");
                        flag = false;
                    }
                    
                    if(flag){
                        boolean temp;
                        
                        //Agregando denuncia
                        if(new CallController().updateProcessedCall(call.getId(), viable, user)) {
                            message = "Denuncia procesada. El reporte se generará en unos momentos.";
                            

                            //Devolviendo id de la denuncia a la vista, usado para generar el reporte
                            request.setAttribute("callId", call.getId());
                            
                            //Si la denuncia es viable, agregar las organizaciones a notificar
                            if(viable) {
                                
                                for (String id : authprov) {
                                    if (call.getComplaint_type().getTaken_action().equals("Remitir con autoridad competente")) {
                                        if (!(new AuthAsignController().addAuthAsign(call, new AuthorityController().getOne(Integer.parseInt(id))))) {
                                            message = "Error al guardar autoridad relacionada a denuncia";
                                            status = "error";
                                        }
                                    }
                                    else {
                                        if (!(new ProvAsignController().addProvAsign(call, new ProviderController().getOne(Integer.parseInt(id))))) {
                                            message = "Error al guardar proveedor relacionado a denuncia";
                                            status = "error";
                                        }
                                    }
                                }
                            }
                        }
                        else {
                            message = "La denuncia no pudo ser procesada";
                            status = "error";
                        }
                    }
                    
                    request.setAttribute("message", message);
                    request.setAttribute("status", status);
                    
                    if (flag) {
                        request.getRequestDispatcher("/personal/newcall.jsp").forward(request, response);
                    }
                    else {
                        //Si hubieron errores de validacion, debe recargar la vista, recuperando los valores que llevaba al cargarse
                        request.setAttribute("id", call.getId());
                        request.setAttribute("school", call.getSchool());
                        request.setAttribute("complaint_type",call.getComplaint_type());
                        request.setAttribute("description", call.getDescription());
                        request.setAttribute("taken_action",call.getComplaint_type().getTaken_action());
                        
                        request.getRequestDispatcher("/personal/callprocess.jsp").forward(request, response);
                    }
                }
                
                else {
                    request.getRequestDispatcher("/").forward(request, response);
                }
            }
            else {
                request.getRequestDispatcher("/").forward(request, response);
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
