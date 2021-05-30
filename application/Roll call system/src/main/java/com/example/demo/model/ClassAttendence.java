package com.example.demo.model;

import java.util.List;

public class ClassAttendence {

    private Integer participationrate;

    private TeacherClassCourseResponse courseclass;

    public ClassAttendence(Integer participationrate, TeacherClassCourseResponse courseclass) {
        this.participationrate = participationrate;
        this.courseclass = courseclass;
    }

    public Integer getParticipationrate() {
        return participationrate;
    }

    public void setParticipationrate(Integer participationrate) {
        this.participationrate = participationrate;
    }

    public TeacherClassCourseResponse getCourseclass() {
        return courseclass;
    }

    public void setCourseclass(TeacherClassCourseResponse courseclass) {
        this.courseclass = courseclass;
    }
}
