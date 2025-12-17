package com.ssafy.ai.controller;

import com.ssafy.ai.service.RecommendationService;
import com.ssafy.backend.anime.model.TmdbAnimeEntityDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/recommend")
public class RecommendationController {

    private final RecommendationService recommendationService;

    @GetMapping("/{userId}")
    public List<TmdbAnimeEntityDto> recommend(@PathVariable Long userId) throws IOException {
        return recommendationService.recommend(userId);
    }
}
