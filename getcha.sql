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

SELECT DISTINCT tmdb_genre_id
FROM anime_genre
ORDER BY tmdb_genre_id;


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

select * from anime_genre_backup;


CREATE TABLE anime_genre_backup AS
SELECT * FROM anime_genre;

TRUNCATE TABLE anime_genre;
TRUNCATE TABLE tmdb_anime;
DELETE FROM tmdb_anime WHERE id = 57911;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM anime_genre WHERE anime_id = 57911;

SHOW CREATE TABLE anime_genre;

-- 특정 anime_id의 장르를 시간순으로 확인
SELECT ag.*, NOW()
FROM anime_genre ag
WHERE ag.anime_id = 926
ORDER BY ag.tmdb_genre_id;


-- anime_genre 테이블 구조 확인
SHOW CREATE TABLE anime_genre;


SELECT
  COUNT(*)        AS total_rows,
  COUNT(DISTINCT anime_id) AS anime_cnt,
  COUNT(DISTINCT tmdb_genre_id) AS genre_cnt
FROM anime_genre;

SELECT tmdb_genre_id, COUNT(*) AS cnt
FROM anime_genre
GROUP BY tmdb_genre_id
ORDER BY tmdb_genre_id;

SELECT tmdb_genre_id, anime_id 
FROM anime_genre 
WHERE anime_id IN (926, 1042, 1570, 14451, 35610)
ORDER BY anime_id, tmdb_genre_id;

-- overview가 있는 애니 총 개수
SELECT COUNT(*) AS cnt
FROM tmdb_anime
WHERE overview IS NOT NULL
  AND TRIM(overview) <> '';

-- (임시!)

INSERT INTO getcha.goods (id, seller_id, anime_id, category, title, description, start_price, instant_buy_price, auction_status, duration, auction_end_at, created_at, updated_at, deleted_at) VALUES (1, 3, 2005, 'DOLL', '빨간 안경곰 인형', '귀여운 인형입니더 ^~^', 10000, 30000, 'COMPLETED', 3, '2025-12-24 19:47:59', '2025-12-21 19:47:59', null, null);
INSERT INTO getcha.goods (id, seller_id, anime_id, category, title, description, start_price, instant_buy_price, auction_status, duration, auction_end_at, created_at, updated_at, deleted_at) VALUES (2, 3, 31910, 'FIGURE', '불타는 키티', '열코!', 10000, 30000, 'COMPLETED', 1, '2025-12-22 00:27:10', '2025-12-21 20:06:10', null, null);
INSERT INTO getcha.goods (id, seller_id, anime_id, category, title, description, start_price, instant_buy_price, auction_status, duration, auction_end_at, created_at, updated_at, deleted_at) VALUES (3, 5, 57911, 'KEYRING', '메론빵 !!!!!!!!!!', '메론빵 맛있겠다', 10000, 50000, 'COMPLETED', 2, '2025-12-23 21:08:21', '2025-12-21 21:08:21', null, null);
INSERT INTO getcha.goods (id, seller_id, anime_id, category, title, description, start_price, instant_buy_price, auction_status, duration, auction_end_at, created_at, updated_at, deleted_at) VALUES (4, 6, 63401, 'OTHER', '목욕하는 넝담곰', '목욕하는 농담곰임니댜', 10000, 20000, 'COMPLETED', 2, '2025-12-23 23:58:29', '2025-12-21 23:58:29', null, null);
INSERT INTO getcha.goods (id, seller_id, anime_id, category, title, description, start_price, instant_buy_price, auction_status, duration, auction_end_at, created_at, updated_at, deleted_at) VALUES (5, 3, 68586, 'BADGE', '나이를 팝니다..', '29살이요', 5000, 20000, 'COMPLETED', 1, '2025-12-22 00:45:34', '2025-12-22 00:39:34', null, '2025-12-22 00:52:37');
INSERT INTO getcha.goods (id, seller_id, anime_id, category, title, description, start_price, instant_buy_price, auction_status, duration, auction_end_at, created_at, updated_at, deleted_at) VALUES (6, 3, 120241, 'BADGE', '나이를 팝니다 ..', '제발 가져가', 5000, 20000, 'COMPLETED', 1, '2025-12-22 00:59:01', '2025-12-22 00:55:01', null, null);
INSERT INTO getcha.goods (id, seller_id, anime_id, category, title, description, start_price, instant_buy_price, auction_status, duration, auction_end_at, created_at, updated_at, deleted_at) VALUES (7, 3, 97959, 'DOLL', '인기리스트에 뜰까여', '과연??!!!!', 5000, 20000, 'WAIT', 2, '2025-12-24 09:15:18', '2025-12-22 09:15:18', null, null);
INSERT INTO getcha.goods (id, seller_id, anime_id, category, title, description, start_price, instant_buy_price, auction_status, duration, auction_end_at, created_at, updated_at, deleted_at) VALUES (8, 6, 76140, 'POSTER', '인생네컷 팝니다', '기엽져?', 10000, 12000, 'PROCEEDING', 2, '2025-12-24 09:23:51', '2025-12-22 09:23:51', null, null);
INSERT INTO goods (
  seller_id, anime_id, category, title, start_price, auction_status, auction_end_at, created_at
)
VALUES (
  2,            -- userId 1001 아님
  5,
  31910,        -- 추천 애니 ID 중 하나
  'AI 테스트 굿즈',
  10000,
  'ONGOING',
  NOW() + INTERVAL 2 DAY,
  NOW()
);


-- goods_image 테이블
INSERT INTO getcha.goods_image (id, goods_id, file_path, origin_filename, stored_filename, file_size, sort_order, created_at) VALUES (1, 1, '/images/9f52894d-7393-46e9-86c4-f60b89fd5a8b_빨간안경곰.jpg', '빨간안경곰.jpg', '9f52894d-7393-46e9-86c4-f60b89fd5a8b_빨간안경곰.jpg', 25852, 1, '2025-12-21 19:47:58');
INSERT INTO getcha.goods_image (id, goods_id, file_path, origin_filename, stored_filename, file_size, sort_order, created_at) VALUES (2, 2, '/images/2c21ebd3-6cc6-444b-bfeb-10af631bcff6_Unknown.jpg', 'Unknown.jpg', '2c21ebd3-6cc6-444b-bfeb-10af631bcff6_Unknown.jpg', 74633, 1, '2025-12-21 20:06:09');
INSERT INTO getcha.goods_image (id, goods_id, file_path, origin_filename, stored_filename, file_size, sort_order, created_at) VALUES (3, 3, '/images/84697c3c-7e69-4c00-8b69-9e2d48e3bf54_ .jpg', ' .jpg', '84697c3c-7e69-4c00-8b69-9e2d48e3bf54_ .jpg', 110631, 1, '2025-12-21 21:08:21');
INSERT INTO getcha.goods_image (id, goods_id, file_path, origin_filename, stored_filename, file_size, sort_order, created_at) VALUES (4, 4, '/images/ae5c485e-1651-4c06-a537-627d3acb12ac_Unknown-2.jpg', 'Unknown-2.jpg', 'ae5c485e-1651-4c06-a537-627d3acb12ac_Unknown-2.jpg', 32957, 1, '2025-12-21 23:58:28');
INSERT INTO getcha.goods_image (id, goods_id, file_path, origin_filename, stored_filename, file_size, sort_order, created_at) VALUES (5, 5, '/images/340b216b-a1d7-41aa-8921-bdefa86ad666_29.jpeg', '29.jpeg', '340b216b-a1d7-41aa-8921-bdefa86ad666_29.jpeg', 73945, 1, '2025-12-22 00:39:34');
INSERT INTO getcha.goods_image (id, goods_id, file_path, origin_filename, stored_filename, file_size, sort_order, created_at) VALUES (6, 6, '/images/8f8b2108-d646-4087-bf9a-46e4ca6dac46_29.jpeg', '29.jpeg', '8f8b2108-d646-4087-bf9a-46e4ca6dac46_29.jpeg', 73945, 1, '2025-12-22 00:55:00');
INSERT INTO getcha.goods_image (id, goods_id, file_path, origin_filename, stored_filename, file_size, sort_order, created_at) VALUES (7, 7, '/images/b96a6348-114c-4373-b035-4e17091bc681_지옥의 시험기간.jpg', '지옥의 시험기간.jpg', 'b96a6348-114c-4373-b035-4e17091bc681_지옥의 시험기간.jpg', 41382, 1, '2025-12-22 09:15:18');
INSERT INTO getcha.goods_image (id, goods_id, file_path, origin_filename, stored_filename, file_size, sort_order, created_at) VALUES (8, 8, '/images/9bf50e17-af45-4641-938b-37bb5961e4cd_헬로키티 포토부스.jpg', '헬로키티 포토부스.jpg', '9bf50e17-af45-4641-938b-37bb5961e4cd_헬로키티 포토부스.jpg', 39034, 1, '2025-12-22 09:23:50');

UPDATE getcha.goods
SET auction_status = 'ONGOING'
WHERE id = 8;

SELECT * from goods;