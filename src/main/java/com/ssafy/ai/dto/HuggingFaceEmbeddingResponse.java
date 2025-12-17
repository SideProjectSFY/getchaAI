package com.ssafy.ai.dto;

import java.util.List;

public class HuggingFaceEmbeddingResponse {
    private List<Double> embeddings;
    public List<Double> getEmbeddings() { return embeddings; }
}
