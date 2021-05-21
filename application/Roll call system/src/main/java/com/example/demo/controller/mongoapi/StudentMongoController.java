package com.example.demo.controller.mongoapi;
import com.example.demo.model.mongomodels.StudentMongo;
import com.example.demo.repository.mongorepository.StudentMongoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class StudentMongoController {
    @Autowired
    private StudentMongoRepository studentMongoRepository;

    @GetMapping("/studentsmongo")
    public Iterable<StudentMongo> getMongoStudents()  {
        return studentMongoRepository.findAll();
    }

    @PostMapping("/addmongostudent")
    public StudentMongo addMongoStudent(@RequestBody StudentMongo studentMongo)  {
        return studentMongoRepository.save(studentMongo);
    }
}