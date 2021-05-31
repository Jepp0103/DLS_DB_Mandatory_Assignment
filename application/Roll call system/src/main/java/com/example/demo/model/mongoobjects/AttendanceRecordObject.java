package com.example.demo.model.mongoobjects;

import com.example.demo.model.mongomodels.StudentMongo;

public class AttendanceRecordObject {

    AttendanceRecordObject(){}

    private StudentMongo student;
    private Boolean is_attending;

    public StudentMongo getStudent() {
        return student;
    }

    public void setStudent(StudentMongo student) {
        this.student = student;
    }

    public Boolean getIs_attending() {
        return is_attending;
    }

    public void setIs_attending(Boolean is_attending) {
        this.is_attending = is_attending;
    }
}
