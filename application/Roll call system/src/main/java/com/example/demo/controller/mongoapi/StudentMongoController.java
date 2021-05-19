package com.example.demo.controller.mongoapi;
import com.example.demo.model.mongomodels.StudentMongo;
import com.example.demo.repository.mongorepository.StudentMongoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class StudentMongoController {
    @Autowired
    private StudentMongoRepository smr;

    @GetMapping("/studentsmongo")
    public Iterable<StudentMongo> getMongoStudents()  {
        return smr.findAll();
    }
}