package com.example.demo.repository.mongorepository;
import com.example.demo.model.mongomodels.TeacherMongo;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.util.List;

public interface TeacherMongoRepository extends MongoRepository<TeacherMongo, String> {
    @Override
    List<TeacherMongo> findAll();

    @Query("{'_id': ?0 }")
    TeacherMongo findOneTeacher(int teacherId);
}
