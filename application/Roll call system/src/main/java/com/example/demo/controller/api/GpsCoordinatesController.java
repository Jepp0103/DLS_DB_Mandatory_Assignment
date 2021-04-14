package com.example.demo.controller.api;
import com.example.demo.model.GpsCoordinates;
import com.example.demo.model.Lecture;
import com.example.demo.repository.GpsCoordinatesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class GpsCoordinatesController {

    @Autowired
    private GpsCoordinatesRepository gpsCoordinatesRepository;

    //Get mappings
    @GetMapping("/gpsCoordinates") //Seems to work, but no values are displayed. Entity may be wrong...
    public Iterable<GpsCoordinates> getGpsCoordinates()  {
        return gpsCoordinatesRepository.findAll();
    }

    //Post mappings
    @PostMapping("/addGpsCoordinates")
    public GpsCoordinates addGpsCoordinates(@RequestBody GpsCoordinates gpsCoordinates) {
        return gpsCoordinatesRepository.save(gpsCoordinates);
    }
}