/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sv.udb.models;

import java.util.Date;

/**
 *
 * @author kevin
 */
public class Call {
    int id;
    School school;
    boolean viable;
    Complaint_type complaint_type;
    User user;
    String description;
    Date call_date;
    boolean talk_given;

    public Call() {
    }
    
    public Call(int id, School school, boolean viable, Complaint_type complaint_type, User user, String description, Date call_date, boolean talk_given) {
        this.id = id;
        this.school = school;
        this.viable = viable;
        this.complaint_type = complaint_type;
        this.user = user;
        this.description = description;
        this.call_date = call_date;
        this.talk_given = talk_given;
    }
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public School getSchool() {
        return school;
    }

    public void setSchool(School school) {
        this.school = school;
    }

    public boolean getViable() {
        return viable;
    }

    public void setViable(boolean viable) {
        this.viable = viable;
    }

    public Complaint_type getComplaint_type() {
        return complaint_type;
    }

    public void setComplaint_type(Complaint_type complaint_type) {
        this.complaint_type = complaint_type;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCall_date() {
        return call_date;
    }

    public void setCall_date(Date call_date) {
        this.call_date = call_date;
    }

    public boolean isTalk_given() {
        return talk_given;
    }

    public void setTalk_given(boolean talk_given) {
        this.talk_given = talk_given;
    }
    
    @Override
    public String toString() {
        return description;
    }
    
    
}
