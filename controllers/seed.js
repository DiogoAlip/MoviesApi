import { seed } from "../database/seed.js";

export const seedMovies = async (req, res) => {
  try {
    const result = await seed();
    console.log(result);
    if (result) {
      res.status(200).json({ message: "Seed executed" });
      return;
    }
    res.status(500).json({ message: "Error on seed executed" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error on seed executed" });
  }
};
