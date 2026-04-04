import path from "path";
import { readFile } from "fs/promises";

export const readJSON = async (filePath) => {
  const completePath = path.resolve(filePath);

  const jsonData = await readFile(completePath, "utf-8");
  return JSON.parse(jsonData);
};
