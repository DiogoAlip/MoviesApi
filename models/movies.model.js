import { DbConection } from "../config/db.js";
import { validate as uuidValidate } from "uuid";

const connection = await DbConection();

export class MoviesModel {
  static async getAllMovies(req) {
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
    if (!uuidValidate(id)) {
      return {};
    }

    const [result] = await connection.query(
      "SELECT BIN_TO_UUID(id) AS id, title, year, director, duration, poster, rate FROM movies WHERE id = UUID_TO_BIN(?);",
      [id],
    );
    return result[0];
  }

  static async createMovie(movieData) {
    const { title, year, director, duration, poster, rate } = movieData;

    const [resultByName] = await connection.query(
      "SELECT * FROM movies WHERE title = ?",
      [title],
    );

    if (resultByName[0]) {
      return {};
    }

    const [id] = await connection.query("SELECT UUID() AS id");
    const { id: newId } = id[0];

    await connection.query(
      "INSERT INTO movies (id, title, year, director, duration, poster, rate) VALUES (UUID_TO_BIN(?), ?, ?, ?, ?, ?, ?)",
      [newId, title, year, director, duration, poster, rate],
    );

    return await MoviesModel.getMovieById(newId);
  }

  static async updateMovie(id, movieData) {
    const { title, year, director, duration, poster, rate } = movieData;

    await connection.query(
      "UPDATE movies SET title = COALESCE(?, title), year = COALESCE(?, year), director = COALESCE(?, director), duration = COALESCE(?, duration), poster = COALESCE(?, poster), rate = COALESCE(?, rate) WHERE id = UUID_TO_BIN(?)",
      [title, year, director, duration, poster, rate, id],
    );

    return await MoviesModel.getMovieById(id);
  }

  static async deleteMovie(id) {
    const movie = await MoviesModel.getMovieById(id);
    if (!movie) {
      return {};
    }
    await connection.query("DELETE FROM movies WHERE id = UUID_TO_BIN(?)", [
      id,
    ]);
    return movie;
  }
}
