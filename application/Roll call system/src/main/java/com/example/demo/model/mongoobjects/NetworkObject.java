package com.example.demo.model.mongoobjects;

public class NetworkObject {
    private String ssid;
    private String ip_address;
    private String faculty;


    public NetworkObject(String ssid, String ip_address, String faculty) {
        this.ssid = ssid;
        this.ip_address = ip_address;
        this.faculty = faculty;
    }

    public String getSsid() {
        return ssid;
    }

    public void setSsid(String ssid) {
        this.ssid = ssid;
    }

    public String getIp_address() {
        return ip_address;
    }

    public void setIp_address(String ip_address) {
        this.ip_address = ip_address;
    }

    public String getFaculty() {
        return faculty;
    }

    public void setFaculty(String faculty) {
        this.faculty = faculty;
    }
}
