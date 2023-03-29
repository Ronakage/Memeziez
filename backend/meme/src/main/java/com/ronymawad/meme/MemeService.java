package com.ronymawad.meme;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
@AllArgsConstructor
public class MemeService {
    private MemeRepository memeRepository;
    private RestTemplate restTemplate;

    public boolean isUserValidated(Integer userId){
       UserCheckValidationResponse response = restTemplate.getForObject("http://localhost:8080/api/v1/users/check-validation/{id}",
            UserCheckValidationResponse.class,
            userId);
        return response.isValid();
    }

    public boolean postMeme(MemePostRequest request) {
        if(isUserValidated(102)){
            return true;
        }
        else{
            return false;
        }
    }
}
