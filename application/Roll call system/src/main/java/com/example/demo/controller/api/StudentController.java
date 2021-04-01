package com.example.demo.controller.api;
import com.example.demo.model.Student;
import com.example.demo.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
    public Iterable<Object[]> getAttendenceRate()  {
        return studentRepository.findAttendenceRate(1,1);
    }
}