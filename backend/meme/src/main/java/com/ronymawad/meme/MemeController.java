package com.ronymawad.meme;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("api/v1/memes")
public class MemeController {

    private MemeService memeService;

    @PostMapping
    public Object postMeme(@RequestParam("creatorId") Integer creatorId, @RequestParam("data") MultipartFile data){
        try {
            return memeService.postMeme(creatorId, data);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE);
        }
    }

    @PostMapping("/like/{memeId}/{likerId}")
    public void postLike(@PathVariable Integer memeId, @PathVariable Integer likerId){
        memeService.postLike(memeId, likerId);
    }

    @PostMapping("/unlike/{memeId}/{likerId}")
    public void unpostLike(@PathVariable Integer memeId, @PathVariable  Integer likerId){
        memeService.unpostLike(memeId, likerId);
    }

    @PostMapping("/comment/{memeId}/{commenterId}/{comment}")
    public void postComment(@PathVariable Integer memeId, @PathVariable Integer commenterId, @PathVariable String comment){
        memeService.postComment(memeId, commenterId, comment);
    }

    @GetMapping
    public List<MemeModel> getAllMemes(){
        return memeService.getAllMemes();
    }

    @GetMapping("/{creatorId}")
    public List<MemeModel> getMemesByCreatorId(@PathVariable Integer creatorId){
        return memeService.getMemesByCreatorId(creatorId);
    }

}
