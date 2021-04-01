package com.example.demo.repository;
import com.example.demo.model.Network;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NetworkRepository extends JpaRepository<Network,Integer> {
}
