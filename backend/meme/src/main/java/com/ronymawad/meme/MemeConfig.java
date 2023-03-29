package com.ronymawad.meme;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class MemeConfig {

    @Bean
    public RestTemplate restTemplate (){
        return  new RestTemplate();
    }
}
