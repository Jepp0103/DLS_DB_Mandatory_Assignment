package com.example.demo.model;

public class StudentNetworkRegister {
    private int studentId;
    private String studentSsid;
    private String ipAddress;
    private int studentFacultyId;
    private int teachingNetworkId;

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getStudentSsid() {
        return studentSsid;
    }

    public void setStudentSsid(String studentSsid) {
        this.studentSsid = studentSsid;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public int getStudentFacultyId() {
        return studentFacultyId;
    }

    public void setStudentFacultyId(int studentFacultyId) {
        this.studentFacultyId = studentFacultyId;
    }

    public int getTeachingNetworkId() {
        return teachingNetworkId;
    }

    public void setTeachingNetworkId(int teachingNetworkId) {
        this.teachingNetworkId = teachingNetworkId;
    }


}
