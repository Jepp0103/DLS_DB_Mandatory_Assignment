package com.example.demo.controller.api;
import com.example.demo.model.Campus;
import com.example.demo.repository.CampusRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class CampusController {

    @Autowired
    private CampusRepository campusRepository;

    @GetMapping("/campuses")
    public Iterable<Campus> getCampuses()  {
        return campusRepository.findAll();
    }
}