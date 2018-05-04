/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.controllers;

import com.sv.udb.models.School;
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
public class SchoolController {
    Connection conn;
    
    //Constantes que identifican el tipo de búsqueda en search
    public static final int BY_NAME = 1;
    public static final int BY_ADDRESS = 2;
    public static final int BY_STATE = 3;
    public static final int NO_FIELD = 4;

    public SchoolController() {
        conn = new ConnectionDB().getConn();
    }
    
    /**
     * Devuelve todas las escuelas activas
     * @param activeOnly
     * @return true si se requieren solo los resultados activos, false si se requieren todos
     */
    public List<School> getAll (boolean activeOnly){
        List<School> resp = new ArrayList<>();
        try {
            //String que definirá si se devuelven solo los activos o no
            String actCondition = activeOnly ? " WHERE state = 1" : "";
            
            PreparedStatement cmd = this.conn.prepareStatement("SELECT * FROM schools" + actCondition);
            ResultSet rs = cmd.executeQuery();
            while (rs.next()) {
                resp.add(new School(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getBoolean(4)));
            }
        } catch (SQLException ex) {
            System.err.println("Error al consultar escuelas: " + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException ex) {
                System.err.println("Error al cerrar la conexión al consultar escuelas: " + ex.getMessage());
            }
        }
        return resp;
    }
    
    public School getOne(int id){
        School resp = null;
        try {
            PreparedStatement cmd = this.conn.prepareStatement("SELECT * FROM schools where id = ?");
            cmd.setInt(1, id);
            ResultSet rs = cmd.executeQuery();
            while (rs.next()) {
                resp = new School(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getBoolean(4));
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
    
    /**
     * Devuelve todas las escuelas bajo parámetros de búsqueda
     * @param type int indicando el campo por el que se filtrará
     * @param param El texto con el que se compararán los filtros
     * @param activeOnly true si se requieren solo los resultados activos, false si se requieren todos
     * @return 
     */
    public List<School> search (int type, Object param, boolean activeOnly){
        List<School> resp = new ArrayList<>();
        try {
            //String que definirá si se devuelven solo los activos o no
            String actCondition = activeOnly ? " AND state = 1" : "";
            
            PreparedStatement cmd = null;
            
            switch (type) {
                case SchoolController.BY_NAME:
                    cmd = this.conn.prepareStatement("SELECT * FROM schools WHERE name LIKE ?" + actCondition);
                    cmd.setString(1, String.valueOf("%" + param + "%"));
                    break;
                case SchoolController.BY_ADDRESS:
                    cmd = this.conn.prepareStatement("SELECT * FROM schools WHERE address LIKE ?" + actCondition);
                    cmd.setString(1, String.valueOf("%" + param + "%"));
                    break;
                case SchoolController.BY_STATE:
                    cmd = this.conn.prepareStatement("SELECT * FROM schools WHERE state = ?");
                    if ((String.valueOf(param)).equals("Activo"))
                        cmd.setInt(1, 1);
                    else
                        cmd.setInt(1, 0);
                    break;
                default:
                    cmd = this.conn.prepareStatement("SELECT * FROM schools WHERE true" + actCondition);
                    break;
            }
            
            ResultSet rs = cmd.executeQuery();
            while (rs.next()) {
                resp.add(new School(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getBoolean(4)));
            }
        } catch (SQLException ex) {
            System.err.println("Error al consultar escuelas: " + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException ex) {
                System.err.println("Error al cerrar la conexión al consultar escuelas: " + ex.getMessage());
            }
        }
        return resp;
    }
    
    
    public boolean addSchool(String name,String address, boolean state){
        boolean resp = false;
        
        try {
            PreparedStatement cmd = this.conn.prepareStatement("insert into schools values(null,?,?,?)");
            cmd.setString(1, name);
            cmd.setString(2,address);
            cmd.setBoolean(3, state);
            cmd.executeUpdate();
            resp = true;
        } catch (Exception ex) {
            System.err.println("Error al guardar escuela" + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException e) {
                System.err.println("Error al cerrar la conexion en escuela: " + e.getMessage());
            }
        }
        
        return resp;
    }
    
    public boolean updateSchool(int id, String name, String address, boolean state){
        boolean resp = false;
        
        try {
            PreparedStatement cmd = this.conn.prepareStatement("update schools set name = ?,address=?, state=? where id = ?");
            cmd.setString(1, name);
            cmd.setString(2,address);
            cmd.setBoolean(3, state);
            cmd.setInt(4, id);
            cmd.executeUpdate();
            resp = true;
        } catch (Exception ex) {
            System.err.println("Error al modificar proveedor" + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException e) {
                System.err.println("Error al cerrar la conexion en proveedor: " + e.getMessage());
            }
        }
        
        return resp;
    }
    
}
