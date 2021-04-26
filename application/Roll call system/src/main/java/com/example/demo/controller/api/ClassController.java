package com.example.demo.controller.api;
import com.example.demo.JwtTokenUtil;
import com.example.demo.model.Class;
import com.example.demo.repository.ClassRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping(value = "/api")
public class ClassController {
    @Autowired
    JwtTokenUtil jtu;

    @Autowired
    private ClassRepository classRepository;

    @GetMapping("/classes")
    public Iterable<Class> getClasses()  {
        return classRepository.findAll();
    }

    @GetMapping("/averageClassAttendanceRate")
    public Integer getAverageClassAttendanceRate(@RequestParam int courseId, @RequestParam int classId)  {
        return classRepository.findAverageClassAttendanceRate(courseId, classId);
    }

    @GetMapping("/myclasses")
    public Iterable<String> getTeachersClasses(HttpServletRequest request)  {
        String token = jtu.getCurrentToken(request);
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        return teacherid!=null ? classRepository.findTeacherClasses(jtu.getTeacherIdFromToken(token)) : null;
    }

}