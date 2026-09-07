import { validatePartialMovie } from "../schemas/movie.schema.js";
import { DbConection } from "../config/db.js";
import { readJSON } from "../utils/readJSON.utils.js";
import { randomUUID } from "crypto";

const connection = await DbConection();
const movies = await readJSON("./movies.json");

export class MoviesModel {
  static async getAllMovies(req) {
    const { success } = validatePartialMovie({
      ...req,
      rate: parseFloat(req.rate) || undefined,
      year: parseInt(req.year) || undefined,
      duration: parseInt(req.duration) || undefined,
      genre: req.genre ? req.genre.split(",") : undefined,
    });
    console.log(success);
    const [result] = await connection.query(
      "SELECT BIN_TO_UUID(id) id, title, year, director, duration, poster, rate FROM movies",
    );
    return result;
  }

  static async getMovieById(id) {
    const [result] = await connection.query(
      "SELECT BIN_TO_UUID(id) id, title, year, director, duration, poster, rate FROM movies WHERE id = UUID_TO_BIN(?);",
      [id],
    );
    return result[0];
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
