package com.example.demo.service;

import com.example.demo.JwtTokenUtil;
import com.example.demo.model.Class;
import com.example.demo.model.Lecture;
import com.example.demo.model.Student;
import com.example.demo.model.TeacherClassCourseResponse;
import com.example.demo.repository.LectureRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Set;

@Service
public class LectureService {
    @Autowired
    JwtTokenUtil jtu;
    @Autowired
    private LectureRepository lr;


    public void startRegistration(Lecture updatedlecture) {
        Lecture savedlecture=lr.findLectureById(updatedlecture.getId());
        savedlecture.setCode(updatedlecture.getCode());
        savedlecture.setRegistrationdeadline(updatedlecture.getRegistrationdeadline());
        lr.save(savedlecture);
    }

    public boolean correctCode(int lectureId, String code) {
       return lr.existsByIdAndCodeAndRegistrationdeadlineAfter(lectureId,code,LocalDateTime.now(ZoneId.of("Europe/Copenhagen")));
    }

    public void endRegistration(int lectureId) {
        Lecture savedlecture=lr.findLectureById(lectureId);
        savedlecture.setCode(null);
        lr.save(savedlecture);

    }

    public Lecture update(Lecture lecture) {
        Lecture oldlecture = lr.findLectureById(lecture.getId());
        if (lecture.getName()!=null) {oldlecture.setName(lecture.getName());}
        if (lecture.getDate()!=null) {oldlecture.setDate(lecture.getDate());}
        if (lecture.getTeachers()!=null) {oldlecture.setTeachers(lecture.getTeachers());}
        if (lecture.getClasses()!=null) {oldlecture.setClasses(lecture.getClasses());}
        if (lecture.getClassroom()!=null) {oldlecture.setClassroom(lecture.getClassroom());}
        if (lecture.getCourse()!=null) {oldlecture.setCourse(lecture.getCourse());}
        return lr.save(oldlecture);
    }
}
