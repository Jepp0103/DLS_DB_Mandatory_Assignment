package com.example.demo.repository.mongorepository;
import com.example.demo.model.mongomodels.StudentMongo;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface StudentMongoRepository extends MongoRepository<StudentMongo, String> {
    @Override
    List<StudentMongo> findAll();
}
