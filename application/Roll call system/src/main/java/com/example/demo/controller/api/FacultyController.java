package com.example.demo.controller.api;
        import com.example.demo.model.Faculty;
        import com.example.demo.repository.FacultyRepository;
        import org.springframework.beans.factory.annotation.Autowired;
        import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class FacultyController {

    @Autowired
    private FacultyRepository facultyRepository;

    @GetMapping("/faculties")
    public Iterable<Faculty> getFaculties()  {
        return facultyRepository.findAll();
    }
}