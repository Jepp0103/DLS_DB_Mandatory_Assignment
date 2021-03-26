package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@JsonIgnoreProperties({"hibernateLazyInitializer","handler"})
@Entity
@Table(name="attendance_record")
public class AttendanceRecord {
    @Id
    @Column(name="id")
    private int id;
    @Column(name="student_id")
    private int student_id;
    @Column(name="lecture_id")
    private int lecture_id;
    @Column(name="is_attending")
    private Boolean is_attending;
    @Column(name="registred_at")
    private Date registred_at;

    @JsonIgnore
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @JsonIgnore
    public int getStudent_id() {
        return student_id;
    }

    public void setStudent_id(int student_id) {
        this.student_id = student_id;
    }

    @JsonIgnore
    public int getLecture_id() {
        return lecture_id;
    }

    public void setLecture_id(int lecture_id) {
        this.lecture_id = lecture_id;
    }

    @JsonIgnore
    public Boolean getIs_attending() {
        return is_attending;
    }

    public void setIs_attending(Boolean is_attending) {
        this.is_attending = is_attending;
    }

    @JsonIgnore
    public Date getRegistred_at() {
        return registred_at;
    }

    public void setRegistred_at(Date registred_at) {
        this.registred_at = registred_at;
    }
}
