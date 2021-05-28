package com.example.demo.controller.mongoapi;
import com.example.demo.model.mongomodels.LectureMongo;
import com.example.demo.repository.mongorepository.LectureMongoRepository;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import com.mongodb.MongoClientURI;
import org.bson.Document;
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
    public String getLectureMongoParticipationRate()  {

        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        System.out.println("connected");
        MongoDatabase db = mongoClient.getDatabase("roll_call_mongo_db");
        System.out.println("getting db");

//        Document doc1 = db.runCommand(new Document("$eval", "getLectureParticipationRate(1)"));
//        System.out.println(doc1);

        return "hello";
    }
}