package com.example.demo.controller.mongoapi;
import com.example.demo.model.mongomodels.LectureMongo;
import com.example.demo.repository.mongorepository.LectureMongoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/addmongolecture")
    public LectureMongo addMongoLecture(@RequestBody LectureMongo lectureMongo)  {
        return lectureMongoRepository.save(lectureMongo);
    }

    @GetMapping("/getmongolectureparticipationrate")
    public String getMongoLectureParticipationRate()  {
        return lectureMongoRepository.findLectureMongoParticipationRate();
    }
}