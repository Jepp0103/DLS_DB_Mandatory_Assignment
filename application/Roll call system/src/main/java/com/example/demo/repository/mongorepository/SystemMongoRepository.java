package com.example.demo.repository.mongorepository;

import com.example.demo.model.mongomodels.SystemMongo;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.util.List;

public interface SystemMongoRepository extends MongoRepository<SystemMongo, String> {
    @Override

    List<SystemMongo> findAll();

    @Query("{'_id': getLectureParticipationRate }")
    SystemMongo findLectureParticipationRate();
}
//int lectureId