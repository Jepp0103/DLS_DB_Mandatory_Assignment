package com.example.demo.model.mongomodels;

import com.example.demo.model.mongoobjects.ClassObject;
import com.example.demo.model.mongoobjects.ClassRoomObject;
import com.example.demo.model.mongoobjects.CourseObject;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Id;
import java.sql.Time;
import java.util.Date;
import java.util.List;

@Document(collection = "lecture")
public class LectureMongo {
    @Id
    private int id;
    private String name;
    private Date date;
    private Time time_start;
    private Time time_end;
    private int time_zone;
    private int length;
    private String code;
    private CourseObject course;
    private ClassRoomObject classroom;
    private ClassObject _class; //Can't use class as variable name due to keyword reservation
    private List attendance_records;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Time getTime_start() {
        return time_start;
    }

    public void setTime_start(Time time_start) {
        this.time_start = time_start;
    }

    public Time getTime_end() {
        return time_end;
    }

    public void setTime_end(Time time_end) {
        this.time_end = time_end;
    }

    public int getTime_zone() {
        return time_zone;
    }

    public void setTime_zone(int time_zone) {
        this.time_zone = time_zone;
    }

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public CourseObject getCourse() {
        return course;
    }

    public void setCourse(CourseObject course) {
        this.course = course;
    }

    public ClassRoomObject getClassroom() {
        return classroom;
    }

    public void setClassroom(ClassRoomObject classroom) {
        this.classroom = classroom;
    }

    public ClassObject get_class() {
        return _class;
    }

    public void set_class(ClassObject _class) {
        this._class = _class;
    }

    public List getAttendance_records() {
        return attendance_records;
    }

    public void setAttendance_records(List attendance_records) {
        this.attendance_records = attendance_records;
    }

}

