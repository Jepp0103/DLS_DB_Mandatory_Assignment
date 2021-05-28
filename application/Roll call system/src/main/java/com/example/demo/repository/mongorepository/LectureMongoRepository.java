package com.example.demo.repository.mongorepository;
import com.example.demo.model.mongomodels.LectureMongo;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.util.List;

public interface LectureMongoRepository extends MongoRepository<LectureMongo, String> {
    @Override
    List<LectureMongo> findAll();

    @Query("{'_id': ?0 }")
    LectureMongo findOneLecture(int lectureId);
}