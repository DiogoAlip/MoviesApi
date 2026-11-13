import { DbConection } from "../config/db.js";

const connection = await DbConection();

export class MoviesModel {
  static async getAllMovies(req) {
    const joins = [];
    const conditions = [];
    const params = [];

    joins.push(`
        LEFT JOIN movie_genres mg ON mg.movie_id = m.id
        LEFT JOIN genres g ON g.id = mg.genre_id
        `);

    if (req?.genre) {
      conditions.push("g.name = ?");
      params.push(req.genre);
    }

    if (req?.title) {
      conditions.push("title LIKE ? ");
      params.push(`%${req.title}%`);
    }

    if (req?.year) {
      conditions.push("year = ?");
      params.push(req.year);
    }

    if (req?.rate) {
      conditions.push("rate >= ?");
      params.push(req.rate);
    }

    if (req?.duration) {
      conditions.push("duration = ?");
      params.push(req.duration);
    }

    params.push(req.limit ?? 20);
    params.push(req.offset ?? 0);

    const [result] = await connection.query(
      `
    SELECT m.id, m.title, m.year, m.duration, m.poster, m.rate, m.synopsis, GROUP_CONCAT(g.name ORDER BY g.name SEPARATOR ", " ) AS genres FROM movies m
    ${joins.length > 0 ? `\n ${joins.join(" AND ")}` : ""}
    ${conditions.length > 0 ? `\n WHERE ${conditions.join(" AND ")}` : ""}
    GROUP BY m.id, m.title, m.year, m.duration, m.poster, m.rate, m.synopsis
    LIMIT ? OFFSET ?
    `,
      params,
    );
    return result;
  }

  static async getMovieById(id) {
    const [result] = await connection.query(
      "SELECT id, title, year, duration, poster, rate, synopsis FROM movies WHERE id = ?;",
      [id],
    );
    return result[0];
  }

  static async createMovie(movieData) {
    const { title, year, duration, poster, rate, synopsis, genre } = movieData;

    const movieExists = await MoviesModel.getAllMovies({ title });

    if (movieExists.length > 0 || !genre || genre.length === 0) {
      return {};
    }

    await connection.query(
      "INSERT INTO movies ( title, year, duration, poster, rate, synopsis ) VALUES ( ?, ?, ?, ?, ?, ?)",
      [title, year, duration, poster, rate, synopsis],
    );

    const [movieCreated] = await MoviesModel.getAllMovies({ title });

    const [genresList] = await connection.query(
      "SELECT id FROM genres WHERE name IN(?)",
      [genre],
    );

    await connection.query(
      "INSERT INTO movie_genres (movie_id, genre_id) VALUES ?",
      [genresList.map((g) => [movieCreated.id, g.id])],
    );

    return movieCreated;
  }

  static async updateMovie(id, movieData) {
    const { title, year, duration, poster, rate, synopsis, genre } = movieData;

    await connection.query(
      "UPDATE movies SET title = COALESCE(?, title), year = COALESCE(?, year), duration = COALESCE(?, duration), poster = COALESCE(?, poster), rate = COALESCE(?, rate), synopsis = COALESCE(?, synopsis) WHERE id = ?",
      [title, year, duration, poster, rate, synopsis, id],
    );

    if (genre && genre.length > 0) {
      const [genresList] = await connection.query(
        "SELECT id FROM genres WHERE name IN(?)",
        [genre],
      );

      await connection.query("DELETE FROM movie_genres WHERE movie_id = ?", [
        id,
      ]);

      await connection.query(
        "INSERT INTO movie_genres (movie_id, genre_id) VALUES ?",
        [genresList.map((g) => [id, g.id])],
      );
    }

    return await MoviesModel.getMovieById(id);
  }

  static async deleteMovie(id) {
    const movie = await MoviesModel.getMovieById(id);
    if (!movie) {
      return {};
    }

    await connection.query("DELETE FROM movies WHERE id = ?", [id]);
    return movie;
  }
}
