package com.example.demo.service;

import com.example.demo.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentService {

    @Autowired
    StudentRepository sr;

    public int getStudentIdByUsername(String username){
        return sr.getStudentIdByUsername(username);
    }

    public int getClassIdByStudentId(int id){
        return sr.getClassIdByStudentId(id);
    }

    public boolean registerAttendence(int studentId, int lectureId){
        boolean lecturebegun=true;
        boolean withinrange=true;
        boolean correctcode=true;
        boolean correctnetwork=true;
        if (correctcode && lecturebegun){
            if (correctnetwork){
                sr.registerAttendence(studentId, lectureId);
                return true;
            }
            else if (withinrange){
                return true;
            }
        }
        return false;
    }

}
