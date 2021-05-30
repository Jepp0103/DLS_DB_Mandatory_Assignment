package com.example.demo.service;


import com.example.demo.model.*;
import com.example.demo.repository.ClassRepository;
import com.example.demo.repository.TeacherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service
public class TeacherService {
    @Autowired
    TeacherRepository tr;
    @Autowired
    ClassRepository cr;

    public Integer getTeacherIdFromUser(String username){
        return tr.getTeacherIdFromUser(username);
    }

    public Teacher update(Teacher teacher) {
        Teacher oldteacher = tr.findTeacherById(teacher.getId());
        if (teacher.getEmail_address()!=null) {oldteacher.setEmail_address(teacher.getEmail_address());};
        if (teacher.getForename()!=null) {oldteacher.setForename(teacher.getForename());};
        if (teacher.getSurname()!=null) {oldteacher.setSurname(teacher.getSurname());};
        if (teacher.getPhone_number()!=null) {oldteacher.setPhone_number(teacher.getPhone_number());};
        return tr.save(oldteacher);
    }

    public TeacherStats getTeacherStats(int teacher) {
        Set<TeacherClassCourseResponse> myclasses = cr.findTeacherClasses(teacher);
        List<ClassAttendence> participationrates = new ArrayList<ClassAttendence>();

        for (TeacherClassCourseResponse courseclass : myclasses)
        {
            Integer attendence=cr.findAverageClassAttendanceRate(courseclass.getCourseid(),courseclass.getClassid());
            if (attendence!=null){
                participationrates.add(new ClassAttendence(attendence,courseclass));
            }
        }
        return new TeacherStats(participationrates);
    }
}
