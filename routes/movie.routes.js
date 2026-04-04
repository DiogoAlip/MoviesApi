import { Router } from "express";
import { MovieModel } from "../models/movies.model.js";

import {
  validateMovie,
  validatePartialMovie,
} from "../schemas/movie.schema.js";

export const moviesRouter = Router();

moviesRouter.get("/", (req, res) => {
  const { genre } = req.query;
  const movies = MovieModel.getALlMovies({ genre });
  res.json(movies);
});

moviesRouter.get("/:id", (req, res) => {
  const { id } = req.params;
  const movie = MovieModel.getMovieById(id);
  if (!movie) return res.status(404).json({ message: "Movie not found" });
  console.log(movie);
  res.json(movie);
});

moviesRouter.post("/", (req, res) => {
  const body = req.body;
  const bodyValidation = validateMovie(body);
  if (bodyValidation.error)
    return res.status(400).json({ message: bodyValidation.error.message });
  res.status(201).json(MovieModel.createMovie(body));
});

moviesRouter.patch("/:id", (req, res) => {
  const { id } = req.params;
  const body = req.body;
  const partialBodyValidation = validatePartialMovie(body);
  if (partialBodyValidation.error)
    return res
      .status(400)
      .json({ message: partialBodyValidation.error.message });
  res.status(200).json(MovieModel.updateMovie(id, body));
});
