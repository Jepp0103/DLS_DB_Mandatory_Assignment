package com.example.demo.model;

public class RegisterAttendenceRequest {
    int teacherid;

    double latitude;

    double longitude;

    int lectureid;

    String code;

    String studentSSID;

    String ipaddress;

    int teachingnetworkid;

    int facultyid;



    public int getTeacherid() {
        return teacherid;
    }

    public void setTeacherid(int teacherid) {
        this.teacherid = teacherid;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public int getLectureid() {
        return lectureid;
    }

    public void setLectureid(int lectureid) {
        this.lectureid = lectureid;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getStudentSSID() {
        return studentSSID;
    }

    public void setStudentSSID(String studentSSID) {
        this.studentSSID = studentSSID;
    }

    public String getIpaddress() {
        return ipaddress;
    }

    public void setIpaddress(String ipaddress) {
        this.ipaddress = ipaddress;
    }

    public int getFacultyid() {
        return facultyid;
    }

    public void setFacultyid(int facultyid) {
        this.facultyid = facultyid;
    }
    public int getTeachingnetworkid() {
        return teachingnetworkid;
    }

    public void setTeachingnetworkid(int teachingnetworkid) {
        this.teachingnetworkid = teachingnetworkid;
    }
}
