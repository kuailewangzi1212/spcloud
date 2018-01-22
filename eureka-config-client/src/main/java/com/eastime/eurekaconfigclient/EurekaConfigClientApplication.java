package com.eastime.eurekaconfigclient;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@EnableEurekaClient
@SpringBootApplication
@RestController
public class EurekaConfigClientApplication {

	public static void main(String[] args) {
		SpringApplication.run(EurekaConfigClientApplication.class, args);
	}



	@Value("${test.name}")
	String name;

	@RequestMapping("/hi")
	public String home(@RequestParam String name) {
		return "hi ,i am from config center";
	}
}
