package com.example.demo.controller.mongoapi;
import com.example.demo.model.mongomodels.TeacherMongo;
import com.example.demo.repository.mongorepository.TeacherMongoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class TeacherMongoController {
    @Autowired
    private TeacherMongoRepository tmr;

    @GetMapping("/teachersmongo")
    public Iterable<TeacherMongo> getMongoTeachers()  {
        return tmr.findAll();
    }
}