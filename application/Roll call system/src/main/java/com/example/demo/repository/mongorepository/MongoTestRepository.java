package com.example.demo.repository.mongorepository;

import com.example.demo.model.mongomodels.Mongotest;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface MongoTestRepository extends MongoRepository<Mongotest, String> {
    @Override
    List<Mongotest> findAll();
}
