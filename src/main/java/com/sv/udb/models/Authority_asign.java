/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.models;

/**
 *
 * @author kevin
 */
public class Authority_asign {
    int id;
    Call call;
    Authority authority;

    public Authority_asign() {
    }

    public Authority_asign(int id, Call call, Authority authority) {
        this.id = id;
        this.call = call;
        this.authority = authority;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Call getCall() {
        return call;
    }

    public void setCall(Call call) {
        this.call = call;
    }

    public Authority getAuthority() {
        return authority;
    }

    public void setAuthority(Authority authority) {
        this.authority = authority;
    }
    
    
}
