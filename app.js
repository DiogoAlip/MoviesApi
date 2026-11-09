import express from "express";
import { middleare } from "./middleware/middleware.js";
import { createMovieRouter } from "./routes/movie.routes.js";
import { createSeedRouter } from "./routes/seed.routes.js";

export const createApp = ({ moviesModel }) => {
  const PORT = process.env.PORT || 1313;

  const jsonParser = express.json();

  const app = express();

  app.disable("x-powered-by");

  app.use(middleare);

  const moviesRouter = createMovieRouter({ moviesModel });
  const seedRouter = createSeedRouter();
  //const watchlistRouter = createWatchlistRouter({ watchlistModel });
  //const reviewsRouter = createReviewsRouter({ reviewsModel });
  //const genresRouter = createGenresRouter({ genresModel });
  //const authRouter = createAuthRouter({ usersModel });
  //const personalRouter = createPersonalRouter({ personalModel });

  app.use("/movies", jsonParser, moviesRouter);

  app.use("/seed", seedRouter);

  app.listen(PORT, (error) => {
    if (error) return console.error(error);
    console.log(`Server is running on port: http://localhost:${PORT}`);
  });
};
