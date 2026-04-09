CREATE DATABASE IF NOT EXISTS movie_api_db;
USE movie_api_db;

DROP TABLE IF EXISTS movie_genres;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS genres;

CREATE TABLE movies (
    id BINARY(16) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    director VARCHAR(255) NOT NULL,
    duration INT NOT NULL,
    poster TEXT,
    rate DECIMAL(2,1) NOT NULL
);

CREATE TABLE genres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE movie_genres (
    movie_id BINARY(16),
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

INSERT INTO genres (name) VALUES 
('Drama'), ('Action'), ('Crime'), ('Adventure'), ('Sci-Fi'), 
('Romance'), ('Animation'), ('Biography'), ('Fantasy');

SET @movie1_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie1_id), 'The Shawshank Redemption', 1994, 'Frank Darabont', 142, 'https://i.ebayimg.com/images/g/4goAAOSwMyBe7hnQ/s-l1200.webp', 9.3);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie1_id), id FROM genres WHERE name IN ('Drama');

SET @movie2_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie2_id), 'The Dark Knight', 2008, 'Christopher Nolan', 152, 'https://i.ebayimg.com/images/g/yokAAOSw8w1YARbm/s-l1200.jpg', 9.0);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie2_id), id FROM genres WHERE name IN ('Action', 'Crime', 'Drama');

SET @movie3_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie3_id), 'Inception', 2010, 'Christopher Nolan', 148, 'https://m.media-amazon.com/images/I/91Rc8cAmnAL._AC_UF1000,1000_QL80_.jpg', 8.8);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie3_id), id FROM genres WHERE name IN ('Action', 'Adventure', 'Sci-Fi');

SET @movie4_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie4_id), 'Pulp Fiction', 1994, 'Quentin Tarantino', 154, 'https://www.themoviedb.org/t/p/original/vQWk5YBFWF4bZaofAbv0tShwBvQ.jpg', 8.9);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie4_id), id FROM genres WHERE name IN ('Crime', 'Drama');

SET @movie5_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie5_id), 'Forrest Gump', 1994, 'Robert Zemeckis', 142, 'https://i.ebayimg.com/images/g/qR8AAOSwkvRZzuMD/s-l1600.jpg', 8.8);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie5_id), id FROM genres WHERE name IN ('Drama', 'Romance');

SET @movie6_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie6_id), 'Gladiator', 2000, 'Ridley Scott', 155, 'https://img.fruugo.com/product/0/60/14417600_max.jpg', 8.5);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie6_id), id FROM genres WHERE name IN ('Action', 'Adventure', 'Drama');

SET @movie7_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie7_id), 'The Matrix', 1999, 'Lana Wachowski', 136, 'https://i.ebayimg.com/images/g/QFQAAOSwAQpfjaA6/s-l1200.jpg', 8.7);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie7_id), id FROM genres WHERE name IN ('Action', 'Sci-Fi');

SET @movie8_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie8_id), 'Interstellar', 2014, 'Christopher Nolan', 169, 'https://m.media-amazon.com/images/I/91obuWzA3XL._AC_UF1000,1000_QL80_.jpg', 8.6);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie8_id), id FROM genres WHERE name IN ('Adventure', 'Drama', 'Sci-Fi');

SET @movie9_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie9_id), 'The Lord of the Rings: The Return of the King', 2003, 'Peter Jackson', 201, 'https://i.ebayimg.com/images/g/0hoAAOSwe7peaMLW/s-l1600.jpg', 8.9);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie9_id), id FROM genres WHERE name IN ('Action', 'Adventure', 'Drama');

SET @movie10_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie10_id), 'The Lion King', 1994, 'Roger Allers, Rob Minkoff', 88, 'https://m.media-amazon.com/images/I/81BMmrwSFOL._AC_UF1000,1000_QL80_.jpg', 8.5);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie10_id), id FROM genres WHERE name IN ('Animation', 'Adventure', 'Drama');

SET @movie11_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie11_id), 'The Avengers', 2012, 'Joss Whedon', 143, 'https://img.fruugo.com/product/7/41/14532417_max.jpg', 8.0);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie11_id), id FROM genres WHERE name IN ('Action', 'Adventure', 'Sci-Fi');

SET @movie12_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie12_id), 'Jurassic Park', 1993, 'Steven Spielberg', 127, 'https://vice-press.com/cdn/shop/products/Jurassic-Park-Editions-poster-florey.jpg?v=1654518755&width=1024', 8.1);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie12_id), id FROM genres WHERE name IN ('Adventure', 'Sci-Fi');

SET @movie13_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie13_id), 'Titanic', 1997, 'James Cameron', 195, 'https://i.pinimg.com/originals/42/42/65/4242658e6f1b0d6322a4a93e0383108b.png', 7.8);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie13_id), id FROM genres WHERE name IN ('Drama', 'Romance');

SET @movie14_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie14_id), 'The Social Network', 2010, 'David Fincher', 120, 'https://i.pinimg.com/originals/7e/37/b9/7e37b994b613e94cba64f307b1983e39.jpg', 7.7);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie14_id), id FROM genres WHERE name IN ('Biography', 'Drama');

SET @movie15_id = UUID();
INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES 
(UUID_TO_BIN(@movie15_id), 'Avatar', 2009, 'James Cameron', 162, 'https://i.etsystatic.com/35681979/r/il/dfe3ba/3957859451/il_fullxfull.3957859451_h27r.jpg', 7.8);
INSERT INTO movie_genres (movie_id, genre_id) 
SELECT UUID_TO_BIN(@movie15_id), id FROM genres WHERE name IN ('Action', 'Adventure', 'Fantasy');
