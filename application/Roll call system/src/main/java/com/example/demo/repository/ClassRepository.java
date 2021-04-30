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
            value = "select c.name classname,co.name coursename,c.id classid,co.id courseid from teacher_lectures tl left join lecture l on tl.lecture_id=l.id left join class_lectures cl on l.id= cl.lecture_id left join class c on cl.class_id=c.id left join course co on l.course_id=co.id where teacher_id=:teacherId group by c.id,co.id;",
            nativeQuery = true)
    public Set<TeacherClassCourseResponse> findTeacherClasses(int teacherId);
}
