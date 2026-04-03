import express from "express";
import { middleare } from "./middleware/middleware.js";

const PORT = process.env.PORT || 1313;

const app = express();

app.use(middleare);

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(PORT, (error) => {
  if (error) return console.error(error);
  console.log(`Server is running on port: http://localhost:${PORT}`);
});
