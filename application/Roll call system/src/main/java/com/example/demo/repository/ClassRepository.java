package com.example.demo.repository;
import com.example.demo.model.Class;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ClassRepository extends JpaRepository<Class,Integer> {

    //A function to get the average attendance rate of the specific class for the specific course
    @Query(value = "CALL get_average_class_attendance_rate(:courseId, :classId)", nativeQuery = true)
    Iterable<Integer> findAverageClassAttendanceRate(int courseId, int classId);

    @Query(
            value = "select c.name from teacher_lectures tl left join lecture l on tl.lecture_id=l.id left join class_lectures cl on l.id= cl.lecture_id left join class c on cl.class_id=c.id where teacher_id=:teacherId group by c.name;",
            nativeQuery = true)
    public Iterable<String> findTeacherClasses(int teacherId);
}
