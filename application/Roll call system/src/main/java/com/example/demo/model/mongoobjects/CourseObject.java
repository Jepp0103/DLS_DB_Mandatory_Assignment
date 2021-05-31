package com.example.demo.model.mongoobjects;

public class CourseObject {
    private String name;
    private int ects;

    public CourseObject(){}

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getEcts() {
        return ects;
    }

    public void setEcts(int ects) {
        this.ects = ects;
    }
}
