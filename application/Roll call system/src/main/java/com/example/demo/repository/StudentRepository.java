package com.example.demo.repository;
import com.example.demo.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface StudentRepository extends JpaRepository<Student,Integer> {
    @Query(
            value = "select email_address, getStudentLectureAttendanceRate(id,0) from student",
            nativeQuery = true)
    public List<Object[]> findAttendenceRate();
    @Query(
            value = "select email_address, getStudentLectureAttendanceRate(id,0) from student where class_id=:class",
            nativeQuery = true)
    public List<Object[]> findAttendenceRate(@Param("class") int classid);
    @Query(
            value = "select email_address, getStudentLectureAttendanceRate(id,:course) from student where class_id=:class",
            nativeQuery = true)
    public List<Object[]> findAttendenceRate(@Param("class") int classid,@Param("course") int course);
}