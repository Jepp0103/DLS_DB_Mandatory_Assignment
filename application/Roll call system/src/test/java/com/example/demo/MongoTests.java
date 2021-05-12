package com.example.demo;

import com.example.demo.repository.mongorepository.MongoTestRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest
class MongoTests {
    @Autowired
    MongoTestRepository mtr;

    @Test
    void test() {
        System.out.println(mtr.findAll().get(0).getName());
    }


}