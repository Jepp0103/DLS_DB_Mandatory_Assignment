package com.example.demo.controller.mongoapi;
import com.example.demo.model.mongomodels.StudentMongo;
import com.example.demo.repository.mongorepository.StudentMongoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequestMapping(value = "/api")
public class StudentMongoController {
    @Autowired
    private StudentMongoRepository studentMongoRepository;

    @GetMapping("/studentsmongo")
    public Iterable<StudentMongo> getMongoStudents()  {
        return studentMongoRepository.findAll();
    }

    @PostMapping("/onemongostudent")
    public StudentMongo getOneMongoStudent(@RequestBody Map<String, Integer> body)  {
        return studentMongoRepository.findOneStudent(body.get("lectureId"));
    }

    @PostMapping("/addmongostudent")
    public StudentMongo addMongoStudent(@RequestBody StudentMongo studentMongo)  {
        return studentMongoRepository.save(studentMongo);
    }
}