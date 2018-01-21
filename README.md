spcloud
================

说明

# Screenshots


# Features
* **统一管理不同环境、不同集群的配置**
  * Apollo提供了一个统一界面集中式管理不同环境（environment）、不同集群（cluster）、不同命名空间（namespace）的配置。
  * 同一份代码部署在不同的集群，可以有不同的配置，比如zk的地址等
  * 通过命名空间（namespace）可以很方便的支持多个不同应用共享同一份配置，同时还允许应用对共享的配置进行覆盖

* **配置修改实时生效（热发布）**
  * 用户在Apollo修改完配置并发布后，客户端能实时（1秒）接收到最新的配置，并通知到应用程序。

# eureka-ribbon

ribbon是一个负载均衡客户端，Feign默认集成了ribbon
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