package com.example.demo.repository;

import com.example.demo.model.Lecture;
import com.example.demo.model.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface TeacherRepository extends JpaRepository<Teacher,String> {

    @Query(value = "SELECT teacher_id from users where username = :username", nativeQuery = true)
    Integer getTeacherIdFromUser(String username);
    Teacher getTeacherById(int Id);

}
