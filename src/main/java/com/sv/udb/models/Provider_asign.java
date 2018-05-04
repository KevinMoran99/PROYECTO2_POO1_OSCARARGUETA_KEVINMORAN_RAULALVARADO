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
public class Provider_asign {
    int id;
    Call call;
    Provider provider;
    boolean content_removed;

    public Provider_asign() {
    }

    public Provider_asign(int id, Call call, Provider provider, boolean content_removed) {
        this.id = id;
        this.call = call;
        this.provider = provider;
        this.content_removed = content_removed;
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

    public Provider getProvider() {
        return provider;
    }

    public void setProvider(Provider provider) {
        this.provider = provider;
    }

    public boolean isContent_removed() {
        return content_removed;
    }

    public void setContent_removed(boolean content_removed) {
        this.content_removed = content_removed;
    }

    //Implementación un poco rara, pero útil en la tabla de proveedores vinculados a denuncias
    @Override
    public String toString() {
        return provider.getName();
    }
    
    
    
}
