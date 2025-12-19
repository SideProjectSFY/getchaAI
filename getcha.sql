DROP DATABASE IF EXISTS getcha;
CREATE DATABASE getcha DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE getcha;

-- =========================
-- TMDB 테이블
-- =========================
CREATE TABLE tmdb_genre (
    id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE tmdb_anime (
    id BIGINT NOT NULL,
    title VARCHAR(255),
    poster_url VARCHAR(255),
    overview TEXT,
    vote_average DOUBLE,
    vote_count BIGINT,
    popularity DOUBLE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE anime_genre (
    tmdb_genre_id INT NOT NULL,
    anime_id BIGINT NOT NULL,
    PRIMARY KEY (tmdb_genre_id, anime_id)
);

-- =========================
-- USER
-- =========================
CREATE TABLE user (
    id BIGINT NOT NULL,
    liked_anime_id1 BIGINT NOT NULL,
    liked_anime_id2 BIGINT NOT NULL,
    liked_anime_id3 BIGINT NOT NULL,
    name VARCHAR(255),
    nickname VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    is_auth BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    account_num VARCHAR(255),
    account_bank VARCHAR(255),
    PRIMARY KEY (id)
);



-- =========================
-- GOODS
-- =========================
CREATE TABLE goods (
    id BIGINT NOT NULL AUTO_INCREMENT,
    seller_id VARCHAR(36) NOT NULL,
    anime_id BIGINT NOT NULL,
    category VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    start_price INT NOT NULL,
    instant_buy_price INT,
    auction_status VARCHAR(50) NOT NULL,
    duration INT NOT NULL DEFAULT 3,
    auction_end_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE goods_image (
    id BIGINT NOT NULL AUTO_INCREMENT,
    goods_id BIGINT NOT NULL,
    file_path VARCHAR(512) NOT NULL,
    origin_filename VARCHAR(255) NOT NULL,
    stored_filename VARCHAR(255) NOT NULL,
    file_size BIGINT,
    sort_order INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

-- =========================
-- WISHLIST
-- =========================
CREATE TABLE wishlist (
    id BIGINT NOT NULL AUTO_INCREMENT,
    goods_id BIGINT NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

-- =========================
-- BID
-- =========================
CREATE TABLE bid (
    id BIGINT NOT NULL AUTO_INCREMENT,
    goods_id BIGINT NOT NULL,
    bidder_id VARCHAR(36) NOT NULL,
    bid_amount INT NOT NULL,
    is_highest BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

-- =========================
-- COMMENT
-- =========================
CREATE TABLE comment (
    id BIGINT NOT NULL AUTO_INCREMENT,
    goods_id BIGINT NOT NULL,
    writer_id VARCHAR(36) NOT NULL,
    parent_id BIGINT,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    PRIMARY KEY (id)
);

-- =========================
-- WALLET
-- =========================
CREATE TABLE coin_wallet (
    id BIGINT NOT NULL AUTO_INCREMENT,
    user_id VARCHAR(36) NOT NULL,
    balance INT NOT NULL,
    locked_balance INT,
    PRIMARY KEY (id)
);

CREATE TABLE wallet_history (
    id BIGINT NOT NULL AUTO_INCREMENT,
    wallet_id BIGINT NOT NULL,
    goods_id BIGINT NOT NULL,
    transaction_type VARCHAR(50) NOT NULL,
    amount INT NOT NULL,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);
INSERT INTO tmdb_genre (id, name) VALUES
(10759, 'Action & Adventure'),
(16, 'Animation'),
(35, 'Comedy'),
(80, 'Crime'),
(99, 'Documentary'),
(18, 'Drama'),
(10751, 'Family'),
(10762, 'Kids'),
(9648, 'Mystery'),
(10763, 'News'),
(10764, 'Reality'),
(10765, 'Sci-Fi & Fantasy'),
(10766, 'Soap'),
(10767, 'Talk'),
(10768, 'War & Politics'),
(37, 'Western');



SELECT * FROM tmdb_anime;
SELECT * FROM tmdb_genre;
select * from anime_genre;

desc user; 

SELECT id, title, popularity, overview
FROM tmdb_anime
WHERE overview IS NOT NULL
ORDER BY popularity DESC
LIMIT 50;

INSERT INTO user (id, liked_anime_id1, liked_anime_id2, liked_anime_id3, name, nickname)
VALUES
(1001, 37854, 46260, 30984, '소년만화유저', '점프러버'),
(1002, 1429, 114410, 95479, '다크액션유저', '피맛덕후'),
(1003, 46298, 209867, 97525, '판타지유저', '세계관중독'),
(1004, 456, 1434, 60625, '시트콤유저', '미국애니덕후'),
(1005, 60572, 57911, 57775, '패밀리유저', '힐링러버'),
(1006, 120089, 63926, 127532, '트렌드유저', '요즘애니봄');

select * from user;
select count(*) from tmdb_anime;
select count(*) from anime_genre;
SELECT id FROM user;


CREATE TABLE anime_genre_backup AS
SELECT * FROM anime_genre;

TRUNCATE TABLE anime_genre;
TRUNCATE TABLE tmdb_anime;
DELETE FROM tmdb_anime WHERE id = 57911;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM anime_genre WHERE anime_id = 57911;




