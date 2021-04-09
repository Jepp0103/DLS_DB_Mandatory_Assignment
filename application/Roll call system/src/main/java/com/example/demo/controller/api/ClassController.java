package com.example.demo.controller.api;
import com.example.demo.model.Class;
import com.example.demo.repository.ClassRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class ClassController {

    @Autowired
    private ClassRepository classRepository;

    @GetMapping("/classes")
    public Iterable<Class> getClasses()  {
        return classRepository.findAll();
    }

    @GetMapping("/averageClassAttendanceRate")
    public Iterable<Integer> getAverageClassAttendanceRate(@RequestParam int courseId, @RequestParam int classId)  {
        return classRepository.findAverageClassAttendanceRate(courseId, classId);
    }
}