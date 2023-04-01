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
        UserGetUsernameResponse response = restTemplate.getForObject("http://localhost:8080/api/v1/users/check-username/{id}",
                UserGetUsernameResponse.class,
                creatorId);
        if(isUserValidated(creatorId)){
            MemeModel meme = MemeModel.builder()
                    .creatorId(creatorId)
                    .creatorUsername(response.username())
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

    public void postLike(Integer memeId, Integer likerId) {
        UserGetUsernameResponse response = restTemplate.getForObject("http://localhost:8080/api/v1/users/check-username/{id}",
                UserGetUsernameResponse.class,
                likerId);
        MemeModel meme =  memeRepository.findById(memeId).orElseThrow();
        LikeModel like = LikeModel.builder()
                .likerId(likerId)
                .likerUsername(response.username())
                .likedAt(LocalDateTime.now())
                .build();
        List<LikeModel> likes  = meme.getLikes();
        LikeModel likeFound =likes.stream()
                .filter(l -> l.getLikerId() == likerId)
                .findAny()
                .orElse(null);
        if(likeFound == null){
            likes.add(like);
            meme.setLikes(likes);
            memeRepository.save(meme);
        }
    }

    public void unpostLike(Integer memeId, Integer likerId) {
        MemeModel meme =  memeRepository.findById(memeId).orElseThrow();
        LikeModel like = LikeModel.builder()
                .likerId(likerId)
                .likedAt(LocalDateTime.now())
                .build();
        List<LikeModel> likes  = meme.getLikes();
        likes.removeIf(l -> l.getLikerId() == likerId);
        meme.setLikes(likes);
        memeRepository.save(meme);
    }

    public void postComment(Integer memeId, Integer commenterId, String comment) {
        UserGetUsernameResponse response = restTemplate.getForObject("http://localhost:8080/api/v1/users/check-username/{id}",
                UserGetUsernameResponse.class,
                commenterId);
        MemeModel meme =  memeRepository.findById(memeId).orElseThrow();
        CommentModel commentObj = CommentModel.builder()
                .commenterId(commenterId)
                .commenterUsername(response.username())
                .comment(comment)
                .commentedAt(LocalDateTime.now())
                .build();
        List<CommentModel> comments = meme.getComments();
        comments.add(commentObj);
        meme.setComments(comments);
        memeRepository.save(meme);
    }

    public List<MemeModel> getAllMemes() {
        return memeRepository.findAll();
    }

    public List<MemeModel> getMemesByCreatorId(Integer creatorId) {
        return memeRepository.findAllByCreatorId(creatorId);
    }

}
