package com.example.demo.model.mongoobjects;

public class CityObject {

    private int zip_code;
    private String city;

    public CityObject(){}

    public int getZip_code() {
        return zip_code;
    }

    public void setZip_code(int zip_code) {
        this.zip_code = zip_code;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }
}