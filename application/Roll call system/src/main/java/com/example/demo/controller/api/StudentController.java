package com.example.demo.controller.api;
import com.example.demo.JwtTokenUtil;
import com.example.demo.model.Student;
import com.example.demo.model.StudentStats;
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

    @GetMapping("/attendencerate")
    public Iterable<Object[]> getAttendenceRate(@RequestParam Map<String,String> params)  {
        Iterable<Object[]> iter=null;

        if (params.containsKey("student") && params.containsKey("course")){
           // iter= studentRepository.findSingleAttendenceRate(Integer.parseInt(params.get("student")),Integer.parseInt(params.get("course")));
        }else if (params.containsKey("student")){
           // iter= studentRepository.findSingleAttendenceRate(Integer.parseInt(params.get("student")));
        }else if(params.containsKey("class") && params.containsKey("course")){
            iter= studentRepository.findAttendenceRate(Integer.parseInt(params.get("class")), Integer.parseInt(params.get("course")));
        }else if(params.containsKey("class")){
            iter= studentRepository.findAttendenceRate(Integer.parseInt(params.get("class")));
        }else{
            iter= studentRepository.findAttendenceRate();
        }
        //Above code should be in a service layer. Added here because lazyness
        return iter;
    }
    @GetMapping("/mystats")
    public ResponseEntity<StudentStats> getStudentStats(HttpServletRequest request)  {
        String token = jtu.getCurrentToken(request);
        Integer classid=jtu.getClassIdFromToken(token);
        Integer studentid=jtu.getStudentIdFromToken(token);
        System.out.println(studentid);
        if (classid!=null && studentid!=null){
            return new ResponseEntity<>(ss.getStudentStats(studentid,classid), HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);

    }

}