package com.example.demo.service;


import com.example.demo.model.Teacher;
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

    public Teacher update(Teacher teacher) {
        Teacher oldteacher = tr.findTeacherById(teacher.getId());
        if (teacher.getEmail_address()!=null) {oldteacher.setEmail_address(teacher.getEmail_address());};
        if (teacher.getForename()!=null) {oldteacher.setForename(teacher.getForename());};
        if (teacher.getSurname()!=null) {oldteacher.setSurname(teacher.getSurname());};
        if (teacher.getPhone_number()!=null) {oldteacher.setPhone_number(teacher.getPhone_number());};
        return tr.save(oldteacher);
    }
}
