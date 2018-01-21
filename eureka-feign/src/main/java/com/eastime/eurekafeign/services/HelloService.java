package com.eastime.eurekafeign.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

@Service
public class HelloService {

    @FeignClient(value = "service-client")
    public interface SchedualServiceHi {

        @RequestMapping(value = "/hi",method = RequestMethod.GET)
        String sayHiFromClientOne(@RequestParam(value = "name") String name);
    }

}