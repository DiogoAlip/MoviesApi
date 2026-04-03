import z from "zod";

const movieSchema = z.object({
  title: z.string().min(1, "Title is required"),
  year: z
    .number()
    .int()
    .min(1900, "Year must be 1888 or later")
    .max(new Date().getFullYear(), "Year cannot be in the future"),
  director: z.string().min(1, "Director is required"),
  duration: z.number().int().positive("Duration must be a positive integer"),
  rate: z
    .number()
    .min(0, "Rate must be at least 0")
    .max(10, "Rate cannot be more than 10"),
  poster: z.url({
    message: "Poster must be a valid URL",
  }),
  genre: z.array(
    z.enum(["Action", "Comedy", "Drama", "Horror", "Sci-Fi", "Romance"], {
      required_error: "Genre is required",
      invalid_type_error:
        "Genre must be one of the following: Action, Comedy, Drama, Horror, Sci-Fi, Romance",
    }),
  ),
});

export function validateMovie(movie) {
  return movieSchema.safeParse(movie);
}

export function validatePartialMovie(movie) {
  return movieSchema.partial().safeParse(movie);
}
