package com.example.demo.model;

public class StudentGpsRegister { //Needed as a class in order to create a post request body to send

    private int studentId;
    private int teacherId;
    private double studentLatitude;
    private double studentLongitude;
    private String withinRange;

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

    public double getStudentLatitude() {
        return studentLatitude;
    }

    public void setStudentLatitude(double studentLatitude) {
        this.studentLatitude = studentLatitude;
    }

    public double getStudentLongitude() {
        return studentLongitude;
    }

    public void setStudentLongitude(double studentLongitude) {
        this.studentLongitude = studentLongitude;
    }

    public String getWithinRange() {
        return withinRange;
    }

    public void setWithinRange(String withinRange) {
        this.withinRange = withinRange;
    }


}
