package com.example.demo.controller.api;
import com.example.demo.JwtTokenUtil;
import com.example.demo.model.GpsCoordinates;
import com.example.demo.model.StudentStats;
import com.example.demo.model.Teacher;
import com.example.demo.repository.GpsCoordinatesRepository;
import com.example.demo.repository.TeacherRepository;
import com.example.demo.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping(value = "/api")
public class TeacherController {
    @Autowired
    private TeacherRepository teacherRepository;
    @Autowired
    private GpsCoordinatesRepository gcr;
    @Autowired
    JwtTokenUtil jtu;
    @Autowired
    TeacherService ts;

    @GetMapping("/teachers")
    public ResponseEntity<List<Teacher>> teachers()  {
        return new ResponseEntity<>(teacherRepository.findAll(), HttpStatus.OK);
    }
    @PostMapping("/updateteachercoordinates")
    public ResponseEntity<?> updateTeacherCoordinates(@RequestBody GpsCoordinates coordinats, HttpServletRequest request) {
        String token = jtu.getCurrentToken(request);
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        if (teacherid!=null) {
            gcr.updateTeachersCoordinates(coordinats.getLatitude(), coordinats.getLongitude(), teacherRepository.getTeacherById(teacherid).getGps_coordinates_id());
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
    }
    @GetMapping("/teacherstats")
    public ResponseEntity<?> getTeacherstats(HttpServletRequest request)  {
        String token = jtu.getCurrentToken(request);
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        if (teacherid!=null){
            return ResponseEntity.ok(ts.getTeacherStats(teacherid));
        }
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
    }
    @PostMapping("/addteacher")
    public ResponseEntity<?> addTeacher(@RequestBody Teacher teacher)  {
        return ResponseEntity.ok(teacherRepository.save(teacher));
    }
    @PutMapping("/updateteacher")
    public ResponseEntity<?> updateTeacher(@RequestBody Teacher teacher, HttpServletRequest request)  {
        String token = jtu.getCurrentToken(request);
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        if (teacherid==teacher.getId()) {
            return ResponseEntity.ok(ts.update(teacher));
        }
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
    }



}