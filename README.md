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
 
        @EnableDiscoveryClient
        @EnableFeignClients 
 
       
 * **配置**

        eureka:
          client:
            serviceUrl:
              defaultZone: http://10.211.55.5:8761/eureka/
          instance:
              prefer-ip-address: true
        
        server:
          port: 8765
        spring:
          application:
            name: service-feign 
 
 * **Usage**   
  
   **1、service**
 
        @FeignClient(value = "service-client")
        public interface SchedualServiceHi {
        
            @RequestMapping(value = "/hi",method = RequestMethod.GET)
            String sayHiFromClientOne(@RequestParam(value = "name") String name);
        }  
                 
    **2、controller**    
    
        @Autowired
        HelloService.SchedualServiceHi schedualServiceHi;
        
        @RequestMapping(value = "/hi",method = RequestMethod.GET)
        public String sayHi(@RequestParam String name){
            return schedualServiceHi.sayHiFromClientOne(name);
        }   
        
        

# Hystrix

hystrix实现了超时机制和断路器机制。负载均衡在不改变程序的前提下，通过增加硬件或改变部署方式，实现应用并发数量的横向扩展达到高可用、高并发。hystrix的超时机制和断路器机制解决应用在异常情况下的高可用。

 * **依赖**
 
 加入依赖(Ribbon和Feign都要引入)
 
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-hystrix</artifactId>
        </dependency>       


 如果要加入断路器仪表盘，则需要引入下列依赖(Ribbon和Feign都要引入)
 
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-hystrix-dashboard</artifactId>
        </dependency>

        
           
 * **注解**
 
 Ribbon 上增加的注解：@EnableHystrix和@EnableHystrixDashboard
 
 Feign 上增加的注解：@EnableHystrixDashboard和@EnableCircuitBreaker
       
 * **配置**
 
  Feign是自带断路器的，在低版本的Spring Cloud中，它没有默认打开。需要在配置文件中配置打开它，在配置文件加以下代码(此处是个大坑,没有自动提示功能，还以为是版本的问题，直接加上去就OK了)
 
         feign:
           hystrix:
             enabled: true 
        
  Ribbon配置不需要修改
 
 * **Usage**   
 
 在Service方法上加上@HystrixCommand注解。该注解对该方法创建了熔断器的功能，并指定了fallbackMethod熔断方法
  
   **1、service**
   * **Ribbon service 改造**
    <pre>
        @Autowired
        RestTemplate restTemplate;
        @HystrixCommand(fallbackMethod = "hiError")
        public String hiService(String name) {
            return restTemplate.getForObject("http://SERVICE-CLIENT/hi?name="+name,String.class);
        }        
        public String hiError(String name) {
            return "hi"+name+",sorry ,i am Hiystrix!";
        }               
    </pre> 
      
   * **Fegin service 改造**
   
   <pre>
        @Service
        public class HelloService {        
            @FeignClient(value = "service-client",fallback = SchedualServiceHiHystric.class)
            public interface SchedualServiceHi {        
                @RequestMapping(value = "/hi",method = RequestMethod.GET)
                String sayHiFromClientOne(@RequestParam(value = "name") String name);
            }
        }        
        @Component
        public class SchedualServiceHiHystric implements HelloService.SchedualServiceHi {
            @Override
            public String sayHiFromClientOne(String name) {
                return "sorry "+name;
            }
        }
      </pre>
   **2、controller**    
    无需调整


# Zuul

路由转发和服务过滤


 * **依赖**

        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-zuul</artifactId>
        </dependency>  
 
 
 * **注解**

        @EnableZuulProxy
        
        
 * **配置**
 
        zuul:
          routes:
            api-a:
              path: /api-a/**
              serviceId: service-ribbon
            api-b:
              path: /api-b/**
              serviceId: service-feign      