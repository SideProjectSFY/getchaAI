package com.ssafy.ai.init;

import com.ssafy.backend.anime.service.AnimeService;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

//@Component
@RequiredArgsConstructor
public class AnimeInitRunner implements CommandLineRunner {

    private final AnimeService animeService;

    @Override
    public void run(String... args) {
        System.out.println("🚀 TMDB 애니 초기 수집 시작");
        animeService.bulkSyncAnimeFromTmdb(200);
        System.out.println("✅ TMDB 애니 초기 수집 완료");
    }
}
