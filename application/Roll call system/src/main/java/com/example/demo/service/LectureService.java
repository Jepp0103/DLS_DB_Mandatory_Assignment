package com.example.demo.service;

import com.example.demo.repository.LectureRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;

@Service
public class LectureService {

    @Autowired
    private LectureRepository lr;


    public void startRegistration(int lectureId, String code, LocalDateTime deadline) {
        lr.insertLectureCode(lectureId,code,deadline);
    }

    public boolean correctCode(int lectureId, String code) {
       return lr.existsByIdAndCodeAndRegistrationdeadlineAfter(lectureId,code,LocalDateTime.now(ZoneId.of("Europe/Copenhagen")));
    }

    public void endRegistration(int lectureId) {lr.removeLectureCodee(lectureId);}
}
