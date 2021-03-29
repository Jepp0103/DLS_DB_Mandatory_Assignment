package com.example.demo.repository;
import com.example.demo.model.Lecture;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface LectureRepository extends JpaRepository<Lecture,Integer> {

    @Query(value = "SELECT c.name AS course_name, c.id, l.id, l.name AS lector_name from lecture l JOIN course c ON l.course_id = c.id", nativeQuery = true)
    Iterable<Lecture> findLectureAndRelatedCourses();
}