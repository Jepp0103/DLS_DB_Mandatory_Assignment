package com.example.demo.service;

import com.example.demo.repository.LectureRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LectureService {

    @Autowired
    private LectureRepository lr;


    public void startLecture(int lectureId,String code) {
        lr.insertLectureCode(lectureId,code);
    }

    public boolean correctCode(int lectureId, String code) {
       return lr.existsByIdAndCode(lectureId,code);
    }
}
