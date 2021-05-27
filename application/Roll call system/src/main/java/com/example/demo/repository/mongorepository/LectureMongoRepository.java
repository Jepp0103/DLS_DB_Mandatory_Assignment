package com.example.demo.repository.mongorepository;
import com.example.demo.model.mongomodels.LectureMongo;
import com.example.demo.model.mongomodels.StudentMongo;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.util.List;

public interface LectureMongoRepository extends MongoRepository<LectureMongo, String> {
    @Override
    List<LectureMongo> findAll();

    //Lecture participation rate function with parameters
    @Query("{student: db.student.findOne({_id: 3})}")
    String findLectureMongoParticipationRate();
}
//int lectureId