spcloud
================

说明

# eureka

eureka是一个服务注册和发现模块,包括两部分server和client,server端核心是提供了自动维护的服务注册表，供服务提供者注册服务和消费端发现服务。
 
 **1.server**
 * **依赖**
         
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-eureka-server</artifactId>
        </dependency>
    
 * **注解**
 在工程的启动类中,通过@EnableEurekaServer注意EurekaServer
       
 * **配置**
 
        server:
          port: 8761
        
        eureka:
          instance:
            hostname: 10.211.55.5
          client:
            registerWithEureka: false
            fetchRegistry: false
            serviceUrl:
              defaultZone: http://${eureka.instance.hostname}:${server.port}/eureka/
          server:
            enable-self-preservation: false


**2.client**
 * **依赖**
         
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-eureka</artifactId>
        </dependency>
    
 * **注解**
 在工程的启动类中,通过@EnableEurekaClient
       
 * **配置**

        eureka:
          client:
            serviceUrl:
              defaultZone: http://10.211.55.5:8761/eureka/
          instance:
            prefer-ip-address: true 
 
# ribbon

ribbon和Feign都是服务消费者,ribbon是一个负载均衡客户端，Feign默认集成了ribbon,Feign增加了一些工具类，使Ribbon使用起来更加方便。
 * **依赖**
         
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-eureka</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-ribbon</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    
 * **注解**
 在工程的启动类中,通过@EnableDiscoveryClient向服务中心注册；并且向程序的ioc注入一个bean: restTemplate;并通过@LoadBalanced注解表明这个restRemplate开启负载均衡的功能。
       
 * **配置**
 
         eureka:
           client:
             serviceUrl:
               defaultZone: http://10.211.55.5:8761/eureka/
         server:
           port: 8764
         spring:
           application:
             name: service-ribbon
             
             
# Feign

Feign是一个声明式的伪Http客户端,它使得写Http客户端变得更简单,Feign默认集成了Ribbon,默认实现了客户端负载均衡


 * **依赖**
       
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-eureka</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-feign</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>       
    
 * **注解**
 
       
 * **配置**
 
                   