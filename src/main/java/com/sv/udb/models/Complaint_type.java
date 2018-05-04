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
public class Complaint_type {
    int id;
    String name;
    String taken_action;
    boolean state;

    public Complaint_type() {
    }

    public Complaint_type(int id, String name, String taken_action, boolean state) {
        this.id = id;
        this.name = name;
        this.taken_action = taken_action;
        this.state = state;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTaken_action() {
        return taken_action;
    }

    public void setTaken_action(String taken_action) {
        this.taken_action = taken_action;
    }

    public boolean isState() {
        return state;
    }

    public void setState(boolean state) {
        this.state = state;
    }

    @Override
    public String toString() {
        return name;
    }
}
