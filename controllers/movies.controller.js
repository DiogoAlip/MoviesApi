import { MoviesModel } from "../models/movies.model.js";

export class MoviesController {
  static async getAllMovies(req, res) {
    const { genre } = req.query;
    const movie = await MoviesModel.getAllMovies({ genre });
    if (!movie) return res.status(404).json({ message: "Movie not found" });
    res.json(movie);
  }

  static async getMovieById(req, res) {
    const { id } = req.params;
    const movie = await MoviesModel.getMovieById(id);
    if (!movie) return res.status(404).json({ message: "Movie not found" });
    res.json(movie);
  }

  static createMovie(req, res) {
    const body = req.body;
    const bodyValidation = validateMovie(body);
    if (bodyValidation.error)
      return res.status(400).json({ message: bodyValidation.error.message });
    res.status(201).json(MoviesModel.createMovie(body));
  }

  static updateMovie(req, res) {
    const { id } = req.params;
    const body = req.body;
    const partialBodyValidation = validatePartialMovie(body);
    if (partialBodyValidation.error)
      return res
        .status(400)
        .json({ message: partialBodyValidation.error.message });
    res.status(200).json(MoviesModel.updateMovie(id, body));
  }

  static deleteMovie(req, res) {
    const { id } = req.params;
    const deletedMovie = MoviesModel.deleteMovie(id);
    if (!deletedMovie)
      return res.status(404).json({ message: "Movie not found" });
    return res.status(200).json(deletedMovie);
  }
}
