package com.example.demo.controller.mongoapi;
import com.example.demo.model.mongomodels.LectureMongo;
import com.example.demo.repository.mongorepository.LectureMongoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequestMapping(value = "/api")
public class LectureMongoController {
    @Autowired
    private LectureMongoRepository lectureMongoRepository;

    @GetMapping("/lecturesmongo")
    public Iterable<LectureMongo> getMongoLectures()  {
        return lectureMongoRepository.findAll();
    }

    @PostMapping("/onemongolecture")
    public LectureMongo getOneMongoLecture(@RequestBody Map<String, Integer> body)  {
        return lectureMongoRepository.findOneLecture(body.get("lectureId"));
    }

    @PostMapping("/addmongolecture")
    public LectureMongo addMongoLecture(@RequestBody LectureMongo lectureMongo)  {
        return lectureMongoRepository.save(lectureMongo);
    }
}