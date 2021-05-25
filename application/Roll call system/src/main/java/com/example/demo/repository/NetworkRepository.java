package com.example.demo.repository;
import com.example.demo.model.Network;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;

public interface NetworkRepository extends JpaRepository<Network,Integer> {

    //Stored procedure to register networks of a student compared to a teacher's gps coordinates
    @Procedure("register_student_network")
    char registerStudentNetwork(int studentId, String ipAddress, int teachingNetworkId);
}
