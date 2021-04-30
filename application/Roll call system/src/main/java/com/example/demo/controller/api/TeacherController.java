package com.example.demo.controller.api;
import com.example.demo.JwtTokenUtil;
import com.example.demo.model.GpsCoordinates;
import com.example.demo.model.Teacher;
import com.example.demo.repository.GpsCoordinatesRepository;
import com.example.demo.repository.TeacherRepository;
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

    @GetMapping("/teachers")
    public ResponseEntity<List<Teacher>> teachers()  {
        System.out.println(teacherRepository.findAll().size());
        return new ResponseEntity<>(teacherRepository.findAll(), HttpStatus.OK);
    }
    @PostMapping("/updateteachercoordinates")
    public ResponseEntity<?> updateTeacherCoordinates(@RequestBody GpsCoordinates coordinats, HttpServletRequest request) {
        String token = jtu.getCurrentToken(request);
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        gcr.updateTeachersCoordinates(coordinats.getLatitude(),coordinats.getLongitude(),teacherRepository.getTeacherById(teacherid).getGps_coordinates_id());
        return new ResponseEntity<>(HttpStatus.OK);
    }
}