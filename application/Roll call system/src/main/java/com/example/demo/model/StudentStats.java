package com.example.demo.model;

import java.util.List;
import java.util.Map;
import java.util.Set;

public class StudentStats {
    private int participationrate;

    private List<Course> courseparticipationrates;

    public StudentStats(Integer overallparticipationrate, List<Course> participationrates) {
        this.participationrate=overallparticipationrate;
        this.courseparticipationrates=participationrates;
    }

    public int getParticipationrate() {
        return participationrate;
    }

    public void setParticipationrate(int participationrate) {
        this.participationrate = participationrate;
    }

    public List<Course> getCourseparticipationrates() {
        return courseparticipationrates;
    }

    public void setCourseparticipationrates(List<Course> courseparticipationrates) {
        this.courseparticipationrates = courseparticipationrates;
    }
}
