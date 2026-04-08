import "dotenv/config";
import mysql from "mysql2/promise";

const config = {
  host: process.env.MYSQL_HOST || "localhost",
  user: "root",
  port: process.env.MYSQL_PORT || 3306,
  password: process.env.MYSQL_ROOT_PASSWORD || "rootpassword",
  database: process.env.MYSQL_DATABASE || "movie_api_db",
};

const connection = await mysql.createConnection(config);

import { readJSON } from "../utils/readJSON.utils.js";
import { randomUUID } from "crypto";

const movies = await readJSON("./movies.json");

export class MoviesModel {
  static getAllMovies({ genre }) {
    if (genre) {
      return movies.filter((movie) =>
        movie.genre.some((g) => g.toLowerCase() === genre.toLowerCase()),
      );
    }
    return movies;
  }

  static getMovieById(id) {
    const movie = movies.find((movie) => movie.id === id);
    return movie;
  }

  static createMovie(movieData) {
    const newMovie = {
      id: randomUUID(),
      ...movieData,
    };

    movies.push(newMovie);
    return newMovie;
  }

  static updateMovie(id, movieData) {
    const movieIndex = movies.findIndex((movie) => movie.id === id);
    if (movieIndex) return null;

    movies[movieIndex] = {
      ...movies[movieIndex],
      ...movieData,
    };

    return movies[movieIndex];
  }

  static deleteMovie(id) {
    const movieIndex = movies.findIndex((movie) => movie.id === id);
    if (movieIndex) return null;

    const filteredMovie = movies.splice(movieIndex, 1);
    return movies[movieIndex];
  }
}
