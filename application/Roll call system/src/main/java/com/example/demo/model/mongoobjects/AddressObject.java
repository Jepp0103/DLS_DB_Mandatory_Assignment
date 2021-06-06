package com.example.demo.model.mongoobjects;
public class AddressObject {
    private String street_name;
    private int street_number;
    private String registred_on;
    private String additional_details;
    private CityObject city;

    public AddressObject(){}

    public String getStreet_name() {
        return street_name;
    }

    public void setStreet_name(String street_name) {
        this.street_name = street_name;
    }

    public int getStreet_number() {
        return street_number;
    }

    public void setStreet_number(int street_number) {
        this.street_number = street_number;
    }

    public String getRegistred_on() {
        return registred_on;
    }

    public void setRegistred_on(String registred_on) {
        this.registred_on = registred_on;
    }

    public String getAdditional_details() {
        return additional_details;
    }

    public void setAdditional_details(String additional_details) {
        this.additional_details = additional_details;
    }

    public CityObject getCity() {
        return city;
    }

    public void setCity(CityObject city) {
        this.city = city;
    }
}