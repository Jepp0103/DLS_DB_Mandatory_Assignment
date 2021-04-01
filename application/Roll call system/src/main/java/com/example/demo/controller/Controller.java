package com.example.demo.controller;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(origins = "*")
public class Controller {
    @GetMapping("/")
    public String getHomePage()  {
        return "Home page";
    }
//Moved mapping for entities to their own api classes.

}