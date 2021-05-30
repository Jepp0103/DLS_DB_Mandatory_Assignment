package com.example.demo.repository;

import com.example.demo.model.Lecture;
import com.example.demo.model.Student;
import com.example.demo.model.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TeacherRepository extends JpaRepository<Teacher,String> {

    @Query(value = "SELECT teacher_id from users where username = :username", nativeQuery = true)
    Integer getTeacherIdFromUser(String username);
    Teacher getTeacherById(int Id);

    Teacher findTeacherById(int id);

    @Query(
            value = "select email_address, getStudentLectureAttendanceRate(id,0) from student where class_id=:class",
            nativeQuery = true)
    public List<Object[]> findAttendenceRate(@Param("class") int classid);
    @Query(
            value = "select email_address, getStudentLectureAttendanceRate(id,:course) from student where class_id=:class",
            nativeQuery = true)
    public Integer findAttendenceRate(@Param("class") int classid,@Param("course") int course);
}
