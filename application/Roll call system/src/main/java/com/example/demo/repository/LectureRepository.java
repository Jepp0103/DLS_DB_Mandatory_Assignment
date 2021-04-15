package com.example.demo.repository;
import com.example.demo.model.Lecture;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface LectureRepository extends JpaRepository<Lecture,Integer> {

    @Query(value = "SELECT c.name, c.id, l.id, l.name from lecture l JOIN course c ON l.course_id = c.id", nativeQuery = true)
    Iterable<Lecture> findLecturesAndRelatedCourses();

    //Lecture participation rate function with parameters
    @Query(value = "SELECT name, getLectureParticipationRate(:lectureId) FROM lecture WHERE id = :lectureId", nativeQuery = true)
    Iterable<String> findLectureParticipationRate(int lectureId);

    //Lecture participation rate function with arg 2 for testing
    @Query(value = "SELECT name, getLectureParticipationRate(2) FROM lecture WHERE id = 2", nativeQuery = true)
    Iterable<String> findLectureParticipationRateArg2();

    //Notation - @transactional @modifying - insert into m
}