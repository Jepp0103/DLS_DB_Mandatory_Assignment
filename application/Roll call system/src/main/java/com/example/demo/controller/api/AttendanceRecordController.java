package com.example.demo.controller.api;
import com.example.demo.model.Address;
import com.example.demo.model.AttendanceRecord;
import com.example.demo.repository.AttendanceRecordRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class AttendanceRecordController {

    @Autowired
    private AttendanceRecordRepository attendanceRecordRepository;

    @GetMapping("/attendanceRecords") //Now working yet due to a primary key error because a primary key hasn't been added in db. It's mandatory to add primary keys in the entities in spring
    public Iterable<AttendanceRecord> getAttendanceRecords()  {
        return attendanceRecordRepository.findAll();
    }
}