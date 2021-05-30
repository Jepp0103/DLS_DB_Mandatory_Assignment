package com.example.demo.model.mongomodels;

import com.example.demo.model.mongoobjects.AttendanceRecordObject;
import com.example.demo.model.mongoobjects.ClassObject;
import com.example.demo.model.mongoobjects.ClassRoomObject;
import com.example.demo.model.mongoobjects.CourseObject;
import org.springframework.data.mongodb.core.mapping.Document;
import javax.persistence.Id;
import java.util.List;

@Document(collection = "lecture")
public class LectureMongo {
    @Id private int _id;
    private String name;
    private String date;
    private String time_start;
    private String time_end;
    private int time_zone;
    private int length;
    private String code;
    private CourseObject course;
    private ClassRoomObject classroom;
    private ClassObject classes;
    private List<AttendanceRecordObject> attendance_records;

    public int get_id() {
        return _id;
    }

    public void set_id(int _id) {
        this._id = _id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTime_start() {
        return time_start;
    }

    public void setTime_start(String time_start) {
        this.time_start = time_start;
    }

    public String getTime_end() {
        return time_end;
    }

    public void setTime_end(String time_end) {
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

    public ClassObject getClasses() {
        return classes;
    }

    public void setClasses(ClassObject classes) {
        this.classes = classes;
    }

    public List<AttendanceRecordObject> getAttendance_records() {
        return attendance_records;
    }

    public void setAttendance_records(List<AttendanceRecordObject> attendance_records) {
        this.attendance_records = attendance_records;
    }


}

