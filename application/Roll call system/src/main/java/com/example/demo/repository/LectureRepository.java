package com.example.demo.repository;
import com.example.demo.model.Lecture;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

public interface LectureRepository extends JpaRepository<Lecture,Integer> {

    @Query(value = "SELECT c.name, c.id, l.id, l.name from lecture l JOIN course c ON l.course_id = c.id", nativeQuery = true)
    Iterable<Lecture> findLecturesAndRelatedCourses();

    //Lecture participation rate function with parameters
    @Query(value = "SELECT name, getLectureParticipationRate(:lectureId) FROM lecture WHERE id = :lectureId", nativeQuery = true)
    Iterable<String> findLectureParticipationRate(int lectureId);

    //Lecture participation rate function with arg 2 for testing
    @Query(value = "SELECT name, getLectureParticipationRate(2) FROM lecture WHERE id = 2", nativeQuery = true)
    Iterable<String> findLectureParticipationRateArg2();

    Iterable<String> findLectureByDateBetweenAndClasses_Id(LocalDateTime d1,LocalDateTime d2,int classId);

    Iterable<String> findLectureByDateBetweenAndTeachers_Id(LocalDateTime d1,LocalDateTime d2,int teacherId);

    Set<Lecture> findLectureByTeachers_Id(int teacherid);

    @Transactional
    @Modifying
    @Query("UPDATE Lecture l set l.code = :code where l.id = :lectureId")
    void insertLectureCode(int lectureId, String code);

    //Notation - @transactional @modifying - insert into m
}