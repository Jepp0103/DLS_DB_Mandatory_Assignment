package com.example.demo.controller.mongoapi;
import com.example.demo.model.mongomodels.SystemMongo;
import com.example.demo.repository.mongorepository.SystemMongoRepository;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequestMapping(value = "/api")
public class SystemMongoController {
    @Autowired
    private SystemMongoRepository systemMongoRepository;


}
//@RequestBody SystemMongo systemMongo

//systemMongo.get_id()