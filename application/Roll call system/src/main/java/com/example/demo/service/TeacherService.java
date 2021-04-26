package com.example.demo.service;


import com.example.demo.repository.TeacherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeacherService {
    @Autowired
    TeacherRepository tr;

    public Integer getTeacherIdFromUser(String username){
        return tr.getTeacherIdFromUser(username);
    }

}
