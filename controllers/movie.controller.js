export class MovieController {
  static getALlMovies(req, res) {
    const { id } = req.params;
    const movie = MovieModel.getMovieById(id);
    if (!movie) return res.status(404).json({ message: "Movie not found" });
    res.json(movie);
  }

  static getMovieById(req, res) {
    const { id } = req.params;
    const movie = MovieModel.getMovieById(id);
    if (!movie) return res.status(404).json({ message: "Movie not found" });
    res.json(movie);
  }

  static createMovie(req, res) {
    const body = req.body;
    const bodyValidation = validateMovie(body);
    if (bodyValidation.error)
      return res.status(400).json({ message: bodyValidation.error.message });
    res.status(201).json(MovieModel.createMovie(body));
  }

  static updateMovie(req, res) {
    const { id } = req.params;
    const body = req.body;
    const partialBodyValidation = validatePartialMovie(body);
    if (partialBodyValidation.error)
      return res
        .status(400)
        .json({ message: partialBodyValidation.error.message });
    res.status(200).json(MovieModel.updateMovie(id, body));
  }

  static deleteMovie(req, res) {
    const { id } = req.params;
  }
}
