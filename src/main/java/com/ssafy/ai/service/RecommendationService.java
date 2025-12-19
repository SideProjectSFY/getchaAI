package com.ssafy.ai.service;

import com.ssafy.backend.anime.model.AnimeMapper;
import com.ssafy.backend.anime.model.TmdbAnimeEntityDto;
import com.ssafy.backend.user.model.User;
import com.ssafy.backend.user.model.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RecommendationService {

    private final UserMapper userMapper;
    private final EmbeddingService embeddingService;
    private final AnimeMapper animeMapper;

    public List<TmdbAnimeEntityDto> recommend(Long userId) throws IOException {

        User user = userMapper.findById(userId);

        List<List<Double>> vectors = new ArrayList<>();
        List<Double> weights = new ArrayList<>();

        if (user.getLikedAnimeId1() != null) {
            vectors.add(embeddingService.getAnimeEmbedding(user.getLikedAnimeId1()));
            weights.add(0.5); //대표 선호
        }

        if (user.getLikedAnimeId2() != null) {
            vectors.add(embeddingService.getAnimeEmbedding(user.getLikedAnimeId2()));
            weights.add(0.3);
        }

        if (user.getLikedAnimeId3() != null) {
            vectors.add(embeddingService.getAnimeEmbedding(user.getLikedAnimeId3()));
            weights.add(0.2);
        }

        List<Double> userVector = embeddingService.weightedUserEmbedding(vectors, weights);

        List<String> ids = embeddingService.querySimilarAnime(userVector, 5);

        List<Long> animeIds = ids.stream()
                .map(Long::valueOf)
                .toList();

        return animeMapper.findByIds(animeIds);
    }
}

