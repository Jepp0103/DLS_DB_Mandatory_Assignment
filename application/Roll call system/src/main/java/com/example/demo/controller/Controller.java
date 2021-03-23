package com.example.demo.controller;


import com.example.demo.model.Teacher;
import com.example.demo.repository.TeacherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@CrossOrigin(origins = "*")
public class Controller {
    @Autowired
    private TeacherRepository tr;

    @GetMapping("/")
    public ResponseEntity <List<Teacher>>kak()  {
        System.out.println(tr.findAll().size());
        return new ResponseEntity<>(tr.findAll(), HttpStatus.OK);
    }

}