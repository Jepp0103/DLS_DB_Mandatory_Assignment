package com.example.demo.controller.api;
import com.example.demo.JwtTokenUtil;
import com.example.demo.model.RegisterAttendenceRequest;
import com.example.demo.model.Student;
import com.example.demo.model.StudentStats;
import com.example.demo.model.Teacher;
import com.example.demo.repository.StudentRepository;
import com.example.demo.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequestMapping(value = "/api")
public class StudentController {

    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private StudentService ss;
    @Autowired
    private JwtTokenUtil jtu;

    @GetMapping("/students")
    public Iterable<Student> getStudents()  {
        return studentRepository.findAll();
    }

    @GetMapping("/mystats")
    public ResponseEntity<StudentStats> getStudentStats(HttpServletRequest request)  {
        String token = jtu.getCurrentToken(request);
        Integer classid=jtu.getClassIdFromToken(token);
        Integer studentid=jtu.getStudentIdFromToken(token);
        if (classid!=null && studentid!=null){
            return new ResponseEntity<>(ss.getStudentStats(studentid,classid), HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);

    }
    @PostMapping("/registerattendence")
    public ResponseEntity<?> registerAttendence(HttpServletRequest request, @RequestBody RegisterAttendenceRequest payload) {
        String token = jtu.getCurrentToken(request);
        Integer classid = jtu.getClassIdFromToken(token);
        Integer studentid = jtu.getStudentIdFromToken(token);
        if (classid != null && studentid != null) {
            boolean registrationsucces = ss.registerAttendence(studentid, payload.getTeacherid(), payload.getLatitude(), payload.getLongitude(), payload.getLectureid(), payload.getCode(), payload.getStudentSSID(), payload.getIpaddress(), payload.getFacultyid(), payload.getTeachingnetworkid());
            return ResponseEntity.ok(registrationsucces ? "Registration successful" : "Registration failed");
        }
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
    }
    @PostMapping("/addstudent")
    public ResponseEntity<?> addStudent(@RequestBody Student student)  {
        return ResponseEntity.ok(studentRepository.save(student));
    }
    @PutMapping("/updatestudent")
    public ResponseEntity<?> updateStudent(@RequestBody Student student, HttpServletRequest request)  {
        String token = jtu.getCurrentToken(request);
        Integer studentid=jtu.getStudentIdFromToken(token);
        if (studentid==student.getId()) {
            return ResponseEntity.ok(ss.update(student));
        }
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
    }
}