package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.*;
import java.util.Date;

@JsonIgnoreProperties({"hibernateLazyInitializer","handler"})
@Entity
@Table(name="address")
public class Address {
    @Id
    @Column(name="id")
    private int id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "city_id", nullable = false)
    private City city_id; //Can't use int but have to use object

//    @Column(name="city_id")
//    private int city_id;

    @Column(name="street_name")
    private String street_name;
    @Column(name="street_number")
    private int street_number;
    @Column(name="registred_on")
    private Date registred_on;

//    @JsonIgnore
//    public int getId() {
//        return id;
//    }
//
//    public void setId(int id) {
//        this.id = id;
//    }

    @JsonIgnore
    public City getCity_id() {
        return city_id;
    }

    public void setCity_id(City city_id) {
        this.city_id = city_id;
    }

    @JsonProperty
    public String getStreet_name() {
        return street_name;
    }

    public void setStreet_name(String street_name) {
        this.street_name = street_name;
    }

    @JsonIgnore
    public int getStreet_number() {
        return street_number;
    }

    public void setStreet_number(int street_number) {
        this.street_number = street_number;
    }

    @JsonIgnore
    public Date getRegistred_on() {
        return registred_on;
    }

    public void setRegistred_on(Date registred_on) {
        this.registred_on = registred_on;
    }
}
