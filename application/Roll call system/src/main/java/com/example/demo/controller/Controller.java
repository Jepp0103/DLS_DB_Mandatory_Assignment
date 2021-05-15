package com.example.demo.controller;
import com.example.demo.JwtTokenUtil;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.StudentService;
import com.example.demo.service.TeacherService;
import io.jsonwebtoken.Claims;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequestMapping(value = "/api")
public class Controller {
    @Autowired
    TeacherService ts;
    @Autowired
    StudentService ss;
    @Autowired
    JwtTokenUtil jtu;
    @Autowired
    UserRepository ur;
    @GetMapping("/")
    public String getHomePage(HttpServletRequest request)  {

        String token = jtu.getCurrentToken(request);
        System.out.println(token);
        System.out.println( jtu.getUsernameFromToken(token));
        System.out.println( jtu.getTeacherIdFromToken(token));
        System.out.println( jtu.getStudentIdFromToken(token));
        System.out.println( jtu.getClassIdFromToken(token));

        return "Home page";
    }
    @GetMapping("/getrole")
    public String getRole(HttpServletRequest request)  {
        String token = jtu.getCurrentToken(request);
        Integer teacherid=jtu.getTeacherIdFromToken(token);
        if (teacherid!=null){
            return "teacher";
        }
        Integer studentid=jtu.getStudentIdFromToken(token);
        if(studentid!=null){
            return "student";
        }
        return null;
    }
    @GetMapping("/resetpasswords")
    public String getHomePage() {
        System.out.println(ur.findByUsername("user").getPassword());
        ur.resetAllPasswords(ur.findByUsername("user").getPassword());
        return "Passwords reset";
    }
//Moved mapping for entities to their own api classes.

}