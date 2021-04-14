package com.example.demo.controller.api;
import com.example.demo.model.Course;
import com.example.demo.model.GpsCoordinates;
import com.example.demo.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class CourseController {

    @Autowired
    private CourseRepository courseRepository;

    @GetMapping("/courses")
    public Iterable<Course> getCourses()  {
        return courseRepository.findAll();
    }

    //Post mappings
    @PostMapping("/addCourse")
    public Course addCourses(@RequestBody Course courses) {
        return courseRepository.save(courses);
    }
}