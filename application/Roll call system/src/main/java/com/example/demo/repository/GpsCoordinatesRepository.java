package com.example.demo.repository;
import com.example.demo.model.GpsCoordinates;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;

import javax.transaction.Transactional;

public interface GpsCoordinatesRepository extends JpaRepository<GpsCoordinates,Integer> {

    //Stored procedure to register gps coordinates of a student compared to a teacher's gps coordinates
    @Procedure("register_student_gps")
    char registerStudentGps(int studentId, int teacherId, double studentLatitude, double studentLongitude);

    @Transactional
    @Modifying
    @Query("UPDATE GpsCoordinates g set g.latitude = :latitude, g.longitude = :longitude where g.id = :gps_coordinates_id")
    void updateTeachersCoordinates(double latitude, double longitude, Integer gps_coordinates_id);
}