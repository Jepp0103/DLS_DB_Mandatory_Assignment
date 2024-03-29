package com.example.demo.repository;
import com.example.demo.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface StudentRepository extends JpaRepository<Student,Integer> {
    public Student findStudentById(int id);
    @Query(
            value = "select email_address, getStudentLectureAttendanceRate(id,0) from student",
            nativeQuery = true)
    public List<Object[]> findAttendenceRate();
    @Query(
            value = "select getStudentLectureAttendanceRate(id,0) from student where id=:student",
            nativeQuery = true)
    public Integer findSingleAttendenceRate(@Param("student") int studentid);
    @Query(
            value = "select getStudentLectureAttendanceRate(id,:course) from student where id=:student",
            nativeQuery = true)
    public Integer findSingleAttendenceRate(@Param("student") int studentid,@Param("course") int course);

    @Query(value = "SELECT student_id from users where username = :username", nativeQuery = true)
    public Integer getStudentIdByUsername(String username);

    @Query(value = "SELECT class_id from student where id = :id", nativeQuery = true)
    public Integer  getClassIdByStudentId(int id);

    @Modifying
    @Query(value = "INSERT into attendance_record (student_id,lecture_id,is_attending,registred_at) values (:studentId,:lectureId,1,NOW())",nativeQuery = true)
    @Transactional
    void registerAttendence(int studentId, int lectureId);

    @Procedure("register_student_gps")
    char studentWithinRange(int student, int teacher, double latitude, double longitude);

    @Modifying
    @Transactional
    @Query(value = "UPDATE attendance_record SET is_attending=1, registred_at=NOW() WHERE student_id=:studentId and lecture_id=:lectureId",nativeQuery = true)
    void updateAttendence(int studentId, int lectureId);
}