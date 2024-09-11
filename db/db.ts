import { drizzle } from "drizzle-orm/node-postgres";
import * as schema from './schema';
import pg from 'pg';

export const client = new pg.Client({
    host: process.env.HOST,
    port: process.env.PORT_DB ? parseInt(process.env.PORT_DB, 10) : undefined,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
  });
await client.connect();
export const db = drizzle(client, { schema });

console.log("db")
// await db.insert(schema.tasks).values({ title: "To pierwszy dodany task !!!!", userId: "user_2kn7I17uFtEL9SufHwIM8p7I7jE"});