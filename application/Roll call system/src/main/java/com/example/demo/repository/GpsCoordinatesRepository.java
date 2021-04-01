package com.example.demo.repository;
import com.example.demo.model.GpsCoordinates;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GpsCoordinatesRepository extends JpaRepository<GpsCoordinates,Integer> {
}
