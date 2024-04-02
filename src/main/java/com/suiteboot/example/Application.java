package com.suiteboot.example;

import com.suiteopen.boot.EnableSuiteOpenBoot;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.JdbcClientAutoConfiguration;

@EnableSuiteOpenBoot
@SpringBootApplication
public class Application {
    public static void main(String[] args){
        SpringApplication.run(
                Application.class,
                args
        );
    }
}
