import type { Config } from "drizzle-kit";
import dotenv from "dotenv";

dotenv.config({
    path: ".env",
  });

export default ({
  dialect: "postgresql",
  schema: "./db/schema.ts",
  out: "./migrations",
  dbCredentials: {
    url: process.env.DRIZZLE_DATABASE_URL
  }
});
console.log("drizzle.config.ts")