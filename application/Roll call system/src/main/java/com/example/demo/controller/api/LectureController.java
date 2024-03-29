package com.example.demo.controller.api;

import com.example.demo.JwtTokenUtil;
import com.example.demo.model.Lecture;
import com.example.demo.model.TeacherClassCourseResponse;
import com.example.demo.repository.ClassRepository;
import com.example.demo.repository.LectureRepository;
import com.example.demo.service.LectureService;
import com.example.demo.service.RevisionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Map;
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
    @Autowired
    RevisionService rs;

    //Fetching
    @GetMapping("/lectures")
    public Iterable<Lecture> getLectures() {
        return lectureRepository.findAll();
    }

    @GetMapping("/lecturesandrelatedcourses") //Not working yet due to an unknown column error in Lecture entity
    public Iterable<Lecture> getLecturesAndRelatedCourses() {
        return lectureRepository.findLecturesAndRelatedCourses();
    }

    @PostMapping("/lectureparticipationrate")
    //Lecture participation rate function with parameters - http://localhost:4000/api/lectureParticipationRate?lectureId={number}
    public ResponseEntity<?> getLectureParticipationRate(@RequestBody Lecture lecture) {
        return ResponseEntity.ok(lectureRepository.findLectureParticipationRate(lecture.getId()));
    }
    @PostMapping("/lectureattendence")
    public ResponseEntity<?> getLectureAttendence(@RequestBody Lecture lecture) {
        System.out.println(lecture.getId());
        return ResponseEntity.ok(lectureRepository.getLectureAttendence(lecture.getId()));
    }

    @GetMapping("/lectureparticipationratearg2") //Lecture participation rate function with arg 2 for testing
    public ResponseEntity<?> getLectureParticipationRateArg2() {
        return ResponseEntity.ok(lectureRepository.findLectureParticipationRateArg2());
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
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
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
    @GetMapping("/lecturerevisions")
    public ResponseEntity<?> getLectureRevisions() {
        return ResponseEntity.ok(rs.getRevisions(Lecture.class));
    }


        //Editing
    @PutMapping("/beginregistration")
    public ResponseEntity<?> beginRegistration(@RequestBody Lecture lecture, HttpServletRequest request){//should be a post
        String token = jtu.getCurrentToken(request);
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        Set<Lecture> mylectures = lectureRepository.findLectureByTeachers_Id(teacherid);
        if (mylectures.stream().anyMatch(o -> o.getId()==lecture.getId())){
            ls.startRegistration(lecture);
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
    }
    @PutMapping("/endregistration")
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
    public ResponseEntity<?> addLecture(@RequestBody Lecture lecture,HttpServletRequest request)  {
        String token = jtu.getCurrentToken(request);
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        if (teacherid!=null) {
            return ResponseEntity.ok(lectureRepository.save(lecture));
        }
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
    }
    @PutMapping("/updatelecture")
    public ResponseEntity<?> updateLecture(@RequestBody Lecture lecture, HttpServletRequest request){//should be a post
        String token = jtu.getCurrentToken(request);
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        Set<Lecture> mylectures = lectureRepository.findLectureByTeachers_Id(teacherid);
        if (mylectures.stream().anyMatch(o -> o.getId()==lecture.getId())){
            return ResponseEntity.ok(ls.update(lecture));
        }
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
    }

    @PostMapping("/getlecture")
    public Lecture getLecture(@RequestBody Map<String, Integer> body) {
        return lectureRepository.findLectureById((int)body.get("lectureid"));
    }



}