package com.ronymawad.meme;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("api/v1/memes")
public class MemeController {

    private MemeService memeService;

    @PostMapping
    public boolean postMeme(@RequestBody MemePostRequest request){//@RequestBody MemePostRequest request
        return memeService.postMeme(request);
    }
}
