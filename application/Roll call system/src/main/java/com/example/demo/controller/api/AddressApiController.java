package com.example.demo.controller.api;
import com.example.demo.model.Address;
import com.example.demo.model.Lecture;
import com.example.demo.repository.AddressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class AddressApiController {
    @Autowired
    private AddressRepository addressRepository;

    @GetMapping("/addresses") //Not working yet. Something wrong in the entity
    public Iterable<Address> getAddresses()  {
        return addressRepository.findAll();
    }
}