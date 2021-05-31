package com.example.demo.model.mongoobjects;

public class ClassRoomObject {
    private CampusObject campus;
    private String name;
    private Boolean is_available;

    public ClassRoomObject(){}

    public CampusObject getCampus() {
        return campus;
    }

    public void setCampus(CampusObject campus) {
        this.campus = campus;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getIs_available() {
        return is_available;
    }

    public void setIs_available(Boolean is_available) {
        this.is_available = is_available;
    }
}
