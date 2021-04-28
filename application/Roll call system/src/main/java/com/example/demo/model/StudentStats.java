package com.example.demo.model;

import java.util.Map;

public class StudentStats {
    private int participationrate;

    private Map<String,Integer> courseparticipationrate;

    public StudentStats(Integer overallparticipationrate, Map<String, Integer> participationrates) {
        this.participationrate=overallparticipationrate;
        this.courseparticipationrate=participationrates;
    }

    public int getParticipationrate() {
        return participationrate;
    }

    public void setParticipationrate(int participationrate) {
        this.participationrate = participationrate;
    }

    public Map<String, Integer> getCourseparticipationrate() {
        return courseparticipationrate;
    }

    public void setCourseparticipationrate(Map<String, Integer> courseparticipationrate) {
        this.courseparticipationrate = courseparticipationrate;
    }
}
