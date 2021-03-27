package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@JsonIgnoreProperties({"hibernateLazyInitializer","handler"})
@Entity
@Table(name="student")
public class Student {
    @Id
    @Column(name="id")
    private int id;
    @Column(name="email_address")
    private String email_address;
    @Column(name="class_id")
    private int class_id;
    @Column(name="network_id")
    private int network_id;
    @Column(name="gps_coordinates_id")
    private int gps_coordinates_id;
    @Column(name="forename")
    private String forename;
    @Column(name="surname")
    private String surname;
    @Column(name="phone_number")
    private String phone_number;

    @JsonIgnore
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @JsonProperty
    public String getEmail_address() {
        return email_address;
    }

    public void setEmail_address(String email_address) {
        this.email_address = email_address;
    }

    @JsonProperty
    public int getClass_id() {
        return class_id;
    }

    public void setClass_id(int class_id) {
        this.class_id = class_id;
    }

    @JsonIgnore
    public int getNetwork_id() {
        return network_id;
    }

    public void setNetwork_id(int network_id) {
        this.network_id = network_id;
    }

    @JsonIgnore
    public int getGps_coordinates_id() {
        return gps_coordinates_id;
    }

    public void setGps_coordinates_id(int gps_coordinates_id) {
        this.gps_coordinates_id = gps_coordinates_id;
    }

    @JsonProperty
    public String getForename() {
        return forename;
    }

    public void setForename(String forename) {
        this.forename = forename;
    }

    @JsonProperty
    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    @JsonProperty
    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }
}
