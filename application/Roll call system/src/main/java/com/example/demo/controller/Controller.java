package com.example.demo.controller;
import com.example.demo.JwtTokenUtil;
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
@CrossOrigin(origins = "*")
public class Controller {
    @Autowired
    TeacherService ts;
    @Autowired
    StudentService ss;
    @Autowired
    JwtTokenUtil jtu;
    @GetMapping("/")
    public String getHomePage(HttpServletRequest request)  {

        final String requestTokenHeader = request.getHeader("Authorization").substring(7);
        System.out.println( jtu.getUsernameFromToken(requestTokenHeader.substring(7)));
        System.out.println( jtu.getTeacherIdFromToken(requestTokenHeader.substring(7)));
        System.out.println( jtu.getStudentIdFromToken(requestTokenHeader.substring(7)));
        System.out.println( jtu.getClassIdFromToken(requestTokenHeader.substring(7)));

        /*Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            boolean isTeacher = SecurityContextHolder.getContext().getAuthentication().getAuthorities().stream()
                    .anyMatch(r -> r.getAuthority().equals("ROLE_TEACHER"));
            boolean isStudent = SecurityContextHolder.getContext().getAuthentication().getAuthorities().stream()
                    .anyMatch(r -> r.getAuthority().equals("ROLE_STUDENT"));
            if (isTeacher){
                session.setAttribute("teacherid",ts.getTeacherIdFromUser(((UserDetails) principal).getUsername()));
            }
            else if (isStudent){
                session.setAttribute("studentid",ss.getStudentIdByUsername(((UserDetails) principal).getUsername()));
                session.setAttribute("myclass",ss.getClassIdByStudentId((int)(session.getAttribute("studentid"))));
            }
        }*/
        return "Home page";
    }
//Moved mapping for entities to their own api classes.

}