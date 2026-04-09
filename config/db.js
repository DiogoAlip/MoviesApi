import "dotenv/config";
import { createConnection } from "mysql2/promise";

export const DbConection = async (obj = {}) => {
  return await createConnection({
    host: process.env.MYSQL_HOST || "localhost",
    user: "root",
    port: process.env.MYSQL_PORT || 3306,
    password: process.env.MYSQL_ROOT_PASSWORD || "rootpassword",
    database: process.env.MYSQL_DATABASE || "movie_api_db",
    ...obj,
  });
};
