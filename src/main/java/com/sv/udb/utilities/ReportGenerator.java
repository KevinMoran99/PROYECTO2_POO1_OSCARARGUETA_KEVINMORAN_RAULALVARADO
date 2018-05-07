/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.utilities;

import com.sv.udb.controllers.CallController;
import com.sv.udb.models.Call;
import com.sv.udb.resources.ConnectionDB;
import java.awt.Desktop;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletContext;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRPrintPage;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author kevin
 */
public class ReportGenerator {
    
    //Constantes que determinan que string usar de input para obtener cada reporte
    public static final String DETAIL = "Generar reporte";
    public static final String TYPE = "Denuncias por tipo";
    public static final String VIABILITY= "Denuncias por viabilidad";
    public static final String TOP = "Top 10 instituciones con mas denuncias";
    
    
    
    private static void removeBlankPage(List<JRPrintPage> pages) {
        for (Iterator<JRPrintPage> i = pages.iterator(); i.hasNext();) {
            JRPrintPage page = i.next();
            if (page.getElements().size() == 0) {
                i.remove();
            }
        }
    }
    
    
    public static byte[] detailReport(ServletContext ctx, int id) throws SQLException {
        HashMap map;
        byte[] bytes = null;
        
        //Conexion
        Connection conn = new ConnectionDB().getConn();
        
        try {
            //Ubicación del jasper
            String jasperFileName = ctx.getRealPath("/reports/Detail.jasper");
            
            //Instanciando llamada
            Call call = new CallController().getOne(id);
            
            //seteando los parametros que recibe el reporte
            map = new HashMap();
            map.put("id",String.valueOf(id));
            map.put("viable", call.getViable());
            map.put("school", call.getSchool().toString());
            map.put("address", call.getSchool().getAddress());
            map.put("date", Utils.formatDate(call.getCall_date(), Utils.DATE_UI));
            map.put("type", call.getComplaint_type().toString());
            map.put("description", call.getDescription());
            map.put("user", call.getUser().getName() + " " + call.getUser().getLastname());
            map.put("talk", call.isTalk_given());
            map.put("conn", conn);
            
            map.put("SUBREPORT_DIR", ctx.getRealPath("\\reports\\"));
            
            bytes = JasperRunManager.runReportToPdf(jasperFileName, map, conn);
            
            
        } catch (Exception e) {
            System.out.println(e);
        }
        finally {
            if(!conn.isClosed())
            {
                conn.close();
            }
            
            return bytes;
        }
    }
    
    public static byte[] typeReport(ServletContext ctx, String reportName, String from, String to) throws SQLException {
        HashMap map;
        byte[] bytes = null;
        
        //Conexion
        Connection conn = new ConnectionDB().getConn();
        
        try {
            String jasperFileName="";
            switch(reportName){
                case TYPE:
                    jasperFileName = ctx.getRealPath("/reports/Type.jasper");
                    break;
                case VIABILITY:
                    jasperFileName = ctx.getRealPath("/reports/Viability.jasper");
                    break;
                case TOP:
                    jasperFileName = ctx.getRealPath("/reports/Top.jasper");
                    break;
            }
            
            map = new HashMap();
            map.put("init_date",from);
            map.put("end_date", to);
            
            bytes = JasperRunManager.runReportToPdf(jasperFileName, map, conn);
            
            
        } catch (Exception e) {
            System.out.println(e);
        }
        finally {
            if(!conn.isClosed())
            {
                conn.close();
            }
            
            return bytes;
        }
    }
}
