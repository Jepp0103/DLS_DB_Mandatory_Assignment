package com.example.demo.repository;
import com.example.demo.model.Class;
import com.example.demo.model.TeacherClassCourseResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Set;

public interface ClassRepository extends JpaRepository<Class,Integer> {

    //A stored procedure to get the average attendance rate of the specific class for the specific course
    @Query(value = "CALL get_average_class_attendance_rate(:courseId, :classId)", nativeQuery = true)
    Integer findAverageClassAttendanceRate(int courseId, int classId);

    @Query(
            value = "select * from class_course where teacherid=:teacherId",
            nativeQuery = true)
    public Set<TeacherClassCourseResponse> findTeacherClasses(int teacherId);

    Class findById(int classid);
}
