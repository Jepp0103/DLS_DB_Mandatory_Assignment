package com.example.demo.controller.api;
import com.example.demo.model.Student;
import com.example.demo.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping(value = "/api")
public class StudentController {

    @Autowired
    private StudentRepository studentRepository;

    @GetMapping("/students") //Not working - Error with network id and gps_coordinates id
    public Iterable<Student> getStudents()  {
        return studentRepository.findAll();
    }
    @GetMapping("/attendencerate")
    public Iterable<Object[]> getAttendenceRate(@RequestParam Map<String,String> params)  {
        Iterable<Object[]> iter;

        if (params.containsKey("student") && params.containsKey("course")){
            iter= studentRepository.findSingleAttendenceRate(Integer.parseInt(params.get("student")),Integer.parseInt(params.get("course")));
        }else if (params.containsKey("student")){
            iter= studentRepository.findSingleAttendenceRate(Integer.parseInt(params.get("student")));
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
}