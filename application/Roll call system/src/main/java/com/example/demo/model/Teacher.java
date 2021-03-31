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
@Table(name="teacher")
public class Teacher {
    @Id
    @Column(name="id")
    private int id;
    @Column(name="email_address")
    private String email_address;
    @Column(name="gps_coordinates_id")
    private Integer gps_coordinates_id;
    @Column(name="forename")
    private String forename;
    @Column(name="surname")
    private String surname;
    @Column(name="phone_number")
    private String phone_number;

    @JsonProperty
    public String getEmail_address() {
        return email_address;
    }

    public void setEmail_address(String email_address) {
        this.email_address = email_address;
    }
    @JsonIgnore
    public Integer getGps_coordinates_id() {
        return gps_coordinates_id;
    }

    public void setGps_coordinates_id(Integer gps_coordinates_id) {
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