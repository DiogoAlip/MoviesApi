import { DbConection } from "../config/db.js";
import { readFileSync } from "fs";
import { join } from "path";

export async function seed() {
  let conexion;

  try {
    conexion = await DbConection({
      multipleStatements: true,
    });

    const rutaArchivo = join(import.meta.dirname, "database.sql");
    const sqlQuery = readFileSync(rutaArchivo, "utf8");

    await conexion.query(sqlQuery);
    return true;
  } catch (error) {
    console.error(error);
    return false;
  } finally {
    if (conexion) {
      await conexion.end();
    }
  }
}
