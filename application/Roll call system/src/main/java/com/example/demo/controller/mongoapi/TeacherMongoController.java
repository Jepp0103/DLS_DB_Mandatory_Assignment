package com.example.demo.controller.mongoapi;
import com.example.demo.model.mongomodels.StudentMongo;
import com.example.demo.model.mongomodels.TeacherMongo;
import com.example.demo.repository.mongorepository.TeacherMongoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequestMapping(value = "/api")
public class TeacherMongoController {
    @Autowired
    private TeacherMongoRepository teacherMongoRepository;

    @GetMapping("/teachersmongo")
    public Iterable<TeacherMongo> getMongoTeachers()  {
        return teacherMongoRepository.findAll();
    }

    @PostMapping("/onemongoteacher")
    public TeacherMongo getOneMongoTeacher(@RequestBody Map<String, Integer> body)  {
        return teacherMongoRepository.findOneTeacher(body.get("teacherId"));
    }

    @PostMapping("/addmongoteacher")
    public TeacherMongo addMongoTeacher(@RequestBody TeacherMongo teacherMongo)  {
        return teacherMongoRepository.save(teacherMongo);
    }
}