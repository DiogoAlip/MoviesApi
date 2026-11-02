CREATE DATABASE IF NOT EXISTS movie_api_db;
USE movie_api_db;

-- ============================================================
-- TABLES
-- ============================================================

CREATE TABLE IF NOT EXISTS movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    duration INT NOT NULL,
    poster TEXT,
    rate DECIMAL(2,1) NOT NULL,
    synopsis TEXT
);

CREATE TABLE IF NOT EXISTS genres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS movie_genres (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS persons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    birthdate DATE NOT NULL,
    deathdate DATE,
    biography TEXT,
    photo TEXT
);

CREATE TABLE IF NOT EXISTS movie_persons (
    movie_id INT,
    person_id INT,
    role VARCHAR(255) NOT NULL,
    PRIMARY KEY (movie_id, person_id, role),
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES persons(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS users (
    id BINARY(16) DEFAULT (UUID_TO_BIN(UUID())) NOT NULL PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS watchlists (
    id BINARY(16) DEFAULT (UUID_TO_BIN(UUID())) NOT NULL PRIMARY KEY,
    user_id BINARY(16) NOT NULL,
    movie_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS reviews (
    id BINARY(16) DEFAULT (UUID_TO_BIN(UUID())) NOT NULL PRIMARY KEY,
    movie_id INT NOT NULL,
    user_id BINARY(16) NOT NULL,
    review TEXT NOT NULL,
    rating DECIMAL(2,1) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ============================================================
-- SEED: GENRES
-- ============================================================

INSERT INTO genres (name, description) VALUES
('Drama',       'Stories focused on realistic characters dealing with emotional themes'),
('Comedy',      'Light-hearted stories designed to amuse and entertain'),
('Action',      'Fast-paced stories with physical feats and conflict'),
('Crime',       'Stories centered around criminal activity and justice'),
('Adventure',   'Exciting journeys and explorations'),
('Sci-Fi',      'Speculative fiction based on science and technology'),
('Romance',     'Stories centered on love and romantic relationships'),
('Animation',   'Stories told through animated visuals'),
('Documental',  'Non-fiction films documenting real events or subjects'),
('Biography',   'Dramatized accounts of real people''s lives'),
('Fantasy',     'Stories set in imaginary worlds with magical elements'),
('Thriller',    'Suspenseful stories designed to keep audiences on edge'),
('Horror',      'Stories designed to frighten and unsettle'),
('Mystery',     'Stories focused on solving a puzzle or crime'),
('Musical',     'Stories told through song and dance'),
('War',         'Stories set during armed conflicts'),
('Western',     'Stories set in the American Old West'),
('Family',      'Stories suitable for all ages'),
('Sport',       'Stories centered around athletic competition'),
('History',     'Stories based on historical events');

-- ============================================================
-- SEED: MOVIES (15)
-- ============================================================

INSERT INTO movies (title, year, duration, poster, rate, synopsis) VALUES
('The Shawshank Redemption', 1994, 142,
 'https://i.ebayimg.com/images/g/4goAAOSwMyBe7hnQ/s-l1200.webp', 9.3,
 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.'),

('The Dark Knight', 2008, 152,
 'https://i.ebayimg.com/images/g/yokAAOSw8w1YARbm/s-l1200.jpg', 9.0,
 'When the menace known as the Joker wreaks havoc on Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.'),

('Inception', 2010, 148,
 'https://m.media-amazon.com/images/I/91Rc8cAmnAL._AC_UF1000,1000_QL80_.jpg', 8.8,
 'A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.'),

('Pulp Fiction', 1994, 154,
 'https://www.themoviedb.org/t/p/original/vQWk5YBFWF4bZaofAbv0tShwBvQ.jpg', 8.9,
 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.'),

('Forrest Gump', 1994, 142,
 'https://i.ebayimg.com/images/g/qR8AAOSwkvRZzuMD/s-l1600.jpg', 8.8,
 'The presidencies of Kennedy and Johnson, the Vietnam War, and other historical events unfold from the perspective of an Alabama man with an IQ of 75.'),

('Gladiator', 2000, 155,
 'https://img.fruugo.com/product/0/60/14417600_max.jpg', 8.5,
 'A former Roman General sets out to exact vengeance against the corrupt emperor who murdered his family and sent him into slavery.'),

('The Matrix', 1999, 136,
 'https://i.ebayimg.com/images/g/QFQAAOSwAQpfjaA6/s-l1200.jpg', 8.7,
 'A computer hacker learns about the true nature of his reality and his role in the war against its controllers.'),

('Interstellar', 2014, 169,
 'https://m.media-amazon.com/images/I/91obuWzA3XL._AC_UF1000,1000_QL80_.jpg', 8.6,
 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.'),

('The Lord of the Rings: The Return of the King', 2003, 201,
 'https://i.ebayimg.com/images/g/0hoAAOSwe7peaMLW/s-l1600.jpg', 8.9,
 'Gandalf and Aragorn lead the World of Men against Sauron''s army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.'),

('The Lion King', 1994, 88,
 'https://m.media-amazon.com/images/I/81BMmrwSFOL._AC_UF1000,1000_QL80_.jpg', 8.5,
 'Lion prince Simba flees his kingdom after the murder of his father, only to learn the true meaning of responsibility and bravery.'),

('The Avengers', 2012, 143,
 'https://img.fruugo.com/product/7/41/14532417_max.jpg', 8.0,
 'Earth''s mightiest heroes must come together to stop Loki and his alien army from enslaving humanity.'),

('Jurassic Park', 1993, 127,
 'https://vice-press.com/cdn/shop/products/Jurassic-Park-Editions-poster-florey.jpg?v=1654518755&width=1024', 8.1,
 'A pragmatic paleontologist touring an almost complete theme park is tasked with protecting a couple of kids after a power failure causes the park''s cloned dinosaurs to run loose.'),

('Titanic', 1997, 195,
 'https://i.pinimg.com/originals/42/42/65/4242658e6f1b0d6322a4a93e0383108b.png', 7.8,
 'A seventeen-year-old aristocrat falls in love with a kind but poor artist aboard the luxurious, ill-fated R.M.S. Titanic.'),

('The Social Network', 2010, 120,
 'https://i.pinimg.com/originals/7e/37/b9/7e37b994b613e94cba64f307b1983e39.jpg', 7.7,
 'As Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, he is sued by the twins who claimed he stole their idea.'),

('Avatar', 2009, 162,
 'https://i.etsystatic.com/35681979/r/il/dfe3ba/3957859451/il_fullxfull.3957859451_h27r.jpg', 7.8,
 'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.');

-- ============================================================
-- SEED: MOVIE ↔ GENRES
-- ============================================================

-- 1  The Shawshank Redemption
INSERT INTO movie_genres (movie_id, genre_id) SELECT 1, id FROM genres WHERE name IN ('Drama');
-- 2  The Dark Knight
INSERT INTO movie_genres (movie_id, genre_id) SELECT 2, id FROM genres WHERE name IN ('Action', 'Crime', 'Drama', 'Thriller');
-- 3  Inception
INSERT INTO movie_genres (movie_id, genre_id) SELECT 3, id FROM genres WHERE name IN ('Action', 'Adventure', 'Sci-Fi', 'Thriller');
-- 4  Pulp Fiction
INSERT INTO movie_genres (movie_id, genre_id) SELECT 4, id FROM genres WHERE name IN ('Crime', 'Drama');
-- 5  Forrest Gump
INSERT INTO movie_genres (movie_id, genre_id) SELECT 5, id FROM genres WHERE name IN ('Drama', 'Romance');
-- 6  Gladiator
INSERT INTO movie_genres (movie_id, genre_id) SELECT 6, id FROM genres WHERE name IN ('Action', 'Adventure', 'Drama');
-- 7  The Matrix
INSERT INTO movie_genres (movie_id, genre_id) SELECT 7, id FROM genres WHERE name IN ('Action', 'Sci-Fi');
-- 8  Interstellar
INSERT INTO movie_genres (movie_id, genre_id) SELECT 8, id FROM genres WHERE name IN ('Adventure', 'Drama', 'Sci-Fi');
-- 9  The Lord of the Rings: The Return of the King
INSERT INTO movie_genres (movie_id, genre_id) SELECT 9, id FROM genres WHERE name IN ('Action', 'Adventure', 'Drama', 'Fantasy');
-- 10 The Lion King
INSERT INTO movie_genres (movie_id, genre_id) SELECT 10, id FROM genres WHERE name IN ('Animation', 'Adventure', 'Drama', 'Family');
-- 11 The Avengers
INSERT INTO movie_genres (movie_id, genre_id) SELECT 11, id FROM genres WHERE name IN ('Action', 'Adventure', 'Sci-Fi');
-- 12 Jurassic Park
INSERT INTO movie_genres (movie_id, genre_id) SELECT 12, id FROM genres WHERE name IN ('Adventure', 'Sci-Fi');
-- 13 Titanic
INSERT INTO movie_genres (movie_id, genre_id) SELECT 13, id FROM genres WHERE name IN ('Drama', 'Romance');
-- 14 The Social Network
INSERT INTO movie_genres (movie_id, genre_id) SELECT 14, id FROM genres WHERE name IN ('Biography', 'Drama');
-- 15 Avatar
INSERT INTO movie_genres (movie_id, genre_id) SELECT 15, id FROM genres WHERE name IN ('Action', 'Adventure', 'Fantasy', 'Sci-Fi');

-- ============================================================
-- SEED: PERSONS (directors + principal actors for 3 movies)
-- ============================================================

-- Directors
INSERT INTO persons (name, country, birthdate, deathdate, biography, photo) VALUES
('Christopher Nolan', 'United Kingdom', '1970-07-30', NULL,
 'British-American filmmaker known for his cerebral, often nonlinear storytelling.',
 'https://m.media-amazon.com/images/M/MV5BNjE3NDQyOTYyMV5BMl5BanBnXkFtZTcwODcyODU2Mw@@._V1_.jpg');
-- id = 1

-- The Dark Knight actors
INSERT INTO persons (name, country, birthdate, deathdate, biography, photo) VALUES
('Christian Bale', 'United Kingdom', '1974-01-30', NULL,
 'Welsh actor known for his versatility and intense method acting.',
 'https://m.media-amazon.com/images/M/MV5BMTkxMzk4MjQ4MF5BMl5BanBnXkFtZTcwMzExODQxOA@@._V1_.jpg'),
-- id = 2

('Heath Ledger', 'Australia', '1979-04-04', '2008-01-22',
 'Australian actor and music video director, best known for his iconic portrayal of the Joker.',
 'https://m.media-amazon.com/images/M/MV5BMTI2NTY0NzA4MF5BMl5BanBnXkFtZTYwMjE1MDE0._V1_.jpg'),
-- id = 3

('Aaron Eckhart', 'United States', '1968-03-12', NULL,
 'American actor known for his roles in dramatic and action films.',
 'https://m.media-amazon.com/images/M/MV5BMTc4MTAyNzMzNF5BMl5BanBnXkFtZTcwMzQ5MzQzMg@@._V1_.jpg'),
-- id = 4

('Gary Oldman', 'United Kingdom', '1958-03-21', NULL,
 'English actor and filmmaker renowned for his range and powerful character portrayals.',
 'https://m.media-amazon.com/images/M/MV5BMTc3NTM4MzQ5MV5BMl5BanBnXkFtZTcwOTE2MDMxMw@@._V1_.jpg');
-- id = 5

-- Inception actors
INSERT INTO persons (name, country, birthdate, deathdate, biography, photo) VALUES
('Leonardo DiCaprio', 'United States', '1974-11-11', NULL,
 'American actor and film producer known for his work in biopics and period films.',
 'https://m.media-amazon.com/images/M/MV5BMjI0MTg3MzI0M15BMl5BanBnXkFtZTcwMzQyODU2Mw@@._V1_.jpg'),
-- id = 6

('Joseph Gordon-Levitt', 'United States', '1981-02-17', NULL,
 'American actor and filmmaker who transitioned from child star to leading man.',
 'https://m.media-amazon.com/images/M/MV5BMTY3NTk0NDI3Ml5BMl5BanBnXkFtZTgwNDA3NjY0MjE@._V1_.jpg'),
-- id = 7

('Tom Hardy', 'United Kingdom', '1977-09-15', NULL,
 'English actor known for his physical transformations and intense performances.',
 'https://m.media-amazon.com/images/M/MV5BMTQ3ODEyNjA4Nl5BMl5BanBnXkFtZTcwNDExOTc3NA@@._V1_.jpg'),
-- id = 8

('Elliot Page', 'Canada', '1987-02-21', NULL,
 'Canadian actor and producer known for dramatic and indie film roles.',
 'https://m.media-amazon.com/images/M/MV5BMjMxODY3NjUxNl5BMl5BanBnXkFtZTgwNTQ4NjgxOTE@._V1_.jpg');
-- id = 9

-- Interstellar actors
INSERT INTO persons (name, country, birthdate, deathdate, biography, photo) VALUES
('Matthew McConaughey', 'United States', '1969-11-04', NULL,
 'American actor known for romantic comedies and later acclaimed dramatic roles.',
 'https://m.media-amazon.com/images/M/MV5BMTg0MDc3MDUwNl5BMl5BanBnXkFtZTcwMTk2NjY4Nw@@._V1_.jpg'),
-- id = 10

('Anne Hathaway', 'United States', '1982-11-12', NULL,
 'American actress known for her work in blockbusters and independent films alike.',
 'https://m.media-amazon.com/images/M/MV5BNjQ5MTAxMDc5OF5BMl5BanBnXkFtZTcwOTI0OTE4OA@@._V1_.jpg'),
-- id = 11

('Jessica Chastain', 'United States', '1977-03-24', NULL,
 'American actress and producer known for her roles in drama and thriller films.',
 'https://m.media-amazon.com/images/M/MV5BMTU1MDM5NjczOF5BMl5BanBnXkFtZTcwOTY2MDE4OA@@._V1_.jpg'),
-- id = 12

('Michael Caine', 'United Kingdom', '1933-03-14', NULL,
 'English actor known for a career spanning over seven decades and two Academy Awards.',
 'https://m.media-amazon.com/images/M/MV5BMjAwNzIwNTQ4Ml5BMl5BanBnXkFtZTYwOTMwMTk2._V1_.jpg');
-- id = 13

-- ============================================================
-- SEED: MOVIE ↔ PERSONS (directors + actors)
-- ============================================================

-- The Dark Knight (movie_id = 2)
INSERT INTO movie_persons (movie_id, person_id, role) VALUES
(2, 1, 'director'),
(2, 2, 'actor'),
(2, 3, 'actor'),
(2, 4, 'actor'),
(2, 5, 'actor');

-- Inception (movie_id = 3)
INSERT INTO movie_persons (movie_id, person_id, role) VALUES
(3, 1, 'director'),
(3, 6, 'actor'),
(3, 7, 'actor'),
(3, 8, 'actor'),
(3, 9, 'actor'),
(3, 5, 'actor'),
(3, 13, 'actor');

-- Interstellar (movie_id = 8)
INSERT INTO movie_persons (movie_id, person_id, role) VALUES
(8, 1, 'director'),
(8, 10, 'actor'),
(8, 11, 'actor'),
(8, 12, 'actor'),
(8, 13, 'actor');

-- ============================================================
-- SEED: USER
-- ============================================================

SET @user1_id = UUID();
INSERT INTO users (id, username, email, password) VALUES
(UUID_TO_BIN(@user1_id), 'cinephile_dave', 'dave@example.com', '$2b$10$examplehashedpasswordvalue1234567890abc');

-- ============================================================
-- SEED: REVIEWS (3 reviews by cinephile_dave)
-- ============================================================

INSERT INTO reviews (movie_id, user_id, review, rating) VALUES
(2, UUID_TO_BIN(@user1_id),
 'Heath Ledger''s Joker is one of the greatest performances ever committed to film. The tension never lets up. A masterpiece.',
 9.5);

INSERT INTO reviews (movie_id, user_id, review, rating) VALUES
(3, UUID_TO_BIN(@user1_id),
 'Mind-bending and visually stunning. Nolan layers dreams within dreams and somehow keeps it all coherent. The hallway fight is legendary.',
 9.0);

INSERT INTO reviews (movie_id, user_id, review, rating) VALUES
(8, UUID_TO_BIN(@user1_id),
 'Interstellar made me cry in a movie theater for the first time. The docking scene alone is worth the ticket price. Hans Zimmer went off.',
 8.5);

-- ============================================================
-- SEED: WATCHLIST (cinephile_dave)
-- ============================================================

INSERT INTO watchlists (user_id, movie_id) VALUES
(UUID_TO_BIN(@user1_id), 1),
(UUID_TO_BIN(@user1_id), 4),
(UUID_TO_BIN(@user1_id), 7),
(UUID_TO_BIN(@user1_id), 9);
