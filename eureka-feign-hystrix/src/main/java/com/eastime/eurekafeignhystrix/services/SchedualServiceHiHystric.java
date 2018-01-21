package com.eastime.eurekafeignhystrix.services;

import org.springframework.stereotype.Component;

@Component
public class SchedualServiceHiHystric implements HelloService.SchedualServiceHi {
    @Override
    public String sayHiFromClientOne(String name) {
        return "sorry "+name;
    }
}
