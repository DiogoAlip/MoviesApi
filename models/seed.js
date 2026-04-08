import mysql from "mysql2/promise";
import fs from "fs";
import path from "path";

async function correrSeed() {
  let conexion;

  try {
    conexion = await mysql.createConnection({
      host: "localhost",
      user: "tu_usuario",
      password: "tu_password",
      database: "tu_base_de_datos",
      multipleStatements: true,
    });

    console.log("✅ Conectado a la base de datos.");

    const rutaArchivo = path.join(__dirname, "datos_iniciales.sql");
    const sqlQuery = fs.readFileSync(rutaArchivo, "utf8");

    console.log("⏳ Ejecutando las consultas del archivo SQL...");

    await conexion.query(sqlQuery);

    console.log("🎉 ¡Seed ejecutado con éxito!");
  } catch (error) {
    console.error(error);
  } finally {
    if (conexion) {
      await conexion.end();
    }
  }
}

correrSeed();
