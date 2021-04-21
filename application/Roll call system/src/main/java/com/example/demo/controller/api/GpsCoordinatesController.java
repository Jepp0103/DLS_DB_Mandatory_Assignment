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

    //Get mappings
    @GetMapping("/gpsCoordinates")
    public Iterable<GpsCoordinates> getGpsCoordinates()  {
        return gpsCoordinatesRepository.findAll();
    }

    //Post mappings
    @PostMapping("/addGpsCoordinates")
    public GpsCoordinates addGpsCoordinates(@RequestBody GpsCoordinates gpsCoordinates) {
        return gpsCoordinatesRepository.save(gpsCoordinates);
    }

    @PostMapping("/registerStudentGps")
    public String addRegisteredStudentGps(@RequestBody int studentId,
                                          @RequestBody int teacherId,
                                          @RequestBody double studentLatitude,
                                          @RequestBody double studentLongitude,
                                          @RequestBody double gpsRange) {
        return gpsCoordinatesRepository.registerStudentGps(studentId, teacherId, studentLatitude, studentLongitude, gpsRange);
    }
}