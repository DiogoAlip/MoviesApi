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

    const [response] = await conexion.query(sqlQuery);
    return {
      success: true,
      message: "Database seeded successfully",
      data: response,
    };
  } catch (error) {
    return {
      success: false,
      message: error.sqlMessage,
      data: null,
    };
  } finally {
    if (conexion) {
      await conexion.end();
    }
  }
}
