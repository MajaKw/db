import { serial, text, timestamp, pgTable } from "drizzle-orm/pg-core";
export const users = pgTable("users", {
  id: serial("id"),
  name: text("name"),
});
export const tasks = pgTable("tasks", {
    id: serial("id"),
    name: text("name"),
  });