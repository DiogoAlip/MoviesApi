import { Router } from "express";
import { MoviesController } from "../controllers/movies.controller.js";
export const moviesRouter = Router();

moviesRouter.get("/", (req, res) => {
  MoviesController.getAllMovies(req, res);
});

moviesRouter.get("/:id", (req, res) => {
  MoviesController.getMovieById(req, res);
});

moviesRouter.post("/", (req, res) => {
  MoviesController.createMovie(req, res);
});

moviesRouter.patch("/:id", (req, res) => {
  MoviesController.updateMovie(req, res);
});

moviesRouter.delete("/:id", (req, res) => {
  MoviesController.deleteMovie(req, res);
});
