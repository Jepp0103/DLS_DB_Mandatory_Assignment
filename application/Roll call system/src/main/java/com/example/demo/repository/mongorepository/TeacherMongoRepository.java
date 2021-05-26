package com.example.demo.repository.mongorepository;

import com.example.demo.model.mongomodels.TeacherMongo;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface TeacherMongoRepository extends MongoRepository<TeacherMongo, String> {

    List<TeacherMongo> findAll();
}
