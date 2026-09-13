import { validatePartialMovie } from "../schemas/movie.schema.js";
import { DbConection } from "../config/db.js";
import { readJSON } from "../utils/readJSON.utils.js";
import { isObjectEmpty } from "../utils/isObjectEmpty.utils.js";
import { randomUUID } from "crypto";

const connection = await DbConection();
const movies = await readJSON("./movies.json");

export class MoviesModel {
  static async getAllMovies(req) {
    const { success, error } = validatePartialMovie({
      rate: parseFloat(req.rate) || undefined,
      year: parseInt(req.year) || undefined,
      duration: parseInt(req.duration) || undefined,
      genre: req.genre ? req.genre.split(",") : undefined,
    });

    if (!success) {
      return { success, message: JSON.parse(error.message) };
    }

    const joins = [];
    const conditions = [];
    const params = [];

    if (req?.genre) {
      joins.push(`
        INNER JOIN movie_genres mg ON mg.movie_id = movies.id
        INNER JOIN genres g ON g.id = mg.genre_id
        `);
      conditions.push("g.name = ?");
      params.push(req.genre);
    }

    if (req.year) {
      conditions.push("year = ?");
      params.push(req.year);
    }

    if (req.rate) {
      conditions.push("rate >= ?");
      params.push(req.rate);
    }

    if (req.duration) {
      conditions.push("duration = ?");
      params.push(req.duration);
    }
    const [result] = await connection.query(
      `
    SELECT BIN_TO_UUID(movies.id) id, movies.title, movies.year, movies.director, movies.duration, movies.poster, movies.rate FROM movies
    ${joins.length > 0 ? `\n ${joins.join(" AND ")}` : ""}
    ${conditions.length > 0 ? `\n WHERE ${conditions.join(" AND ")}` : ""}
    `,
      params,
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
