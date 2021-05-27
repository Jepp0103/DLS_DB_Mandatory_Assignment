package com.example.demo.model.mongomodels;

import com.example.demo.model.mongoobjects.ClassObject;
import com.example.demo.model.mongoobjects.GpsCoordinatesObject;
import com.example.demo.model.mongoobjects.NetworkObject;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Id;

@Document(collection = "student")
public class StudentMongo {
    @Id private int _id;
    private String forename;
    private String surname;
    private String email_address;
    private String phone_number;
    private GpsCoordinatesObject gps_coordinates;
    private NetworkObject network;
    private ClassObject class_info;

    public int get_id() {
        return _id;
    }

    public void set_id(int _id) {
        this._id = _id;
    }

    public String getForename() {
        return forename;
    }

    public void setForename(String forename) {
        this.forename = forename;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getEmail_address() {
        return email_address;
    }

    public void setEmail_address(String email_address) {
        this.email_address = email_address;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public GpsCoordinatesObject getGps_coordinates() {
        return gps_coordinates;
    }

    public void setGps_coordinates(GpsCoordinatesObject gps_coordinates) {
        this.gps_coordinates = gps_coordinates;
    }

    public NetworkObject getNetwork() {
        return network;
    }

    public void setNetwork(NetworkObject network) {
        this.network = network;
    }

    public ClassObject getClass_info() {
        return class_info;
    }

    public void setClass_info(ClassObject class_info) {
        this.class_info = class_info;
    }
}