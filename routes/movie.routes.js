import { Router } from "express";
import { MoviesController } from "../controllers/movies.controller.js";

export const createMovieRouter = ({ moviesModel }) => {
  const moviesRouter = Router();

  const moviesController = new MoviesController({
    moviesModel,
  });

  moviesRouter.get("/", moviesController.getAllMovies);
  moviesRouter.get("/:id", moviesController.getMovieById);
  moviesRouter.post("/", moviesController.createMovie);
  moviesRouter.patch("/:id", moviesController.updateMovie);
  moviesRouter.delete("/:id", moviesController.deleteMovie);

  return moviesRouter;
};
