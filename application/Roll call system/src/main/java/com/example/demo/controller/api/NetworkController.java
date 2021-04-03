package com.example.demo.controller.api;
        import com.example.demo.model.Network;
        import com.example.demo.repository.NetworkRepository;
        import org.springframework.beans.factory.annotation.Autowired;
        import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/api")
public class NetworkController {

    @Autowired
    private NetworkRepository networkRepository;

    @GetMapping("/networks")
    public Iterable<Network> getNetworks()  {
        return networkRepository.findAll();
    }
}