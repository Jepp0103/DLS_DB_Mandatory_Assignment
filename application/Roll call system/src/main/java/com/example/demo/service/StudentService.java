package com.example.demo.service;

import com.example.demo.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {

    @Autowired
    StudentRepository sr;
    @Autowired
    LectureService ls;

    public int getStudentIdByUsername(String username){
        return sr.getStudentIdByUsername(username);
    }

    public int getClassIdByStudentId(int id){
        return sr.getClassIdByStudentId(id);
    }

    public boolean registerAttendence(int studentId,int[] teachers,double latitude, double longitude, int lectureId,String code){
        boolean lecturebegun=true;
        boolean withinrange=studentWithinRange(studentId,teachers,latitude,longitude);
        boolean correctcode=ls.correctCode(lectureId,code);
        boolean correctnetwork=true;
        if (correctcode && lecturebegun){
            if (correctnetwork){
                sr.registerAttendence(studentId, lectureId);
                return true;
            }
            else if (withinrange){
                sr.registerAttendence(studentId, lectureId);
                return true;
            }
        }
        return false;
    }


    public boolean studentWithinRange(int student, int[] teachers, double latitude, double longitude) {
        for (int teacher : teachers) {
            if (sr.studentWithinRange(student,teacher,latitude,longitude,0)=='y'){ //fifth parameter is irrelevant atm.
                return true;
            }
        }
        return false;
    }
}
