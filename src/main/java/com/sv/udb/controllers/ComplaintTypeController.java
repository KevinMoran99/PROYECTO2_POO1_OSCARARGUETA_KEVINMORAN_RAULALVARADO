/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.controllers;

import com.sv.udb.models.Complaint_type;
import com.sv.udb.resources.ConnectionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author kevin
 */
public class ComplaintTypeController {
    Connection conn;
//Constantes que identifican el tipo de búsqueda en search
    public static final int BY_NAME = 1;
    public static final int BY_ACTION = 2;
    public static final int BY_STATE = 3;
    public static final int NO_FIELD = 4;
    public ComplaintTypeController() {
        conn = new ConnectionDB().getConn();
    }
    
    public List<Complaint_type> getAll (boolean activeOnly) {
        List<Complaint_type> resp = new ArrayList<>();
        try {
            //String que definirá si se devuelven solo los activos o no
            String actCondition = activeOnly ? " WHERE state = 1" : "";
            
            PreparedStatement cmd = this.conn.prepareStatement("SELECT * FROM complaint_types" + actCondition);
            ResultSet rs = cmd.executeQuery();
            while (rs.next()) {
                resp.add(new Complaint_type(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getBoolean(4)));
            }
        } catch (SQLException ex) {
            System.err.println("Error al consultar tipos de consulta: " + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException ex) {
                System.err.println("Error al cerrar la conexión al consultar tipos de consulta: " + ex.getMessage());
            }
        }
        return resp;
    }
    
    public Complaint_type getOne(int id){
        Complaint_type resp = null;
        try {
            PreparedStatement cmd = this.conn.prepareStatement("SELECT * FROM complaint_types where id = ?");
            cmd.setInt(1, id);
            ResultSet rs = cmd.executeQuery();
            while (rs.next()) {
                resp = new Complaint_type(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getBoolean(4));
            }
        } catch (SQLException ex) {
            System.err.println("Error al consultar: " + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException ex) {
                System.err.println("Error al cerrar la conexión");
            }
        }
        return resp;
    }
    public boolean addComplaintType(String name,String taken_action, boolean state){
        boolean resp = false;
        
        try {
            PreparedStatement cmd = this.conn.prepareStatement("insert into complaint_types values(null,?,?,?)");
            cmd.setString(1, name);
            cmd.setString(2,taken_action);
            cmd.setBoolean(3, state);
            cmd.executeUpdate();
            resp = true;
        } catch (Exception ex) {
            System.err.println("Error al guardar tipo de queja" + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException e) {
                System.err.println("Error al cerrar la conexion en tipo de queja: " + e.getMessage());
            }
        }
        
        return resp;
    }
    
    public boolean updateComplaintType(int id, String name, String taken_action, boolean state){
        boolean resp = false;
        
        try {
            PreparedStatement cmd = this.conn.prepareStatement("update complaint_types set name = ?,taken_action=?, state=? where id = ?");
            cmd.setString(1, name);
            cmd.setString(2,taken_action);
            cmd.setBoolean(3, state);
            cmd.setInt(4, id);
            cmd.executeUpdate();
            resp = true;
        } catch (Exception ex) {
            System.err.println("Error al modificar tipo de queja" + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException e) {
                System.err.println("Error al cerrar la conexion en tipo de queja: " + e.getMessage());
            }
        }
        
        return resp;
    }
    
    
    public List<Complaint_type> search (int type, Object param, boolean activeOnly){
        List<Complaint_type> resp = new ArrayList<>();
        try {
            //String que definirá si se devuelven solo los activos o no
            String actCondition = activeOnly ? " AND state = 1" : "";
            
            PreparedStatement cmd = null;
            
            switch (type) {
                case ComplaintTypeController.BY_NAME:
                    cmd = this.conn.prepareStatement("SELECT * FROM complaint_types WHERE name LIKE ?" + actCondition);
                    cmd.setString(1, String.valueOf("%" + param + "%"));
                    break;
                case ComplaintTypeController.BY_ACTION:
                    cmd = this.conn.prepareStatement("SELECT * FROM complaint_types WHERE taken_action LIKE ?" + actCondition);
                    cmd.setString(1, String.valueOf("%" + param + "%"));
                    break;
                case ComplaintTypeController.BY_STATE:
                    cmd = this.conn.prepareStatement("SELECT * FROM complaint_types WHERE state = ?");
                    if ((String.valueOf(param)).equals("Activo")){
                        cmd.setInt(1, 1);
                    }else{
                        cmd.setInt(1, 0);
                    }
                    break;
                default:
                    cmd = this.conn.prepareStatement("SELECT * FROM complaint_types WHERE true" + actCondition);
                    break;
            }
            
            ResultSet rs = cmd.executeQuery();
            while (rs.next()) {
                resp.add(new Complaint_type(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getBoolean(4)));
            }
        } catch (SQLException ex) {
            System.err.println("Error al consultar tipos de queja: " + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException ex) {
                System.err.println("Error al cerrar la conexión al consultar tipo de queja: " + ex.getMessage());
            }
        }
        return resp;
    }
    
}
