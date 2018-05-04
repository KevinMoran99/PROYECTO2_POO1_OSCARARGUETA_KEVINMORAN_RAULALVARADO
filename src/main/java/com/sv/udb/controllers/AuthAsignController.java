/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.controllers;

import com.sv.udb.models.Authority;
import com.sv.udb.models.Authority_asign;
import com.sv.udb.models.Call;
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
public class AuthAsignController {
    Connection conn;

    public AuthAsignController() {
        conn = new ConnectionDB().getConn();
    }
    
    public List<Authority_asign> getAsigns (Call call) {
        List<Authority_asign> resp = new ArrayList<>();
        try {
            PreparedStatement cmd = this.conn.prepareStatement("SELECT * FROM authority_asigns WHERE call_id = ?");
            cmd.setInt(1, call.getId());
            ResultSet rs = cmd.executeQuery();
            while (rs.next()) {
                resp.add(new Authority_asign(
                        rs.getInt(1), 
                        new CallController().getOne(rs.getInt(2)), 
                        new AuthorityController().getOne(rs.getInt(3))
                ));
            }
        } catch (SQLException ex) {
            System.err.println("Error al consultar autoridades relacionadas a la denuncia: " + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException ex) {
                System.err.println("Error al cerrar la conexión al consultar autoridades relacionadas a la denuncia: " + ex.getMessage());
            }
        }
        return resp;
    } 
    
    public boolean addAuthAsign (Call call, Authority authority) {
        boolean resp = false;
        
        try {
            PreparedStatement cmd = this.conn.prepareStatement("INSERT INTO authority_asigns VALUES(null,?,?)");
            cmd.setInt(1, call.getId());
            cmd.setInt(2, authority.getId());
            cmd.executeUpdate();
            resp = true;
        } catch (Exception ex) {
            System.err.println("Error al guardar autoridades relacionadas a denuncia" + ex.getMessage());
        } finally {
            try {
                if (this.conn != null) {
                    if (!this.conn.isClosed()) {
                        this.conn.close();
                    }
                }
            } catch (SQLException e) {
                System.err.println("Error al cerrar la conexion al guardar autoridades relacionadas a denuncia: " + e.getMessage());
            }
        }
        
        return resp;
    }
}
