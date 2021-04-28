package com.example.demo.repository;
import com.example.demo.model.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CourseRepository extends JpaRepository<Course,Integer> {
    @Query(
            value = "SELECT course.id,course.ects,course.name FROM class_lectures left join lecture on class_lectures.lecture_id=lecture.id left join course on lecture.course_id=course.id where class_lectures.class_id = :classid group by course.id ;",
            nativeQuery = true)
    List<Course>  getClassCourses (int classid);
}
