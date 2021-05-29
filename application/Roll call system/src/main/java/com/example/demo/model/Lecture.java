package com.example.demo.model;

import com.example.demo.JwtTokenUtil;
import com.example.demo.controller.JwtAuthenticationController;
import com.example.demo.service.BeanUtil;
import com.fasterxml.jackson.annotation.*;
import org.hibernate.envers.Audited;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.persistence.*;
import javax.servlet.http.HttpServletRequest;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Set;

@JsonIgnoreProperties({"hibernateLazyInitializer","handler"})
@JsonInclude(JsonInclude.Include.NON_NULL)
@Entity
@Table(name="lecture")
public class Lecture {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id")
    private Course course;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "classroom_id")
    private Classroom classroom; //Currently some problems with this field when trying to access: api/lecturesAndRelatedCourses

    @ManyToMany
    @JoinTable(
            name = "class_lectures",
            joinColumns = @JoinColumn(name = "lecture_id"),
            inverseJoinColumns = @JoinColumn(name = "class_id"))
    Set<Class> classes;

    @ManyToMany
    @JoinTable(
            name = "teacher_lectures",
            joinColumns = @JoinColumn(name = "lecture_id"),
            inverseJoinColumns = @JoinColumn(name = "teacher_id"))
    Set<Teacher> teachers;

    @Column(name="name")
    private String name;
    @Audited
    @Column(name="date")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime date;
    @Column(name="time_start")
    private Time timeStart;
    @Column(name="time_end")
    private Time timeEnd;
    @Column(name="time_zone")
    private int timeZone;
    @Column(name="length")
    private int length;
    @Column(name="code")
    @Audited
    private String code;
    @Audited
    @Column(name="registration_deadline")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "Europe/Berlin")
    private LocalDateTime registrationdeadline;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public Classroom getClassroom() {
        return classroom;
    }

    public void setClassroom(Classroom classroom) {
        this.classroom = classroom;
    }

    public Set<Class> getClasses() {
        return classes;
    }

    public void setClasses(Set<Class> classes) {
        this.classes = classes;
    }

    public Set<Teacher> getTeachers() {
        return teachers;
    }

    public void setTeachers(Set<Teacher> teachers) {
        this.teachers = teachers;
    }

    @JsonProperty
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @JsonIgnore
    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public Time getTimeStart() {
        return timeStart;
    }

    public void setTimeStart(Time timeStart) {
        this.timeStart = timeStart;
    }

    public Time getTimeEnd() {
        return timeEnd;
    }

    public void setTimeEnd(Time timeEnd) {
        this.timeEnd = timeEnd;
    }

    public int getTimeZone() {
        return timeZone;
    }

    public void setTimeZone(int timeZone) {
        this.timeZone = timeZone;
    }

    @JsonIgnore
    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public String getCode() {
        JwtTokenUtil jtu = BeanUtil.getBean(JwtTokenUtil.class);
        HttpServletRequest request =
                ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
                        .getRequest();
        if (jtu.getTeacherIdFromToken(jtu.getCurrentToken(request))!=null) {
            return code;
        }
        return null;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public LocalDateTime getRegistrationdeadline() {
        return registrationdeadline;
    }

    public void setRegistrationdeadline(LocalDateTime registrationdeadline) {
        this.registrationdeadline = registrationdeadline;
    }
}
