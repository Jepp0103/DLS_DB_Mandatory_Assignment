package com.example.demo.controller.api;
import com.example.demo.model.Teacher;
import com.example.demo.repository.TeacherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping(value = "/api")
public class TeacherApiController {
    @Autowired
    private TeacherRepository teacherRepository;

    @GetMapping("/teachers")
    public ResponseEntity<List<Teacher>> kak()  {
        System.out.println(teacherRepository.findAll().size());
        return new ResponseEntity<>(teacherRepository.findAll(), HttpStatus.OK);
    }
}