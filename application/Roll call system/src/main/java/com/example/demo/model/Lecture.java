package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.sql.Date;
import java.sql.Time;

@JsonIgnoreProperties({"hibernateLazyInitializer","handler"})
@Entity
@Table(name="lecture")
public class Lecture {
    @Id
    @Column(name="id")
    private int id;
    @Column(name="course_id")
    private int course_id;
    @Column(name="classroom_id")
    private int classroom_id;
    @Column(name="name")
    private String name;
    @Column(name="date")
    private Date date;
    @Column(name="time_start")
    private Time time_start;
    @Column(name="time_end")
    private Time time_end;
    @Column(name="time_zone")
    private int time_zone;
    @Column(name="length")
    private int length;
    @Column(name="code")
    private String code;

    @JsonIgnore
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @JsonIgnore
    public int getCourse_id() {
        return course_id;
    }

    public void setCourse_id(int course_id) {
        this.course_id = course_id;
    }

    @JsonIgnore
    public int getClassroom_id() {
        return classroom_id;
    }

    public void setClassroom_id(int classroom_id) {
        this.classroom_id = classroom_id;
    }

    @JsonProperty
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @JsonIgnore
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @JsonIgnore
    public Time getTime_start() {
        return time_start;
    }

    public void setTime_start(Time time_start) {
        this.time_start = time_start;
    }

    @JsonIgnore
    public Time getTime_end() {
        return time_end;
    }

    public void setTime_end(Time time_end) {
        this.time_end = time_end;
    }

    @JsonIgnore
    public int getTime_zone() {
        return time_zone;
    }

    public void setTime_zone(int time_zone) {
        this.time_zone = time_zone;
    }

    @JsonIgnore
    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    @JsonProperty
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
