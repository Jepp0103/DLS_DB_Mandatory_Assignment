package com.example.demo.service;

import com.example.demo.model.Course;
import com.example.demo.model.StudentStats;
import com.example.demo.repository.CourseRepository;
import com.example.demo.repository.NetworkRepository;
import com.example.demo.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StudentService {

    @Autowired
    StudentRepository sr;
    @Autowired
    LectureService ls;
    @Autowired
    NetworkRepository nr;
    @Autowired
    CourseRepository cr;

    public Integer getStudentIdByUsername(String username){
        return sr.getStudentIdByUsername(username);
    }

    public Integer getClassIdByStudentId(int id){
        return sr.getClassIdByStudentId(id);
    }

    public boolean registerAttendence(int studentId,int teachers,double latitude, double longitude, int lectureId,String code, String studentSsid, String ipAddress, int studentFacultyId, int teachingNetworkId) {
        boolean lecturebegun=true;
        boolean withinrange=studentWithinRange(studentId,teachers,latitude,longitude);
        boolean correctcode=ls.correctCode(lectureId,code);
        boolean correctnetwork=correctNetwork(studentId,studentSsid,ipAddress,studentFacultyId,teachingNetworkId);
        if (correctcode && lecturebegun){
            if (withinrange || correctnetwork){
                try {
                    sr.registerAttendence(studentId, lectureId);
                }catch (Exception e){
                    sr.updateAttendence(studentId,lectureId);
                }
                return true;
            }
        }
        return false;
    }

    public boolean studentWithinRange(int student, int teacher, double latitude, double longitude) {
        if (sr.studentWithinRange(student,teacher,latitude,longitude)=='y'){ //fifth parameter is irrelevant atm.
            return true;
        }
        return false;
    }
    public boolean correctNetwork(int studentId, String studentSsid, String ipAddress, int studentFacultyId, int teachingNetworkId) {
        System.out.println(nr.registerStudentNetwork(studentId, studentSsid, ipAddress, studentFacultyId, teachingNetworkId));
        return nr.registerStudentNetwork(studentId, studentSsid, ipAddress, studentFacultyId, teachingNetworkId) == 'y';
    }
    public StudentStats getStudentStats(int studentid, int classid){
        List<Course> mycourses = cr.getClassCourses(classid);
        Map<String,Integer> participationrates= new HashMap<String,Integer>();

        for (Course course : mycourses)
        {
            Integer participationrate=sr.findSingleAttendenceRate(studentid,course.getId());
            if (participationrate!=null){
                participationrates.put(course.getName(),participationrate);
            }
        }
        Integer overallparticipationrate=sr.findSingleAttendenceRate(studentid);
        return new StudentStats(overallparticipationrate,participationrates);
    }

}
