package com.example.demo.controller.api;
import com.example.demo.model.Address;
import com.example.demo.repository.AddressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class AddressController {
    @Autowired
    private AddressRepository addressRepository;

    @GetMapping("/addresses")
    public Iterable<Address> getAddresses()  {
        return addressRepository.findAll();
    }
}