package com.example.demo.controller.api;
import com.example.demo.model.GpsCoordinates;
import com.example.demo.repository.GpsCoordinatesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class GpsCoordinatesController {

    @Autowired
    private GpsCoordinatesRepository gpsCoordinatesRepository;

    @GetMapping("/gpscoordinates") //Seems to work, but no values are displayed. Entity may be wrong...
    public Iterable<GpsCoordinates> getGpsCoordinates()  {
        return gpsCoordinatesRepository.findAll();
    }
}