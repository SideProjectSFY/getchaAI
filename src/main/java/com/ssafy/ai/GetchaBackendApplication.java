package com.ssafy.ai;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(
        scanBasePackages = {
                "com.ssafy.ai",
                "com.ssafy.backend"
        }
)
@MapperScan("com.ssafy.backend.*.model")
public class GetchaBackendApplication {


    public static void main(String[] args) {
        SpringApplication.run(GetchaBackendApplication.class, args);

    }
}

