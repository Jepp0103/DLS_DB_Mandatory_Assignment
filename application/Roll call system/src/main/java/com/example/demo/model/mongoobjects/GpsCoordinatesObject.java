package com.example.demo.model.mongoobjects;

public class GpsCoordinatesObject {
    private String longitude;
    private String latitude;

    public GpsCoordinatesObject(){}

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }
}
