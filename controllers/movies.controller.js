import {
  validateMovie,
  validatePartialMovie,
} from "../schemas/movie.schema.js";
import { isObjectEmpty } from "../utils/isObjectEmpty.utils.js";

export class MoviesController {
  constructor({ moviesModel }) {
    this.moviesModel = moviesModel;
  }

  getAllMovies = async (req, res) => {
    const query = req.query;
    const { success, error } = validatePartialMovie({
      rate: parseFloat(query.rate) || undefined,
      year: parseInt(query.year) || undefined,
      duration: parseInt(query.duration) || undefined,
      genre: query.genre ? query.genre.split(",") : undefined,
    });

    if (!success) {
      return res
        .status(400)
        .json({ success, message: JSON.parse(error.message) });
    }
    const movie = await this.moviesModel.getAllMovies({
      title: query.title,
      rate: query.rate,
      year: query.year,
      duration: query.duration,
      genre: query.genre,
    });
    if (!movie)
      return res
        .status(404)
        .json({ success: false, message: "Movie not found" });
    res.json(movie);
  };

  getMovieById = async (req, res) => {
    const { id } = req.params;
    const movie = await this.moviesModel.getMovieById(id);
    if (isObjectEmpty(movie))
      return res
        .status(404)
        .json({ success: false, message: "Movie not found" });
    res.json(movie);
  };

  createMovie = async (req, res) => {
    const body = req.body;
    const bodyValidation = validateMovie(body);
    if (bodyValidation.error)
      return res.status(400).json({ message: bodyValidation.error.message });
    const createdMovie = await this.moviesModel.createMovie(body);
    if (isObjectEmpty(createdMovie))
      return res
        .status(500)
        .json({ success: false, message: "Error creating movie" });
    res.status(201).json(createdMovie);
  };

  updateMovie = async (req, res) => {
    const { id } = req.params;
    const body = req.body;
    const partialBodyValidation = validatePartialMovie(body);
    if (partialBodyValidation.error)
      return res
        .status(400)
        .json({ message: partialBodyValidation.error.message });
    const movieExists = await this.moviesModel.getMovieById(id);
    if (isObjectEmpty(movieExists))
      return res.status(404).json({ message: "Movie not found" });
    const bodyValues = Object.values(body);
    const existedValues = Object.values(movieExists);
    const isThereDataToUpdate = bodyValues.every((value) =>
      existedValues.includes(value),
    );
    if (isThereDataToUpdate)
      return res.status(400).json({ message: "No value to update" });
    const movieUpdated = await this.moviesModel.updateMovie(id, body);
    res.status(200).json(movieUpdated);
  };

  deleteMovie = async (req, res) => {
    const { id } = req.params;
    const deletedMovie = await this.moviesModel.deleteMovie(id);
    if (isObjectEmpty(deletedMovie))
      return res.status(404).json({ message: "Movie not found" });
    return res.status(200).json(deletedMovie);
  };
}
