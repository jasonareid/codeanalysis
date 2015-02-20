package com.jasonreid.codeanalysis;

import co.paralleluniverse.springframework.boot.autoconfigure.web.FiberWebMvcAutoConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@ComponentScan
@EnableAutoConfiguration
@Import({FiberWebMvcAutoConfiguration.class})
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }

}
