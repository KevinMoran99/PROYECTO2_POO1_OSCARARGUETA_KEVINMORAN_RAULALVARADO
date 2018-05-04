/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.controllers;

import com.sv.udb.models.Provider;
import com.sv.udb.models.Call;
import com.sv.udb.models.Provider_asign;
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
public class ProvAsignController {
    Connection conn;

    public ProvAsignController() {
        conn = new ConnectionDB().getConn();
    }
    
    public List<Provider_asign> getAsigns (Call call) {
        List<Provider_asign> resp = new ArrayList<>();
        try {
            PreparedStatement cmd = this.conn.prepareStatement("SELECT * FROM provider_asigns WHERE call_id = ?");
            cmd.setInt(1, call.getId());
            ResultSet rs = cmd.executeQuery();
            while (rs.next()) {
                resp.add(new Provider_asign(
                        rs.getInt(1), 
                        new CallController().getOne(rs.getInt(2)), 
                        new ProviderController().getOne(rs.getInt(3)), 
                        rs.getBoolean(4)
                ));
            }
        } catch (SQLException ex) {
            System.err.println("Error al consultar proveedores relacionados a denuncia: " + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException ex) {
                System.err.println("Error al cerrar la conexión al consultar proveedores relacionados a denuncia: " + ex.getMessage());
            }
        }
        return resp;
    }
    
    public boolean addProvAsign (Call call, Provider provider) {
        boolean resp = false;
        
        try {
            PreparedStatement cmd = this.conn.prepareStatement("INSERT INTO provider_asigns VALUES(null,?,?,0)");
            cmd.setInt(1, call.getId());
            cmd.setInt(2, provider.getId());
            cmd.executeUpdate();
            resp = true;
        } catch (Exception ex) {
            System.err.println("Error al guardar proveedores relacionados a denuncia" + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException e) {
                System.err.println("Error al cerrar la conexion al guardar proveedores relacionados a denuncia: " + e.getMessage());
            }
        }
        
        return resp;
    }
    
    public boolean updateProvAsign (int id, boolean content_removed) {
        boolean resp = false;
        
        try {
            PreparedStatement cmd = this.conn.prepareStatement("UPDATE provider_asigns SET content_removed = ? WHERE id = ?");
            cmd.setBoolean(1, content_removed);
            cmd.setInt(2, id);
            cmd.executeUpdate();
            resp = true;
        } catch (Exception ex) {
            System.err.println("Error al modificar proveedores relacionados a denuncia: " + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException e) {
                System.err.println("Error al cerrar la conexion al modificar proveedores relacionados a denuncia: : " + e.getMessage());
            }
        }
        
        return resp;
    }
}
