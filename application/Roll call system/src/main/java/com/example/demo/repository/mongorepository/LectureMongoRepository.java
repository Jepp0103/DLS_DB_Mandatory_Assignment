package com.example.demo.repository.mongorepository;
import com.example.demo.model.mongomodels.LectureMongo;
import com.example.demo.model.mongomodels.StudentMongo;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.util.List;

public interface LectureMongoRepository extends MongoRepository<LectureMongo, String> {
    @Override
    List<LectureMongo> findAll();
}