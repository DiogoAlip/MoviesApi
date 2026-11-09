import { seed } from "../database/seed.js";
import { Router } from "express";

export const createSeedRouter = () => {
  const seedRouter = Router();

  seedRouter.get("/", async (req, res) => {
    const result = await seed();

    if (!result.success) {
      return res.status(500).json(result);
    }

    return res.status(200).json(result);
  });

  return seedRouter;
};
