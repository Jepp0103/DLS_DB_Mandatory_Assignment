package com.example.demo.controller.api;
import com.example.demo.model.Lecture;
import com.example.demo.repository.LectureRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class LectureApiController {
    @Autowired
    private LectureRepository lectureRepository;

    @GetMapping("/lectures")
    public Iterable<Lecture> getLectures()  {
        return lectureRepository.findAll();
    }

    @GetMapping("/lecturesAndRelatedCourses") //Not working yet due to an unknown column error in Lecture entity
    public Iterable<Lecture> getLecturesAndRelatedCourses()  {
        return lectureRepository.findLectureAndRelatedCourses();
    }
}