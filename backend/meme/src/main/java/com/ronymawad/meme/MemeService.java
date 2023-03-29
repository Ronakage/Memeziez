package com.ronymawad.meme;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;

@Service
@AllArgsConstructor
public class MemeService {
    private MemeRepository memeRepository;
    private RestTemplate restTemplate;

    public Boolean isUserValidated(Integer userId){
       UserCheckValidationResponse response = restTemplate.getForObject("http://localhost:8080/api/v1/users/check-validation/{id}",
            UserCheckValidationResponse.class,
            userId);
        return response.isValid();
    }

    public MemeModel postMeme(Integer creatorId, MultipartFile data) throws Exception {
        if(isUserValidated(creatorId)){
            MemeModel meme = MemeModel.builder()
                    .creatorId(creatorId)
                    .createdAt(LocalDateTime.now())
                    .data(data.getBytes())
                    .build();
            memeRepository.save(meme);
            return meme;
        }
        else{
            throw new Exception();
        }
    }

    public List<MemeModel> getAllMemes() {
        return memeRepository.findAll();
    }

    public List<MemeModel> getMemesByCreatorId(Integer creatorId) {
        return memeRepository.findAllByCreatorId(creatorId);
    }
}
