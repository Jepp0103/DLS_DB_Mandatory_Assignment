package com.example.demo.repository;
import com.example.demo.model.GpsCoordinates;
import com.example.demo.model.StudentGpsRegister;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface GpsCoordinatesRepository extends JpaRepository<GpsCoordinates,Integer> {



    //Stored procedure to register gps coordinates of a student based compared to a teacher's gps coordinates
    @Query(value = "CALL register_student_gps(:studentId, :teacherId, :studentLatitude, :studentLongitude, :gpsRange, :withinRange)", nativeQuery = true)
    String registerStudentGps(int studentId, int teacherId, double studentLatitude, double studentLongitude, double gpsRange, String withinRange);
}
