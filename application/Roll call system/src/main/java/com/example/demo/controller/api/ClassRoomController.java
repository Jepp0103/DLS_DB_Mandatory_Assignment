package com.example.demo.controller.api;
import com.example.demo.model.Classroom;
import com.example.demo.repository.ClassroomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class ClassRoomController {

    @Autowired
    private ClassroomRepository classRoomRepository;

    @GetMapping("/classrooms")
    public Iterable<Classroom> getClassrooms()  {
        return classRoomRepository.findAll();
    }
}