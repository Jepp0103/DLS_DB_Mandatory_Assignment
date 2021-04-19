package com.example.demo.controller.api;

import com.example.demo.model.Lecture;
import com.example.demo.repository.LectureRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class LectureController {
    @Autowired
    private LectureRepository lectureRepository;

    //Get mappings
    @GetMapping("/lectures")
    public Iterable<Lecture> getLectures() {
        return lectureRepository.findAll();
    }

    @GetMapping("/lecturesAndRelatedCourses") //Not working yet due to an unknown column error in Lecture entity
    public Iterable<Lecture> getLecturesAndRelatedCourses() {
        return lectureRepository.findLecturesAndRelatedCourses();
    }

    @GetMapping("/lectureParticipationRate")
    //Lecture participation rate function with parameters - http://localhost:4000/api/lectureParticipationRate?lectureId={number}
    public Iterable<String> getLectureParticipationRate(@RequestParam int lectureId) {
        return lectureRepository.findLectureParticipationRate(lectureId);
    }

    @GetMapping("/lectureParticipationRateArg2") //Lecture participation rate function with arg 2 for testing
    public Iterable<String> getLectureParticipationRateArg2() {
        return lectureRepository.findLectureParticipationRateArg2();
    }

    //Post mappings
    @PostMapping("/addLecture")
    public Lecture addLecture(@RequestBody Lecture lecture)  {
            System.out.println("Id "+ lecture.getId());
            System.out.println("Course id " + lecture.getCourse().getId());
            System.out.println("Classroom id "+ lecture.getClassroom().getId());
            System.out.println("Name "+ lecture.getName());
            System.out.println("Date "+ lecture.getDate());
            System.out.println("Time start "+ lecture.getTimeStart());
            System.out.println("Time end "+ lecture.getTimeEnd());
            System.out.println("Time zone "+ lecture.getTimeZone());
            System.out.println("Length "+ lecture.getLength());
            System.out.println("Code "+ lecture.getCode());
        return lectureRepository.save(lecture);
    }
}