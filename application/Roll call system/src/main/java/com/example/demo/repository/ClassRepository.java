package com.example.demo.repository;
import com.example.demo.model.Class;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ClassRepository extends JpaRepository<Class,Integer> {

    //A function to get the average attendance rate of the specific class for the specific course
    @Query(value = "CALL get_average_class_attendance_rate(:courseId, :classId)", nativeQuery = true)
    Iterable<Integer> findAverageClassAttendanceRate(int courseId, int classId);
}
