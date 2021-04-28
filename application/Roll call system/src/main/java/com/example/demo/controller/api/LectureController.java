package com.example.demo.controller.api;

import com.example.demo.JwtTokenUtil;
import com.example.demo.model.Lecture;
import com.example.demo.repository.LectureRepository;
import com.example.demo.service.LectureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Set;

@RestController
@RequestMapping(value = "/api")
public class LectureController {
    @Autowired
    private LectureRepository lectureRepository;
    @Autowired
    private LectureService ls;
    @Autowired
    JwtTokenUtil jtu;

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
    public String getLectureParticipationRate(@RequestParam int lectureId) {
        return lectureRepository.findLectureParticipationRate(lectureId);
    }

    @GetMapping("/lectureParticipationRateArg2") //Lecture participation rate function with arg 2 for testing
    public String getLectureParticipationRateArg2() {
        return lectureRepository.findLectureParticipationRateArg2();
    }

    @GetMapping("/currentlectures")
    public Iterable<String> getCurrentLectures(HttpServletRequest request) {
        LocalDateTime today=LocalDateTime.now(ZoneId.of("Europe/Copenhagen"));
        String token = jtu.getCurrentToken(request);
        Integer classid = jtu.getClassIdFromToken(token);
        if(classid!=null) {
            return lectureRepository.findLectureByDateBetweenAndClasses_Id(today.minusHours(8), today.plusHours(8), classid);
        }
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        System.out.println(teacherid);
        if(teacherid!=null) {
            return lectureRepository.findLectureByDateBetweenAndTeachers_Id(today.minusHours(8), today.plusHours(8), teacherid);
        }
        return null;
    }

    //Post mappings
    @GetMapping("/beginlecture")
    public void beginLecture(@RequestParam int lectureId, HttpServletRequest request){//should be a post
        String token = jtu.getCurrentToken(request);
            Integer teacherid=jtu.getTeacherIdFromToken(token);
        Set<Lecture> mylectures = lectureRepository.findLectureByTeachers_Id(teacherid);
        if (mylectures.stream().anyMatch(o -> o.getId()==lectureId)){
            ls.startLecture(lectureId,"asddsa");
        }
    }

    @PostMapping("/addLecture")
    public Lecture addLecture(@RequestBody Lecture lecture)  {
        return lectureRepository.save(lecture);
    }



}