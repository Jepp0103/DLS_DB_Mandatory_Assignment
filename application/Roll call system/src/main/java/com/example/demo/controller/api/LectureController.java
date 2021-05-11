package com.example.demo.controller.api;

import com.example.demo.JwtTokenUtil;
import com.example.demo.model.Lecture;
import com.example.demo.repository.LectureRepository;
import com.example.demo.service.LectureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Set;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
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

    @GetMapping("/lecturesandrelatedcourses") //Not working yet due to an unknown column error in Lecture entity
    public Iterable<Lecture> getLecturesAndRelatedCourses() {
        return lectureRepository.findLecturesAndRelatedCourses();
    }

    @GetMapping("/lectureparticipationrate")
    //Lecture participation rate function with parameters - http://localhost:4000/api/lectureParticipationRate?lectureId={number}
    public String getLectureParticipationRate(@RequestParam int lectureId) {
        return lectureRepository.findLectureParticipationRate(lectureId);
    }
    @GetMapping("/lectureattendence")
    public ResponseEntity<?> getLectureAttendence(@RequestParam int lectureid) {
        return ResponseEntity.ok(lectureRepository.getLectureAttendence(lectureid));
    }

    @GetMapping("/lectureparticipationratearg2") //Lecture participation rate function with arg 2 for testing
    public String getLectureParticipationRateArg2() {
        return lectureRepository.findLectureParticipationRateArg2();
    }

    @GetMapping("/currentlectures")
    public ResponseEntity<?> getCurrentLectures(HttpServletRequest request) {
        LocalDateTime today=LocalDateTime.now(ZoneId.of("Europe/Copenhagen"));
        String token = jtu.getCurrentToken(request);
        Integer classid = jtu.getClassIdFromToken(token);
        if(classid!=null) {
            return ResponseEntity.ok(lectureRepository.findLectureByDateBetweenAndClasses_Id(today.minusHours(8), today.plusHours(8), classid));
        }
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        System.out.println(teacherid);
        if(teacherid!=null) {
            return ResponseEntity.ok(lectureRepository.findLectureByDateBetweenAndTeachers_Id(today.minusHours(8), today.plusHours(8), teacherid));
        }
        return null;
    }
    @GetMapping("/mylectures")
    public ResponseEntity<?> getMyLectures(HttpServletRequest request) {
        String token = jtu.getCurrentToken(request);
        Integer classid = jtu.getClassIdFromToken(token);
        if(classid!=null) {
            return ResponseEntity.ok(lectureRepository.findLectureByClasses_Id(classid));
        }
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        if(teacherid!=null) {
            return ResponseEntity.ok(lectureRepository.findLectureByTeachers_Id(teacherid));
        }
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
    }

    //Post mappings
    @PostMapping("/beginregistration")
    public void beginRegistration(@RequestBody Lecture lecture, HttpServletRequest request){//should be a post
        System.out.println(lecture.getId());
        String token = jtu.getCurrentToken(request);
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        Set<Lecture> mylectures = lectureRepository.findLectureByTeachers_Id(teacherid);
        if (mylectures.stream().anyMatch(o -> o.getId()==lecture.getId())){
            System.out.println(teacherid);
            ls.startRegistration(lecture.getId(),lecture.getCode());
        }
    }
    @PostMapping("/endregistration")
    public ResponseEntity<?> endRegistration(@RequestBody Lecture lecture, HttpServletRequest request){//should be a post
        String token = jtu.getCurrentToken(request);
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        Set<Lecture> mylectures = lectureRepository.findLectureByTeachers_Id(teacherid);
        if (mylectures.stream().anyMatch(o -> o.getId()==lecture.getId())){
            ls.endRegistration(lecture.getId());
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
    }

    @PostMapping("/addlecture")
    public Lecture addLecture(@RequestBody Lecture lecture)  {
        return lectureRepository.save(lecture);
    }



}