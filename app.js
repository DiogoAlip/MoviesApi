import express from "express";
import { middleare } from "./middleware/middleware.js";
import { moviesRouter } from "./routes/movie.routes.js";
import { seed } from "./database/seed.js";

const PORT = process.env.PORT || 1313;

const jsonParser = express.json();

const app = express();

app.disable("x-powered-by");

app.use(middleare);

app.use("/movies", jsonParser, moviesRouter);

app.get("/seed", seed);

app.listen(PORT, (error) => {
  if (error) return console.error(error);
  console.log(`Server is running on port: http://localhost:${PORT}`);
});
