package com.example.demo.model;

import java.util.List;

public class TeacherStats {
    private List<ClassAttendence> classAttendences;

    public TeacherStats(List<ClassAttendence> classAttendences) {
        this.classAttendences=classAttendences;
    }

    public List<ClassAttendence> getclassAttendences() {
        return classAttendences;
    }

    public void setclassAttendences(List<ClassAttendence> classAttendences) {
        this.classAttendences = classAttendences;
    }
}
