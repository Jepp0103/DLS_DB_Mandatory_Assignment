package com.example.demo.controller;
import com.example.demo.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@RestController
@CrossOrigin(origins = "*")
public class Controller {
    @Autowired
    TeacherService tr;
    @GetMapping("/")
    public String getHomePage(HttpSession session)  {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            boolean isTeacher = SecurityContextHolder.getContext().getAuthentication().getAuthorities().stream()
                    .anyMatch(r -> r.getAuthority().equals("ROLE_TEACHER"));
            if (isTeacher){
                session.setAttribute("teacherid",tr.getTeacherIdFromUser(((UserDetails) principal).getUsername()));
                System.out.println(session.getAttribute("teacherid"));
            }
        }
        return "Home page";
    }
//Moved mapping for entities to their own api classes.

}