package com.example.demo.repository;
import com.example.demo.model.GpsCoordinates;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;

public interface GpsCoordinatesRepository extends JpaRepository<GpsCoordinates,Integer> {

    //Stored procedure to register gps coordinates of a student based compared to a teacher's gps coordinates
    @Procedure("register_student_gps")
    char registerStudentGps(int studentId, int teacherId, double studentLatitude, double studentLongitude, double gpsRange);
}