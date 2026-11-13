import z from "zod";

const movieSchema = z.object({
  title: z.string().min(3, "Title is required"),
  year: z
    .number()
    .int()
    .min(1900, "Year must be 1888 or later")
    .max(new Date().getFullYear(), "Year cannot be in the future"),
  duration: z.number().int().positive("Duration must be a positive integer"),
  rate: z
    .number()
    .min(0, "Rate must be at least 0")
    .max(10, "Rate cannot be more than 10"),
  poster: z.url({
    message: "Poster must be a valid URL",
  }),
  synopsis: z
    .string()
    .min(10, "Synopsis must be at least 10 characters long")
    .max(300, "Synopsis cannot be more than 300 characters long"),
  genre: z.array(
    z.enum(
      [
        "Action",
        "Comedy",
        "Drama",
        "Horror",
        "Sci-Fi",
        "Romance",
        "Crime",
        "Adventure",
        "Animation",
        "Documental",
        "Biography",
        "Fantasy",
        "Thriller",
        "Horror",
        "Mystery",
        "Musical",
        "War",
        "Western",
        "Family",
        "Sport",
        "History",
      ],
      {
        required_error: "Genre is required",
        invalid_type_error:
          "Genre must be one of the following: Action, Comedy, Drama, Horror, Sci-Fi, Romance, Crime, Adventure, Animation, Documental, Biography, Fantasy, Thriller, Horror, Mystery, Musical, War, Western, Family, Sport, History",
      },
    ),
  ),
});

export function validateMovie(movie) {
  return movieSchema.safeParse(movie);
}

export function validatePartialMovie(movie) {
  return movieSchema.partial().safeParse(movie);
}
