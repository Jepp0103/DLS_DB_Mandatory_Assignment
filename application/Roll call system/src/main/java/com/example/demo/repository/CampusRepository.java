package com.example.demo.repository;
import com.example.demo.model.Campus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CampusRepository extends JpaRepository<Campus,Integer> {
}
