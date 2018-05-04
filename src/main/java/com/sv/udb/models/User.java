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
public class User {
    int id;
    String name, lastname, email, pass;
    User_type user_type;
    boolean state;

    public User() {
    }

    /**
     * 
     * @param id
     * @param name
     * @param lastname
     * @param email
     * @param pass
     * @param user_type 
     * @param state 
     */
    public User(int id, String name, String lastname, String email, String pass, User_type user_type, boolean state) {
        this.id = id;
        this.name = name;
        this.lastname = lastname;
        this.email = email;
        this.pass = pass;
        this.user_type = user_type;
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

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public User_type getUser_type() {
        return user_type;
    }

    public void setUser_type(User_type user_type) {
        this.user_type = user_type;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
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
