package com.example.demo.model.mongoobjects;

public class CampusObject {

    private AddressObject address;
    private String faculty;

    public CampusObject(AddressObject address, String faculty) {
        this.address = address;
        this.faculty = faculty;
    }

    public AddressObject getAddress() {
        return address;
    }

    public void setAddress(AddressObject address) {
        this.address = address;
    }

    public String getFaculty() {
        return faculty;
    }

    public void setFaculty(String faculty) {
        this.faculty = faculty;
    }
}
